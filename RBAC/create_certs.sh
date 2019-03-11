apt update
apt install openssl

CGROUP=$1
CUSER=$2
cd
mkdir -p certs
cd certs
openssl genrsa -out "$CUSER".key 4096
openssl req -new -key "$CUSER".key -out "$CUSER".csr -subj "/CN=$CUSER/O=$CGROUP"

# Default: PKI_PATH="/etc/kubernetes/pki/"
PKI_PATH="/opt/var/lib/minikube/certs/"
openssl x509 -req -in "$CUSER".csr -CA "$PKI_PATH"/ca.crt -CAkey "$PKI_PATH"/ca.key -CAcreateserial -out "$CUSER".crt -days 182
