# Package Management

## `apt-get` package manager

Many Linux distributions use a package management system to install, remove, and manage software packages. Here are some commonly used commands for package management on Ubuntu:

`apt-get` is a command line tool that helps to handle packages in Ubuntu systems. Its main task is to retrieve the information and packages from the authenticated sources for installation, upgrade, and removal of packages along with their dependencies (the packages that your desired package depends on).

Generally, when first using `apt-get`, you will need to get **an index** of the available packages of public repositories, this is done using the command `sudo apt-get update`:

```console
myuser@hostname:~$ sudo apt-get update
...
```

Note that the command doesn't install any package, so what just happened under-the-hood?

First, `apt-get` reads the `/etc/apt/sources.list` file (and any additional files under `/etc/apt/sources.list.d/`), which contains a list of [configured data sources and properties](https://bash.cyberciti.biz/guide//etc/apt/sources.list_file) to fetch packages from the internet. Then for each repository in the list, apt fetches a list of all available packages, versions, metadata etc... Package lists are stored under `/var/lib/apt/lists/`.

To install a package, just type:

```console
sudo apt-get install <package-name>
```

When you run the above command, the package manager (in this case, `apt-get`) will search for the package in its local package lists (the ones stored under `/var/lib/apt/lists/`). These package lists are the catalog of available packages that can be installed on your system, in case the packages don't exist in the catalog, you won't be able to install it. Thus, it is important to perform `sudo apt-get update` before every installation, this in order to update the local lists with all available packages in their latest version.

`apt-get` checks the **digital signature** of the files to ensure that it is valid and has not been tampered with. The signature is used to verify the authenticity and integrity of the repository and its contents. The concepts of digital signatures, data integrity and authenticity will be discussed later on in this course.

# Exercises

### :pencil2: Install Docker 

Follow [Docker official installation](https://docs.docker.com/engine/install/ubuntu/) docs on Ubuntu. Install Docker step by step while trying to understand the reason behind every apt-get command. What are the official GPG keys used for?

### :pencil2: Experimenting with `apt-get`

1. Why do we need `sudo` to `apt-get update` and `install`?
2. Perform `apt-cache show apache2` to see the local list of the `apache2` package on your system.
3. Choose one of the versions from the above output (preferably not the latest version), and install `apache2`, in this specific version.
4. Perform `sudo apt-get update`. Was the list updated? Do you have some new versions of apache2 available to be installed?
5. Upgrade `apache2` to the latest version.
6. Remove `apache2`.

