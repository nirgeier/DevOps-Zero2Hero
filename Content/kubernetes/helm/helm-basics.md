# Introduction to Helm

Helm is a package manager for Kubernetes, often referred to as the "apt" or "yum" for Kubernetes.<br>It helps you manage Kubernetes applications using Helm charts, which are collections of YAML templates that define resources.

## Why Helm?

Managing Kubernetes manifests (YAML files) manually can quickly become difficult as your applications grow.<br>
Helm simplifies deployment, versioning, and sharing of Kubernetes applications.

## Key Concepts

- **Chart**: A Helm package that contains all resource definitions for a Kubernetes application.
- **Release**: A specific deployment of a chart with a given configuration.
- **Repository**: A place to store and share charts.

## Helm Chart Structure

A basic chart looks like this:

```
my-chart/
├── Chart.yaml        # Chart metadata (name, version, etc.)
├── values.yaml       # Default configuration values
├── charts/           # Used for subcharts Subcharts
├── templates/        # Kubernetes manifest templates
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── other_yaml_files.yaml
│   └── _helpers.tpl
```

## Installing Helm

You can install Helm using:

```bash
# On Linux
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

# On Windows:
winget install Helm.Helm
```

You can view various installation methods for Helm here: https://helm.sh/docs/intro/install/

## Using Helm

### 1. Add a repository

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
```

### 2. Install a chart

```bash
helm install my-nginx bitnami/nginx
```

This will install the NGINX application using the Bitnami chart.

To download the the chart instead of installing it use:

```bash
helm pull bitnami/nginx

# to unpack either add --untar flag or run:
tar -zxvf nginx-*.tgz

# you can pull a specific version with --version flag
```
### 3. List releases

```bash
helm list
```

### 4. Uninstall a release

```bash
helm uninstall my-nginx
```

## Creating Your Own Chart

```bash
helm create my-app
```

This command creates a basic chart that you can edit and customize.

## Example Deployment

To deploy a simple web app:

1. Create your chart:
   ```bash
   helm create web-app
   ```

2. Edit `values.yaml` to set your image:
   ```yaml
   image:
     repository: <your_dockerhub>/<image_name>
     tag: <your_tag>
   ```

3. Install it:
   ```bash
   helm install web-app ./web-app
   ```

## Tips

- Do not use underscore (```_```) in your chart's name :)

- Use `--dry-run` to test your chart without deploying:
  ```bash
  helm install --dry-run --debug web-app ./web-app
  ```

- Use `helm template` to render templates locally:
  ```bash
  helm template web-app ./web-app
  ```

---

## Resources

- [Helm Docs](https://helm.sh/docs/)
- [Artifact Hub (Chart Repository)](https://artifacthub.io/)
