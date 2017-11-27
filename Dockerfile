FROM golang:1.9.1-stretch AS build
WORKDIR /go/src/github.com/Azure/kubernetes-azure-cloud-controller-manager
COPY . .
RUN make

FROM buildpack-deps:stretch-curl
COPY --from=build /go/src/github.com/Azure/kubernetes-azure-cloud-controller-manager/bin/azure-cloud-controller-manager /usr/local/bin
RUN ln -s /usr/local/bin/azure-cloud-controller-manager /usr/local/bin/cloud-controller-manager
