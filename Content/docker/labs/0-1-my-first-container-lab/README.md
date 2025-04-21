<div align="left">
  <img src="/resources/images/docker-logo.png" alt="Docker" >
</div>

# Lab: My First Docker Container

Welcome to your first Docker lab! In this task, you will learn how to create and run your very first Docker container. Let's get started!

---

## Objectives
- Understand the basics of Docker containers.
- Create and run a simple Docker container.
- Optionally, create a basic Dockerfile.

---

## Prerequisites
- Docker installed on your system. [Get Docker](https://www.docker.com/get-started)

---

## Steps

### Step 1: Run a Pre-Built Docker Container
1. Open your terminal or command prompt.
2. Run the following command to pull and run a simple Docker container:
    ```bash
    docker run hello-world
    ```
3. Observe the output. Docker will:
    - Pull the `hello-world` image from Docker Hub (if not already downloaded).
    - Run the container and display a "Hello from Docker!" message.

---

### Step 2: Create Your First Dockerfile (Optional)
1. Create a new directory for your project:
    ```bash
    mkdir my-first-docker
    cd my-first-docker
    ```
2. Create a file named `Dockerfile` (no file extension).
3. Add the following content to the `Dockerfile`:
    ```dockerfile
    # Use an official Python runtime as a base image
    FROM python:3.9-slim

    # Set a working directory
    WORKDIR /app

    # Copy a simple Python script into the container
    COPY hello.py .

    # Run the Python script when the container starts
    CMD ["python", "hello.py"]
    ```
4. Create a `hello.py` file in the same directory with the following content:
    ```python
    print("Hello from your first Docker container!")
    ```

---

### Step 3: Build and Run Your Docker Image
> 💡**Note**: Ensure you are in the directory containing your `Dockerfile` and `hello.py` before proceeding.

1. Build the Docker image:
    ```bash
    docker build -t my-first-container .
    ```
2. Run the container:
    ```bash
    docker run my-first-container
    ```
3. You should see the message: `Hello from your first Docker container!`


---
## Cleanup

To clean up after completing the lab, follow these steps:

### Step 1: Stop the Running Container
If your container is still running, you need to stop it first. Use the following command:
```bash
docker ps  # List all running containers
```
This will display a list of running containers. Look for the `CONTAINER ID` of your container (e.g., `my-first-container`).

Now, stop the container using:
```bash
docker stop <CONTAINER_ID>
```
Replace `<CONTAINER_ID>` with the actual ID of your container.

### Step 2: Remove Stopped Containers
Once the container is stopped, you can remove it. To remove all stopped containers, run:
```bash
docker rm $(docker ps -a -q)
```
Here:
- `docker ps -a -q` lists all container IDs (including stopped ones).
- `docker rm` removes the containers listed.

### Step 3: Remove the Docker Image
To remove the Docker image you created (`my-first-container`), use:
```bash
docker rmi my-first-container
```
This will delete the image from your system.

### Step 4: Verify Cleanup
To ensure everything is cleaned up:
1. Check for remaining containers:
    ```bash
    docker ps -a
    ```
    If no containers are listed, all containers have been removed.

2. Check for remaining images:
    ```bash
    docker images
    ```
    If `my-first-container` is no longer listed, the image has been successfully removed.

By following these steps, you ensure your system is clean and ready for the next Docker project!

---

## Congratulations!
You have successfully created and run your first Docker container. 🎉