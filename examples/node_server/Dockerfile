FROM node:20
WORKDIR /app
COPY examples/node_server/package.json ./
RUN npm install
COPY examples/node_server/ .
EXPOSE 8081
CMD ["node","server.js"]
