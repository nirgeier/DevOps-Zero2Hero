#!/bin/bash

# This script generates the demo for Github Copilot code style

# The demo folder for this demo
DEMO_FOLDER_NAME="/tmp/github-copilot-demo3"

# Load the color definitions
source ../../resources/scripts/colors.sh

# Create a new directory for the demo
echo -e "${YELLOW}* Creating a new directory for the demo...${NO_COLOR}"
rm    -rf $DEMO_FOLDER_NAME
mkdir -p  $DEMO_FOLDER_NAME

# Change to the demo directory
echo -e "${YELLOW}* Switching to the demo directory...${NO_COLOR}"
cd $DEMO_FOLDER_NAME

# 2. Create a new file in the demo directory
cat <<EOF >> $DEMO_FOLDER_NAME/demo03.js
// This Node.js program creates a simple HTTP server that sends "Hello World" as a response.
// Once running, the server can be tested by opening a web browser and 
// navigating to http://localhost:3000/.
// The server will respond with "Hello World".

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
EOF

# 3. Run the demo
echo -e "${YELLOW}* Running the demo...${NO_COLOR}"
node demo03.js &

# Wait for the server to start
sleep 3;

# 4. Test the demo
echo -e "${YELLOW}* Testing the demo...${NO_COLOR}"
curl -s http://localhost:3000/ 

