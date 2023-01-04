# Command Line

## Creating a Cluster

1. kind create cluster --config kind-v1.23.13.yaml
2. kind create cluster --name kind-2 --config kind-v1.23.13.yaml

## Interacting With Your Cluster

1. List all kind cluster - `kind get clusters`
2. List all images inside kind - `docker exec -it kind-2-control-plane crictl images`

## Deleting a Cluster

1. kind delete cluster --name kind-2

## Loading an Image Into Your Cluster

1. Build your app images - `docker build -t my-custom-image:unique-tag`.
2. Loading image into kind - `kind load docker-image my-custom-image:unique-tag`.
3. Using your app images - `kubectl run alochym --image=my-custom-image:unique-tag`.

## Exporting Cluster Logs

1. kubectl --namespace default logs pod_name
2. <https://kind.sigs.k8s.io/docs/user/quick-start/#exporting-cluster-logs>.
3. kubectl rollout restart deployment deployment_name
