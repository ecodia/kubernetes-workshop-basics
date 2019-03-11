```bash
kubectl create namespace ecodia
bash add_user.sh
kubectl --context=workshop-context get pods
kubectl logs -n kube-system kube-apiserver-minikube --tail=5

# Add RBAC logging
kubectl exec -it access-node -- bash -c "sed -i 's/\(^\s*\)\(- kube-apiserver\)/\1\2\n\1- --vmodule=rbac*=5/' /opt/etc/kubernetes/manifests/kube-apiserver.yaml"

kubectl --context=workshop-context get pods
kubectl logs -n kube-system kube-apiserver-minikube --tail=5

kubectl create -f role_1.yaml
kubectl create -f role_binding.yaml
kubectl --context=workshop-context get pods
kubectl --context=workshop-context create -f test_pod.yaml
kubectl --context=workshop-context get pods

kubectl --context=workshop-context -n ecodia exec -it rbac-test -- "/bin/bash"
kubectl apply -f role_2.yaml
kubectl --context=workshop-context -n ecodia exec -it rbac-test -- "/bin/bash"
```
