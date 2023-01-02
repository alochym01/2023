# Configiration

1. Download kind version - `docker pull kindest/node:v1.23.13`
2. Check image kind - `docker images`
3. Reference link - <https://kind.sigs.k8s.io/docs/user/configuration/>
4. Create kind configuration yaml file

   ```yml
   kind: Cluster
   apiVersion: kind.x-k8s.io/v1alpha4
   name: kind-2
   # One control plane node and three "workers".
   #
   # While these will not add more real compute capacity and
   # have limited isolation, this can be useful for testing
   # rolling updates etc.
   #
   # The API-server and other control plane components will be
   # on the control-plane node.
   #
   # You probably don't need this unless you are testing Kubernetes itself.
   nodes:
   - role: control-plane
     image: kindest/node:v1.23.13
     # add a mount from ~/kind-v1.23.13 on the host to /files on the node
     extraMounts:
     # create folder ~/kind-v1.23.13 before create kind cluster
     - hostPath: ~/kind-v1.23.13
       containerPath: /files
   # - role: worker
   # - role: worker
   # - role: worker
   ```