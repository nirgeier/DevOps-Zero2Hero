# GitLab Runners

You need different runners for different things like if i need to compile my app for a specific architecture i can create a runner with the tag `mac-os` and to just change the jobs' tags accordingly. 

## Setup Your own runner

### 1. Choose your machine

Here I'll show you how to setup your own docker runner.
But you can also install it via Helm, Gitlab agent, etc...

For further documentation:
[Install-GitLab-Runner](https://docs.gitlab.com/runner/install/)

### 2. Run on docker
```bash
docker run -d --name gitlab-runner --restart always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v gitlab-runner-config:/etc/gitlab-runner \
  gitlab/gitlab-runner:latest
```

### 3. Register to GitLab
Then you need to register you runner in GitLab
```bash
docker exec -it gitlab-runner gitlab-runner register
```
