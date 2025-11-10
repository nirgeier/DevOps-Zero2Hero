# GitLab Runners

## What is a Runner?

Runners are the agents for runnig CI jobs.
It can create container or pods for each jobs on the machine its installed via different executors.

## Executors
Each runner also got an executor that handles how the runner runs the jobs.

To run jobs on the runner machine's shell, use [Shell Executor](https://docs.gitlab.com/runner/executors/shell/).

To run jobs as containers in a docker engine, use [Docker Executor](https://docs.gitlab.com/runner/executors/docker/).

To run the jobs inside kubernatice use [Kubernatice Executor](https://docs.gitlab.com/runner/executors/kubernetes/).

You may need different runners for different uses.


## Tags

Each runner has tags for different category its uses like: macos, linux, windows, docker, etc..

One runner can have many tags like: `linux` and `shell`

For example: if you need to compile your code for a specific architecture, you can create a runner with the tag `arm64-docker` and to just change the job tag accordingly.

The workflow is as follows:
1. Code is pushed to GitLab
2. GitLab checks if it should run with `rules` or `only`
3. GitLab chooses a runner with the assigned tag that is avalible
4. The runner runs the job and returns the output of the job 
   
   If the job succeeded, logs, returning test result and much more -
   
   For more information: [Artifacts](https://docs.gitlab.com/ci/jobs/job_artifacts/)


## Setup Your own Runner

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
