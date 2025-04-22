# Crane – A Modern Tool for Container Images

![Crane Logo](../../resources/images/logos/logos_crane.svg)

Crane is a lightweight, daemonless command-line tool from Google’s Go Container Registry project that revolutionizes container image management. It simplifies workflows by replacing multi-step Docker CLI operations (pull, tag, push) with streamlined, efficient commands—empowering users from beginners to advanced practitioners.

---

## Table of Contents

- [Overview](#overview)
- [Why Use Crane?](#why-use-crane)
- [Architecture at a Glance](#architecture-at-a-glance)
- [difference from docker method](#Example-of-the-difference-from-docker-method)
- [Installation](#installation)
- [Basic commands explanation](#basic-commands-explanation)


---

## Overview

Crane streamlines container image operations by interfacing directly with container registries via HTTP APIs. It eliminates the need for a Docker daemon and reduces the complexity of common workflows like pulling, tagging, and pushing images. Whether you’re just starting out or looking to optimize your CI/CD pipelines, Crane is built to grow with you.

---

## Why Use Crane?

- **Daemonless & Secure:** Operate without the Docker daemon, reducing potential security risks and simplifying deployments in rootless environments.
- **High Performance:** Execute operations—such as copying images between registries—in one efficient step, avoiding the overhead of multiple commands.
- **Multi-Platform Support:** Preserve multi-architecture image manifests, ensuring that all required architectures are intact.
- **Simplified Automation:** A single binary and intuitive commands make it straightforward to incorporate Crane into scripts and CI/CD pipelines.

---

## Architecture at a Glance

Crane leverages modern registry API capabilities to deliver a streamlined experience:

- **Direct Streaming:** Moves data directly between source and destination registries without storing intermediate data.
- **Layer Reuse:** Detects layers that already exist at the destination registry to avoid redundant uploads.
- **Efficient Tagging:** Tags images directly within registries, eliminating the need for full data transfers.

This architecture minimizes latency, enhances throughput, and simplifies operations—a perfect match for modern container workflows.

---
# Example of the difference from docker method

Docker Approach: Pull → Tag → Push:

docker pull <SOURCE_REGISTRY>/<SOURCE_REPOSITORY>:<SOURCE_TAG>

docker tag <SOURCE_REGISTRY>/<SOURCE_REPOSITORY>:<SOURCE_TAG> <DESTINATION_REGISTRY>/<DESTINATION_REPOSITORY>:<DESTINATION_TAG>

docker push <DESTINATION_REGISTRY>/<DESTINATION_REPOSITORY>:<DESTINATION_TAG>

* Requires a running Docker daemon
* Pulls the image into local Docker storage first, then tags and pushes it out


Crane Approach: Single Command

crane copy <SOURCE_REGISTRY>/<SOURCE_REPOSITORY>:<SOURCE_TAG> <DESTINATION_REGISTRY>/<DESTINATION_REPOSITORY>:<DESTINATION_TAG>

* No Docker daemon needed
* Directly copies the image from the source registry to the destination in one command (Registry-to-Registry method)
* Preserves the exact digest and metadata (no local storage required unless you explicitly want it)
* Ideal for CI/CD: Scripts can run crane copy without privileged access


---

## Installation

Crane is distributed as a single binary that you can quickly install on your system. For the detailed installation guide, refer to: (https://github.com/google/go-containerregistry/blob/main/cmd/crane/README.md).

---

## Basic commands explanation
- **crane append**: Append contents of a tarball to a remote image  
- **crane auth**: Log in or access credentials  
- **crane blob**: Read a blob from the registry  
- **crane catalog**: List the repos in a registry  
- **crane config**: Get the config of an image crane copy  
- **crane copy**: Efficiently copy a remote image from src to dst while retaining the digest value  
- **crane delete**: Delete an image reference from its registry  
- **crane digest**: Get the digest of an image  
- **crane export**: Export filesystem of an image as a tarball  
- **crane flatten**: Flatten an image’s layers into a single layer  
- **crane index**: Modify an image index  
- **crane list**: List the tags in a repo (crane manifest, crane mutate, etc.)  
- **crane manifest**: Get the manifest of an image crane mutate  
- **crane pull**: Pull remote images by reference and store their contents locally  
- **crane push**: Push local image contents to a remote registry  
- **crane tag**: Create or move a tag on a remote image  
- **crane validate**: Validate that an image is well-formed  
- **crane version**: Print the version





