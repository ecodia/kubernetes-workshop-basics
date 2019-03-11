CUSER=testuser
CGROUP=uniscon
NAMESPACE=ecodia
kubectl cp create_certs.sh default/access-node:/tmp/
kubectl exec -it access-node -- bash -c "chmod 700 /tmp/create_certs.sh"
kubectl exec -it access-node -- bash -c "/tmp/create_certs.sh $CGROUP $CUSER"
kubectl cp default/access-node:/root/certs/$CUSER.crt .
kubectl cp default/access-node:/root/certs/$CUSER.key .

kubectl config set-credentials "$CUSER" --client-certificate="$CUSER.crt"  --client-key="$CUSER.key"
kubectl config set-context workshop-context --cluster=minikube --namespace="$NAMESPACE" --user="$CUSER"
