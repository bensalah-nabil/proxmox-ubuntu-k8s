# Acces Web UI

kube-prometheus-stack has been installed. Check its status by running:
  kubectl --namespace monitoring get pods -l "release=prometheus-grafana"

Get Grafana 'admin' user password by running:

  kubectl --namespace monitoring get secrets prometheus-grafana-grafana -o jsonpath="{.data.admin-password}" | base64 -d ; echo

Access Grafana local instance:

  export POD_NAME=$(kubectl --namespace monitoring get pod -l "app.kubernetes.io/name=grafana,app.kubernetes.io/instance=prometheus-grafana" -oname)
  kubectl --namespace monitoring port-forward $POD_NAME 3000

