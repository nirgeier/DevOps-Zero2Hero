# GitLab CI

## Overview
So you wanna know how to use Gitlab CI

Baisicly you write code in bash that is gonna be running whenever you commit/merge or some other rules

Gitlab CI seperate your code to different Jobs, for each you can choose diferent rules to run, which runner tag to run on etc...
 


whenever you commit a code Gitlab choose the right runner and it tells the runner run the code

example:


```yaml
# .gitlab-ci.yml
stages:
  - build
  - test

# Description of each job
build_job:
  stage: build  # you choose which stage to be run on
  tag: docker   # Run job on runners with <docker> tag 
  image: node:$NODE_VERSION     # Docker image to run in the runner
  script:   # inside the job container the following lines will run
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
  except:
    - main
    - master
```

Ok I know It's a little much but let's break it down:

### Stage
the stage field is the order that the job will run, 
In the example above, we want to build our app and then run tests on it

### Image
choose which image the script will run inside
