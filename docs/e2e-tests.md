# E2E tests

## How to run locally


### Pre-requsitions
- acs-engine
You need to have [acs-engine](https://github.com/Azure/acs-engine) in your path.
- An azure service principal
    [Create an azure service principal](https://github.com/Azure/acs-engine/blob/master/docs/serviceprincipal.md), it should either have:
    - Contributor permsision of a subscription
    - Contributor permission of a resource group. In this case, you need to create the resource group first

- Kubernetes source
This serves as E2E tests case base, should be located at `$GOPATH/src/k8s.io/kubernetes`.

1. Fill in following profile file, will be used in following steps

```
# Azure tenant id
export K8S_AZURE_TENANTID=
# Azure subscription id
export K8S_AZURE_SUBSID=
# Azure service principal id
export K8S_AZURE_SPID=
# Azure service principal secret
export K8S_AZURE_SPSEC=
# SSH public key to be deployed to cluster
export K8S_AZURE_SSHPUB=
# Azure location for the testing cluster
export K8S_AZURE_LOCATION=
```

2. Build custom image
Build a custom image and upload to a testing repository.
```
make image
docker tag azure-cloud-controller-manager:<id> <testing_image_id>
```

3. Deploy a cluster and run smoke test
```
source <ProfileName>
CLUSTER_NAME=<ClusterName>
test/k8s-azure/k8s-azure e2e -cname=$CLUSTER_NAME -caccm_image=<testing_image_id>
popd
```

To connect the cluster:
```
source $CLUSTER_NAME/cluster.profile
kubectl version
```

4. Run E2E tests
- Run test suite: default, serial, slow, smoke (smoke suite just tests the cluster is up and do not run any case)
```
test/k8s-azure/k8s-azure e2e -cname=$CLUSTER_NAME -ctype=<SuiteName> -cskipdeploy=1 -cbuild_e2e_test=1
```

Option '-cbuild_e2e_test=1' tells it to build E2E tests, if the tests have been built, that option can be omitted.

- Run custom test:
```
CASE_NAME=''
test/k8s-azure/k8s-azure e2e -cname=$CLUSTER_NAME -ctype=custom -ccustom_tests=$CASE_NAME -cskipdeploy=1
```

