# Multitool for Kubernetes

Runs ```kubectl proxy``` as entrypoint, so meant to run in Kubernetes with a ServiceAccount so that ```/var/run/secrets/kubernetes.io/serviceaccount``` is present.

This will expose the kube api at http://localhost:8001 in the pod.

No Kubernetes cluster you say...? Well go grab [k3d](https://github.com/k3d-io/k3d/releases/latest), and then:
```
k3d cluster create local \
    --image "docker.io/rancher/k3s:v1.26.1-k3s1" \
    --port "80:80@loadbalancer" \
    --port "443:443@loadbalancer" \
    --api-port "6443" \
    --servers 1 \
    --agents 3
```

Deploy:
```
kubectl apply -f https://raw.githubusercontent.com/nyvanga/multitool/master/multitool-k8s/multitool-k8s.yaml
```

Find the pod:
```
POD=$(kubectl get pod | grep ^multitool-k8s | awk '{print $1}')
```

Query the api:
```
kubectl exec ${POD} -- curl -sS http://localhost:8001/api
```

Get list of nodes with hostname and ip (uses jq for json):
```
kubectl exec -it ${POD} -- curl -sS http://localhost:8001/api/v1/nodes | jq '[ .items | .[] | .status.addresses | map( { (.type): .address } ) ]'
```

Or just jump in there and poke around:
```
kubectl exec -it ${POD} -- bash
```

Remove:
```
kubectl delete -f https://raw.githubusercontent.com/nyvanga/multitool/master/multitool-k8s/multitool-k8s.yaml
```

## Test build

Run:
```
docker compose up -d --build
```

Then to access the container:
```
docker compose exec test_build_multitool_k8s bash
```
