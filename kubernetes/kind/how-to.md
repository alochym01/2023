# Using Kind

## Extra mount - step 0

1. Create kind-config.yaml

   ```yml
   apiVersion: kind.x-k8s.io/v1alpha4
   kind: Cluster
   nodes:
     - role: control-plane
       extraMounts:
         - hostPath: /home/bill/work/foo # host server
           containerPath: /foo # pod
   ```

1. Create kind cluster - `kind create cluster --config kind-config.yaml`
1. In your Kubernetes YAML file, you need to mount that containerPath as a "host path" on the node. A pod spec might contain in part:

   ```yml
   volumes:
     - name: foo
       hostPath:
         path: /foo # matches kind containerPath:
   containers:
     - name: foo
       volumeMounts:
         - name: foo
           mountPath: /data # in the container filesystem or in a pod
   ```

## Create Docker Images - step 1

1. <https://github.com/alochym01/2023/tree/00-docker-podman/kubernetes/docker/python>

## Load Docker Images into Kind - step 2

1. Loading image into kind - `kind load docker-image my-custom-image:unique-tag`.

## Create Kubernetes YAML file

1. Create Persistence Volume.
1. Create Persistence Volume Claim.
1. Pod with Persistence Volume.
1. Deployment with Persistence Volume.
1. StatefulSet with Persistence Volume.
