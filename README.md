
## Introduction

This [repository](https://github.com/catenax-ng/k8s-example-argo-cd-project) is an example on how to build a [Docker](https://www.docker.com) image and embed it as an [Argo CD](https://argo-cd.readthedocs.io/en/stable/) friendly [Helm Chart](http://helm.sh/) for [Catena-X NG](https://github.com/catenax-ng).

### Example Application

This application provides a simple landing page for [K8s cluster](http://kubernetes.io/) as cluster entry point and default backend. Therefore, we are leveraging nginx web server to serve static HTML content.

### Folder Structure

| Folder              | Description                                               |
|:---------------------|----------------------------------------------------|
| [.github/workflows](.github/workflows/) | Stores all GitHub relevant items like GitHub actions.  |
| [docker/*](docker/)  | Stores assets which are stored in docker image after build. |
| [charts/*](helm/)  | Stores Helm Chart(s) which are used by Argo-CD to deploy this application on a K8s cluster.  |
| [html/*](html/)  | Stores static HTML assets which are stored in docker image after build. |

## Application Docker Container Image

In order to follow [Catena-X Helm Best Practices](https://catenax-ng.github.io/docs/kubernetes-basics/helm), a non root, unprivileged docker base image is used like [nginx-unprivileged](https://hub.docker.com/r/nginxinc/nginx-unprivileged) to serve static HTML content.

## Docker Build

Final [Docker](https://www.docker.com) Image is defined within [Dockerfile](Dockerfile) and build via [GitHub Action](https://docs.github.com/en/actions) *[Build Pipeline](.github/workflows/main.yml)*.

Following steps are executed:
1. Use [nginx-unprivileged](https://hub.docker.com/r/nginxinc/nginx-unprivileged) as Base Image
2. Copy [static HTML](html/) content into nginx [htdocs](https://www.nginx.com/resources/wiki/start/topics/examples/full/) folder.
3. Copy and overwrite [nginx default configuration](docker/default.conf)

## Github Actions

The [GitHub Action](https://docs.github.com/en/actions) is defined here as *[Build Pipeline](.github/workflows/main.yml)*.
Following steps are executed:

1. Check-out current branch content
2. Setup [Docker](https://www.docker.com) Build environment
3. Login into designated Docker Registry
4. Extract Metadata, build and push [Docker](https://www.docker.com) image to Registry
5. Sign published [Docker](https://www.docker.com) image

## Helm Chart

The [Helm Chart](http://helm.sh/) *[k8s-helm-example](chart/k8s-helm-example/)* is monitored by [Argo CD](https://argo-cd.readthedocs.io/en/stable/) and deployed to a [K8s cluster](http://kubernetes.io/).
It follows [Catena-X Helm Best Practices](https://catenax-ng.github.io/docs/kubernetes-basics/helm).

## Argo CD

Within [Catena-X NG](https://github.com/catenax-ng), [Argo CD](https://argo-cd.readthedocs.io/en/stable/) is used to deploy cloud applications to a [K8s cluster](http://kubernetes.io/).

In order for [Argo CD](https://argo-cd.readthedocs.io/en/stable/) to manage the repository, an [Argo CD App](https://argo-cd.readthedocs.io/en/stable/operator-manual/declarative-setup/#applications) like the following has to be created:

```yaml
project: default
source:
  repoURL: 'https://github.com/catenax-ng/k8s-helm-example.git'
  path: chart/k8s-helm-example
  targetRevision: main
destination:
  server: 'https://kubernetes.default.svc'
  namespace: k8s-helm-example
syncPolicy:
  automated: {}
  syncOptions:
    - CreateNamespace=true
    - Replace=true
```

This example has been created on [Hotel Budapest Argo CD](https://argo.int.demo.catena-x.net/applications).

![](docs/images/argo-cd-app.png)
