const express = require("express");
const axios = require("axios");

const app = express();
const port = process.env.PORT || 3000; // Use environment variable for port or default to 3000

const BASE_URL = "https://rickandmortyapi.com/api"; // Base URL for the Rick and Morty API

// Health check endpoint to verify the server is running
app.get("/health", (req, res) => {
    res.send("OK");
});

// Get all characters (with pagination)
app.get("/characters", async (req, res) => {
    try {
        const page = req.query.page || 1; // Default to page 1 if no page query parameter is provided
        const response = await axios.get(`${BASE_URL}/character/?page=${page}`);
        const characters = response.data.results.map(({ id, name, status, species, image }) => ({
            id,
            name,
            status,
            species,
            image,
        }));

        // Format the response as plain text
        const formatted = characters.reduce((acc, char) => acc + JSON.stringify(char) + '\n', '');
        res.setHeader('Content-Type', 'text/plain');
        res.send(formatted);
    } catch (error) {
        res.status(500).json({ error: "Failed to fetch characters" });
    }
});

// Get all characters across all pages
app.get("/characters/all", async (req, res) => {
    try {
        const firstPage = await axios.get(`${BASE_URL}/character`);
        const totalPages = firstPage.data.info.pages; // Total number of pages
        const allCharacterData = firstPage.data.results;

        // Fetch all pages sequentially
        for (let i = 2; i <= totalPages; i++) {
            const response = await axios.get(`${BASE_URL}/character?page=${i}`);
            allCharacterData.push(...response.data.results);
        }

        const characters = allCharacterData.map(({ id, name, status, species, image }) => ({
            id,
            name,
            status,
            species,
            image,
        }));

        // Format the response as plain text
        const formatted = characters.map(char => JSON.stringify(char)).join('\n');
        res.setHeader('Content-Type', 'text/plain');
        res.send(formatted);
    } catch (error) {
        res.status(500).json({ error: "Failed to fetch all characters" });
    }
});

// Get a specific character by ID
app.get("/character/:id", async (req, res) => {
    try {
        const { id } = req.params; // Extract character ID from the route parameter
        const response = await axios.get(`${BASE_URL}/character/${id}`);
        const { name, status, species, image } = response.data;

        // Return the character details as plain text
        res.setHeader('Content-Type', 'text/plain');
        res.send(JSON.stringify({ id, name, status, species, image }));
    } catch (error) {
        res.status(404).json({ error: "Character not found" });
    }
});

// Get a random character
app.get("/random", async (req, res) => {
    try {
        const meta = await axios.get(`${BASE_URL}/character`);
        const count = meta.data.info.count; // Total number of characters
        const randomId = Math.floor(Math.random() * count) + 1; // Generate a random ID
        const response = await axios.get(`${BASE_URL}/character/${randomId}`);
        const { id, name, status, species, image } = response.data;

        // Return the random character details as plain text
        res.setHeader('Content-Type', 'text/plain');
        res.send(JSON.stringify({ id, name, status, species, image }));
    } catch (error) {
        res.status(500).json({ error: "Failed to fetch random character" });
    }
});

// Get episodes by page (only return id and name)
app.get("/episodes", async (req, res) => {
    try {
        const page = req.query.page || 1; // Default to page 1 if no page query parameter is provided
        const response = await axios.get(`${BASE_URL}/episode?page=${page}`);
        const episodes = response.data.results.map(({ id, name }) => ({ id, name }));

        // Format the response as plain text
        const formatted = episodes.map(e => JSON.stringify(e)).join('\n');
        res.setHeader('Content-Type', 'text/plain');
        res.send(formatted);
    } catch (error) {
        res.status(500).json({ error: "Failed to fetch episodes" });
    }
});

// Get all episodes across all pages (id + name only)
app.get("/episodes/all", async (req, res) => {
    try {
        const firstPage = await axios.get(`${BASE_URL}/episode`);
        const totalPages = firstPage.data.info.pages; // Total number of pages
        const allEpisodeData = firstPage.data.results;

        // Fetch all pages concurrently
        const requests = [];
        for (let i = 2; i <= totalPages; i++) {
            requests.push(axios.get(`${BASE_URL}/episode?page=${i}`));
        }

        const results = await Promise.all(requests);
        results.forEach(r => allEpisodeData.push(...r.data.results));

        const episodes = allEpisodeData.map(({ id, name }) => ({ id, name }));

        // Format the response as plain text
        const formatted = episodes.map(e => JSON.stringify(e)).join('\n');
        res.setHeader('Content-Type', 'text/plain');
        res.send(formatted);
    } catch (error) {
        res.status(500).json({ error: "Failed to fetch all episodes" });
    }
});

// Get characters by episode
app.get("/episode/:episodeId/characters", async (req, res) => {
    try {
        const { episodeId } = req.params; // Extract episode ID from the route parameter
        const response = await axios.get(`${BASE_URL}/episode/${episodeId}`);
        const characterUrls = response.data.characters; // URLs of characters in the episode

        // Fetch character details concurrently
        const characters = await Promise.all(
            characterUrls.map(url => axios.get(url).then(res => res.data))
        );

        const formattedCharacters = characters.map(({ id, name, status, species, image }) => ({
            id,
            name,
            status,
            species,
            image,
        }));

        // Format the response as plain text
        const formatted = formattedCharacters.map(c => JSON.stringify(c)).join('\n');
        res.setHeader('Content-Type', 'text/plain');
        res.send(formatted);
    } catch (error) {
        res.status(500).json({ error: "Failed to fetch characters for the episode" });
    }
});

// Start server
app.listen(port, () => {
    console.log(`Rick & Morty Proxy API running at http://localhost:${port}`);
});
