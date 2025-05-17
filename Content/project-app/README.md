# Rick & Morty Proxy API

This is a simple Node.js application using Express and Axios that acts as a proxy to the [Rick and Morty API](https://rickandmortyapi.com/). It provides a simplified and formatted view of characters and episodes from the show.

## Features

- ✅ Health check endpoint  
- 🧑‍🚀 Fetch characters by page or all characters  
- 🎲 Get a random character  
- 📺 Fetch episodes by page or all episodes  
- 🎭 Get characters that appear in a specific episode  

All responses (except for errors) are returned in **plain text** with JSON objects listed line by line.

---

## Getting Started

### Prerequisites

- Node.js (v14+ recommended)
- npm or yarn

### Installation

```
git clone https://github.com/your-username/rick-and-morty-proxy.git
cd rick-and-morty-proxy
npm install
```

### Running the App

```
npm start
```

By default, the server runs on `http://localhost:3000`, or a port defined in your environment variables.

---

## Running with Docker

You can run this project using Docker and Docker Compose for a consistent, containerized environment.

- **Node.js version:** The Docker image uses Node.js `22.13.1-slim`.
- **Exposed port:** The app runs on port `3000` inside the container and is mapped to port `3000` on your host.
- **Environment variables:** No required environment variables are set by default. You may provide a `.env` file if your setup needs custom configuration (uncomment the `env_file` line in `docker-compose.yml` if needed).

### Build and Run

From the project root directory, run:

```
docker compose up --build
```

This will build the Docker image and start the service as defined in `docker-compose.yml`.

- Access the API at: `http://localhost:3000`
- The container runs as a non-root user for improved security.

---

## API Endpoints

### Health Check

```
GET /health
```

Returns `"OK"` if the server is running.

---

### Characters

#### Get characters by page

```
GET /characters?page=1
```

Returns a list of character objects from the specified page.

#### Get all characters

```
GET /characters/all
```

Returns all characters from all pages. Might take a few seconds depending on API size.

#### Get character by ID

```
GET /character/:id
```

Returns the character object for a specific ID.

#### Get a random character

```
GET /random
```

Returns a randomly selected character.

---

### Episodes

#### Get episodes by page

```
GET /episodes?page=1
```

Returns episode `id` and `name` from the specified page.

#### Get all episodes

```
GET /episodes/all
```

Returns all episodes' `id` and `name`.

---

### Episode Characters

```
GET /episode/:episodeId/characters
```

Returns all characters that appear in the given episode.

---

## Response Format

All successful data responses are in **text/plain** and formatted like:

```
{"id":1,"name":"Rick Sanchez","status":"Alive","species":"Human","image":"https://..."}
{"id":2,"name":"Morty Smith","status":"Alive","species":"Human","image":"https://..."}
```

Each line represents one JSON object.

---

## Error Handling

If an error occurs (e.g., a character doesn't exist or the API is down), the server responds with:

```
{ "error": "Description of the problem" }
```

HTTP status codes are used appropriately (e.g., 404, 500).
