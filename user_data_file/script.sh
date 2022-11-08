#! /bin/bash
if [ ! -e /usr/local/bin/kubectl ]
then
  sudo curl -LO 'https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl'
  sudo chmod +x kubectl
  sudo mv kubectl /usr/local/bin
fi
kubectl apply -f \$1
kubectl create ns argocd
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.1/deploy/static/provider/cloud/deploy.yaml
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.9.1/cert-manager.yaml
kubectl apply -n argocd -f application.yaml
kubectl apply -n external-dns -f service-account.yaml
kubectl patch svc argocd-server -n argocd -p '{\"spec\": {\"type\": \"LoadBalancer\"}}'
# kubectl annotate ingress ingress-service external-dns.alpha.kubernetes.io/hostname=
# kubectl annotate svc argocd-server external-dns.alpha.kubernetes.io/hostname=
# kubectl annotate svc grafana external-dns.alpha.kubernetes.io/hostname=