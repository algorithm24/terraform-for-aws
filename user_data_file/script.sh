#! /bin/bash
if [ ! -e /usr/local/bin/kubectl ]
then
  sudo curl -LO 'https://storage.googleapis.com/kubernetes-release/release/v1.23.6/bin/linux/amd64/kubectl'
  sudo chmod +x kubectl
  sudo mv kubectl /usr/local/bin
fi
kubectl apply -f \$1
kubectl create ns argocd
kubectl create ns grafana
kubectl create ns prometheus
kubectl create ns loki
kubectl create ns external-dns
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.3.1/deploy/static/provider/cloud/deploy.yaml
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.9.1/cert-manager.yaml
kubectl apply -n external-dns -f service-account.yaml
kubectl apply -n argocd -f application.yaml
kubectl patch svc argocd-server -n argocd -p '{\"spec\": {\"type\": \"LoadBalancer\"}}'
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install prometheus prometheus-community/prometheus --namespace prometheus --set alertmanager.persistentVolume.enabled=false --set server.persistentVolume.enabled=false
helm install grafana grafana/grafana --namespace grafana --set adminPassword='admin' --values /home/ubuntu/environment/grafana/grafana.yaml --set service.type=LoadBalancer
helm install loki grafana/loki-stack --namespace loki
helm install external-dns bitnami/external-dns --namespace external-dns --set serviceAccount.name='external-dns' --set serviceAccount.create=false
# echo loki-endpoint:\$(kubectl get svc loki -n loki -o jsonpath='{.spec.clusterIP}')
# kubectl annotate ingress ingress-service external-dns.alpha.kubernetes.io/hostname=
# kubectl annotate svc argocd-server external-dns.alpha.kubernetes.io/hostname=
# kubectl annotate svc grafana external-dns.alpha.kubernetes.io/hostname=