## Introduction
This [repository](https://github.com/catenax-ng/k8s-example-argo-cd-project) is an example on how to build a [Docker](https://www.docker.com) image and embede it as an [Argo CD](https://argo-cd.readthedocs.io/en/stable/) friendly [Helm Chart](http://helm.sh/) for [Catena-X NG](https://github.com/catenax-ng).

### Example Application
This application provides an simple landing home page for [K8s cluster](http://kubernetes.io/) as cluster entrypoint and default backend. Therefore we are leveraging nginx webserver to serve static html content.
### Folder Structure
| Folder              | Description                                               |
|:---------------------|----------------------------------------------------|
| [.github/workflows](.github/workflows/) | Stores all GitHub relevant items like GitHub Actions.  |
| [docker/*](docker/)  | Stores assets which are backed into docker image during building. |
| [helm/*](helm/)  | Stores Helm Chart(s) which are used by Argo-CD to deploy this application on a K8s Cluster.  |
| [html/*](html/)  | Stores static HTML assets which are backed into docker image during building. |
## Application Docker Container Image
In order to follow [Catena-X Helm Best Practices](https://catenax-ng.github.io/docs/kubernetes-basics/helm), a non root, unprivileged docker base image is used like  [nginx-unprivileged](https://hub.docker.com/r/nginxinc/nginx-unprivileged) to serve static html content. 
## Docker Build
Final [Docker](https://www.docker.com) Image is definied within [Dockerfile](Dockerfile) and build via [GitHub Action](https://docs.github.com/en/actions) *[Build Pipeline](.github/workflows/main.yml)*.

Following steps are executed:
1. Use [nginx-unprivileged](https://hub.docker.com/r/nginxinc/nginx-unprivileged) as Base Image
2. Copy [static HTML](html/) content into nginx [htdocs](https://www.nginx.com/resources/wiki/start/topics/examples/full/) folder.
3. Copy and overwrite [nginx default configuration](docker/default.conf) 
## Github Actions
The [GitHub Action](https://docs.github.com/en/actions) is defined here as *[Build Pipeline](.github/workflows/main.yml)*.
Following steps are executed:
1. Check outs current branch content
2. Setup [Docker](https://www.docker.com) Build Environment
3. Logins into designated Docker Registry
4. Extracts Metadata, Build and pushes [Docker](https://www.docker.com) image to Registry
5. Signs published [Docker](https://www.docker.com) image

## Helm Chart
The [Helm Chart](http://helm.sh/) *[cx-argo-cd-example](helm/cx-argo-cd-example/)* is meant to be monitored by [Argo CD](https://argo-cd.readthedocs.io/en/stable/) and deployed to a [K8s cluster](http://kubernetes.io/).
It follows [Catena-X Helm Best Practices](https://catenax-ng.github.io/docs/kubernetes-basics/helm).
