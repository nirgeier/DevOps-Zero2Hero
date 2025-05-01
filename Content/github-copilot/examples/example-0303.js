// This Node.js program creates a simple HTTP server that sends "Hello World" as a response.

// Import the http module
const http = require('http');

// Define the server and its request handler
const server = http.createServer((req, res) => {
  // Set the response HTTP header with HTTP status and Content type
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  // Send the response body "Hello World"
  res.end('Hello World\n');
});

// The server listens on port 3000
server.listen(3000, () => {
  console.log('Server running at http://localhost:3000/');
});

// Once running, the server can be tested by opening a web browser and 
// navigating to http://localhost:3000/.
// The server will respond with "Hello World".
