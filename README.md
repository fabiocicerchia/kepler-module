# Kepler Module

TF module that installs a monitoring stack to measure and track the environmental impact of your Kubernetes cluster.

## Requirements

- [Terraform](https://developer.hashicorp.com/terraform/install) / [OpenTofu](https://opentofu.org/docs/intro/install/)
- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/)

## Usage

Boot your minikube cluster locally:

```bash
minikube start --kubernetes-version=v1.32.0
kubectl config use-context minikube && kubectl config current-context
```

Deploy the monitoring stack:

```
terraform apply
```

Expose locally the necessary tools:

```
kubectl --namespace monitoring get secrets prometheus-grafana -o jsonpath="{.data.admin-password}" | base64 -d ; echo
kubectl port-forward -n monitoring svc/prometheus-grafana 3000:80 & \
kubectl port-forward -n monitoring svc/prometheus-kube-prometheus-prometheus 9090:9090 & \
kubectl port-forward -n opencost svc/opencost 9090
```

Open <http://localhost:3000> and import the following Grafana dashboards:

- <https://raw.githubusercontent.com/sustainable-computing-io/kepler-operator/main/hack/dashboard/assets/kepler/dashboard.json>
- <https://raw.githubusercontent.com/sustainable-computing-io/kepler-operator/main/hack/dashboard/assets/prometheus/dashboard.json>
- <https://raw.githubusercontent.com/ariewald/kepler-grafana-dashboard/refs/heads/main/kepler.json>
- <https://raw.githubusercontent.com/bernardodon/energy-k8s-experiments/refs/heads/main/grafana-setup.json>

## TODO

- [ ] Currently the code only works on Minikube locally, make it cluster agnostic.
- [ ] Create a TF module
- [ ] Publish it to <https://registry.terraform.io/>
- [ ] Publish it to <https://search.opentofu.org/>

## License

Copyright 2026 Fabio Cicerchia.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
