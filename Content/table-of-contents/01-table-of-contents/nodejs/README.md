# Node.js

![Node.js Logo](https://upload.wikimedia.org/wikipedia/commons/d/d9/Node.js_logo.svg)

## Table of Contents
1. [Introduction](#introduction)
2. [Key Features](#key-features)
3. [Usage](#usage)
4. [Examples](#examples)
5. [Resources](#resources)

---

## Introduction
Node.js lets you run JavaScript on the server. It’s great for building fast, scalable apps and APIs.

## Key Features
- Asynchronous and event-driven
- Fast with V8 engine
- Huge npm ecosystem
- Cross-platform

## Usage
- Web servers and APIs
- Real-time apps (chat, games)
- Command-line tools

## Examples
```javascript
// Simple HTTP server with Node.js
const http = require('http');
const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain');
  res.end('Hello, World!');
});
server.listen(3000, () => {
  console.log('Server running at http://localhost:3000/');
});
```

## Resources
- [Node.js Official Site](https://nodejs.org/)
- [MDN Node.js Guide](https://developer.mozilla.org/en-US/docs/Learn/Server-side/Node_server_without_framework)
- [W3Schools Node.js](https://www.w3schools.com/nodejs/)
