# GitLab CI/CD

## Overview
So you wanna know how to use Gitlab CI

You write code in bash that is gonna be running whenever you commit in you repository.

GitLab CI seperate your code to different Jobs, for each you can choose different rules to run, which runner to use and much more.

Each Job can be run in a different runner to allow multiple jobs to be run at the same time

In Here we will explain the basics of GitLab CI/CD.
We encourage you to explore the [GitLab CI/CD Docs](https://docs.gitlab.com/ci/)


### Example:

whenever you push code to GitLab it reads the `.gitlab-ci.yaml` file and chooses a runner and the runner run the CI/CD code In blocks that are called jobs.

#### Basic example:

```yaml
stages:
  - build
  - test

# Description of each job
build_job:
  stage: build                  # Which stage the job belongs to
  tag: docker                   # Run job on runners with <docker> tag 
  image: node:$NODE_VERSION     # Docker image to run in the runner
  script:
    - echo "Building application..."
    - npm run build
  
test_job:
  stage: test
  image: node:$NODE_VERSION
  script:
    - echo "Running unit tests..."
    - npm run test:unit
    - echo "Running integration tests..."
    - npm run test:integration
  only:
    - merge_requests
```

It seems a little complicated at first, but let's break it down:

### `Stage`

The stage field is the order that the job will run.

In the example above, we want to build our app and then run tests on it.

So we created 2 stages

### `Image`
choose which image the script will run inside if the runners is running jobs inside containers. (will be explained in the `gitlab-runner` page)

### `Script`
Inside the job container the following lines will run.

Most of the times its runnig a bash commands.

If any of the commands fail, the entire job will stop.

### `Only`
Used to limit when a job is run, in the example the build_job will run for each commit and the the test_job will only be run in a merge_requests.

You can add more conditions like running for each commit in `main` branch.

For more advanced conditions, you should use `Rules` instead of only.