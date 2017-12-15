# Component Versioning

## Upgrading Kubernetes version

To upgrade Kubernetes version, please change following places.
- [glide.yaml](/glide.yaml)
- [linux.json](/test/k8s-azure/manifest/linux.json)
- [Dockerfile](/test/k8s-azure/Dockerfile)

Please check document [Dependency management](dependency-management.md) and [Kubernetes in E2E test](#kubernetes-in-e2e-test) for detail.

## Components
### Main package
- Main dockerfile: [Dockerfile](/Dockerfile)
    
    Update `FROM golang:*`, also update `FROM buildpack-deps:*` if image base version changes.

- Travis CI config: [.travis.yml](/.travis.yml)
    ```
    go:
    - *
    ```

- Also update [linux.json](/test/k8s-azure/manifest/linux.json)
  Change `customCcmImage` to latest stable released image, this is used for local deployment.

### Kubernetes in E2E test
Following Kubernetes versions should stick to Kubernetes package version specified in [glide.yaml](/glide.yaml), please see [Dependency management](dependency-management.md)] for details abount package versions.

   - Test cluster hyperkube Image

     Update file [linux.json](/test/k8s-azure/manifest/linux.json)
     
     Change `"customHyperkubeImage": "gcrio.azureedge.net/google_containers/hyperkube-amd64:*"` for Kubernetes version.

   - E2E tests

     Update file: [Dockerfile](/test/k8s-azure/Dockerfile)
 
     Change `ARG K8S_VERSION=` for Kuberentes version.
 
     Change `FROM golang:* AS build_kubernetes`. This should stick to the Go version used by [Kubernetes](https://github.com/kubernetes/kubernetes/blob/master/build/build-image/cross/Dockerfile)

### acs-engine in E2E test
   Update file [Dockerfile](/test/k8s-azure/Dockerfile)

   Change  `ARG ACSENGINE_VERSION=` for acs-engine  version.

   Change  `FROM golang:* AS build_acs-engine`.
   This should stick to the Go version used by [acs-engine](https://github.com/Azure/acs-engine/blob/master/Dockerfile).
