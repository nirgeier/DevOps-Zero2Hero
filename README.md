<!-- omit in toc -->
# DevOps-Zero2Hero

- The aim of this project is to collect as many resources as possible that users can use to DevOps.
- The project will contain DevOps Learning labs.

---

<div align="center">
  <img src="resources/images/cover-rounded.png" alt="DevOps-Zero2Hero" width="500">
</div>

---

<!-- omit in toc -->
## Table of Contents

- [Detailed instructions how to contribute](#detailed-instructions-how-to-contribute)
  - [Getting Started](#getting-started)
    - [Fork the Repository](#fork-the-repository)
    - [Making Changes](#making-changes)
      - [Generating ssh key](#generating-ssh-key)
      - [Setting up upstream](#setting-up-upstream)
      - [Stay Updated](#stay-updated)
      - [Commit changes](#commit-changes)
- [Contributing notes](#contributing-notes)
- [Contributing Quality](#contributing-quality)
  - [Run GithubAction locally](#run-githubaction-locally)
- [Recommended extensions for improved contribution](#recommended-extensions-for-improved-contribution)

---

### How to contribute to this project?

- **Contribute** to the project.
  - Make changes locally on your local machine (clone).
  - Create a new branch with meaningful name (git checkout -b your-branch-name)
  - **Add & Commit** the changes. (git add . && git commit -m "Describe your changes")
  - **Push** the changes to your forked repository. (git push origin your-branch-name)
  - Create a **pull request** to the main repository main branch.
  - When the PR is merged you will automatically added to the list of contributors.
  - Follow the instructions in the pull request to merge your changes.
  - Wait for the project maintainers to review and merge your pull request.

---

## Detailed instructions how to contribute

### Getting Started
  
#### Fork the Repository

- Start by forking the repository to your own GitHub account:
- Click the "Fork" button in the upper right corner
- Clone your fork locally:
  ```bash
  # Clone the repository
  $ git clone https://github.com/YOUR-USERNAME/DevOps-Zero2Hero.git
  
  # Navigate into the project directory
  $ cd DevOps-Zero2Hero-NAME
  ```

#### Making Changes

##### Generating ssh key

  - Make sure you have a setup an SSH key for GitHub. 
  - If you don't have one, follow these steps to generate and add your SSH key to GitHub.
    - Generate an SSH key:
      ```bash
      # Generate rsa key
      ssh-keygen -t rsa 

      # Follow the prompt to save the key to a file (e.g., `~/.ssh/id_rsa`)
      # You can also specify a different file name by using `-f` option, e.g: 
      # ssh-keygen -t rsa -f ~/.ssh/mykey
      ```
    - This will create a new file named `id_rsa` and `id_rsa.pub` in your home directory unless you gave it a different name
  - Copy the contents of `id_rsa.pub` and paste it under "SSH key" field in  your GitHub account settings.

##### Setting up upstream
  
- Add the original repository as an upstream remote:
  ```bash
  # Add the original repository as an upstream remote
  git remote add upstream git@github.com:nirgeier/DevOps-Zero2Hero.git
  ```

##### Stay Updated

- Keep your fork in sync with the upstream repository:
  ```bash
  # Keep your fork in sync with the upstream repository
  git fetch --all

  # Merge upstream changes into your branch
  git merge upstream/main
  ```

##### Commit changes

  ```sh
  # Create branch for your changes.
  $ git checkout -b <your-branch-name>

  # Make changes locally on your local machine (clone).
  # Add the changes to your staging area
  $ git add .

  # Commit the changes
  $ git commit -m "Describe your changes here"

  # Push the changes to your forked repository.
  $ git push origin <your-branch-name>
  ```
  
- Create a pull request to the main repository.

---

## Contributing notes

1. All folders should be named in lowercase with no spaces.  
2. Content should be written in markdown and file name should be `.md`
3. Content should b based upon the Default template with the required placeholders and include TOC
4. GitHub action is collecting all the files and generate auto-content README file with the different topics.
5. Images should be in the resources/images folder
6. If you add new technology you have to edit the main README as well and add the logo + add the technology to the list

## Contributing Quality

### Run GithubAction locally

1. Install `act` from the official website to run GithubAction locally   
   Click <kbd>CTRL</kbd> to open in hew tab: https://nektosact.com/installation/index.html
2. Execute the following command in your terminal:
   ```sh
   # Execute the Github Actions locally
   act --workflows \
   ".github/workflows/add-contrib.yml" --job "add-contributor" 
- TODO: Add detailed page on how to run and text GitHub actions locally
- Verify that your code is passing all the pre-merge checks


## Recommended extensions for improved contribution

- [Markdown All in One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one)
- [GitHub Actions](https://marketplace.visualstudio.com/items?itemName=GitHub.vscode-github-actions)

---

- Use the [discussions](https://github.com/nirgeier/DevOps-Zero2Hero/discussions) tab to discuss the project.

---

Thank it. AS simple as that!

