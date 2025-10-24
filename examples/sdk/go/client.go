package main

import (
	"context"
	"encoding/json"
	"log"

	pb "mcp-go-sdk/gen"
	"google.golang.org/grpc"
)

type MCPClient struct {
	conn   *grpc.ClientConn
	client pb.ToolServiceClient
}

func NewMCPClient(address string) (*MCPClient, error) {
	conn, err := grpc.Dial(address, grpc.WithInsecure())
	if err != nil {
		return nil, err
	}
	client := pb.NewToolServiceClient(conn)
	return &MCPClient{conn: conn, client: client}, nil
}

func (c *MCPClient) Invoke(ctx context.Context, tool string, input interface{}) (interface{}, error) {
	inputJson, _ := json.Marshal(input)
	req := &pb.InvokeRequest{
		Id:        "sdk-1",
		Tool:      tool,
		InputJson: inputJson,
	}
	resp, err := c.client.Invoke(ctx, req)
	if err != nil {
		return nil, err
	}
	var result interface{}
	json.Unmarshal(resp.OutputJson, &result)
	return result, nil
}

func (c *MCPClient) Close() {
	c.conn.Close()
}

func main() {
	client, err := NewMCPClient("localhost:50051")
	if err != nil {
		log.Fatal(err)
	}
	defer client.Close()

	result, err := client.Invoke(context.Background(), "get_time", map[string]interface{}{})
	if err != nil {
		log.Fatal(err)
	}
	log.Println(result)
}