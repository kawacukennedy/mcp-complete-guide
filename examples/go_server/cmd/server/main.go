package main

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net"
	"net/http"
	"os"

	"github.com/prometheus/client_golang/prometheus/promhttp"
	"go.opentelemetry.io/otel"
	"go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracegrpc"
	"go.opentelemetry.io/otel/sdk/trace"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"

	pb "mcp-go-server/gen"
)

type server struct {
	pb.UnimplementedToolServiceServer
}

func (s *server) Invoke(ctx context.Context, req *pb.InvokeRequest) (*pb.InvokeResponse, error) {
	// Simple tool dispatch
	var result map[string]interface{}
	switch req.Tool {
	case "get_time":
		result = map[string]interface{}{"time": "2023-10-24T12:00:00Z"}
	case "echo":
		json.Unmarshal(req.InputJson, &result)
	default:
		return &pb.InvokeResponse{Id: req.Id, ErrorCode: 404, ErrorMessage: "unknown_tool"}, nil
	}
	output, _ := json.Marshal(result)
	return &pb.InvokeResponse{Id: req.Id, OutputJson: output}, nil
}

func main() {
	// OTEL setup
	exp, _ := otlptracegrpc.New(context.Background())
	tp := trace.NewTracerProvider(trace.WithBatcher(exp))
	otel.SetTracerProvider(tp)
	defer tp.Shutdown(context.Background())

	// gRPC server
	lis, _ := net.Listen("tcp", ":50051")
	s := grpc.NewServer()
	pb.RegisterToolServiceServer(s, &server{})
	reflection.Register(s)

	// HTTP server for REST API, metrics, health
	mux := http.NewServeMux()
	mux.HandleFunc("/invoke", handleInvoke)
	mux.HandleFunc("/manifest", handleManifest)
	mux.HandleFunc("/healthz", func(w http.ResponseWriter, r *http.Request) { w.Write([]byte("ok")) })
	mux.Handle("/metrics", promhttp.Handler())

	go http.ListenAndServe(":8080", mux)
	go http.ListenAndServe(":9090", promhttp.Handler()) // metrics

	log.Println("gRPC server on :50051, HTTP on :8080")
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}

func handleInvoke(w http.ResponseWriter, r *http.Request) {
	// Simple JSON-RPC handler
	var req map[string]interface{}
	json.NewDecoder(r.Body).Decode(&req)
	tool := req["params"].(map[string]interface{})["tool"].(string)
	input := req["params"].(map[string]interface{})["input"]
	id := req["id"].(string)

	var result interface{}
	switch tool {
	case "get_time":
		result = map[string]string{"time": "2023-10-24T12:00:00Z"}
	case "echo":
		result = input
	default:
		http.Error(w, `{"error":"unknown_tool"}`, 400)
		return
	}
	resp := map[string]interface{}{"jsonrpc": "2.0", "id": id, "result": result}
	json.NewEncoder(w).Encode(resp)
}

func handleManifest(w http.ResponseWriter, r *http.Request) {
	manifest := map[string]interface{}{
		"mcp_version": "1.0.0",
		"capabilities": []map[string]interface{}{
			{"name": "get_time", "description": "Get UTC time"},
			{"name": "echo", "description": "Echo input"},
		},
	}
	json.NewEncoder(w).Encode(manifest)
}