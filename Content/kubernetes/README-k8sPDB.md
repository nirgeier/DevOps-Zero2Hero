# Pod Disruption Budget (PDB)

## What is a PDB?

A **Pod Disruption Budget (PDB)** in Kubernetes helps control how many pods can be voluntarily evicted (e.g., during node maintenance, scaling, or draining) without affecting application availability. It ensures that a minimum number or percentage of pods remain running to keep the service responsive.

## Why Use It?

Without a PDB, Kubernetes might evict multiple pods at once, which can lead to downtime or degraded service. PDBs allow for **controlled disruptions** and help ensure **high availability** for stateful or critical applications.

## How It Works

You define a **budget** using either:

- `minAvailable`: The **minimum number** or percentage of pods that must remain **available**.
- `maxUnavailable`: The **maximum number** or percentage of pods that can be **unavailable** at any time.

**Note:** You can only specify *one* of these in a single PDB.

---

## Example 1: `minAvailable`

```yaml
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: my-app-pdb-min
spec:
  minAvailable: 2
  selector:
    matchLabels:
      app: my-app
```

This means at least 2 pods must always be available — Kubernetes won’t evict pods if doing so would reduce availability below 2.

---

## Example 2: `maxUnavailable`

```yaml
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: my-app-pdb-max
spec:
  maxUnavailable: 1
  selector:
    matchLabels:
      app: my-app
```

This means at most 1 pod can be disrupted at a time — any more than that, and Kubernetes will delay evictions until others recover.

---

## Apply the PDB

```bash
kubectl apply -f pdb.yaml
```

## View All PDBs

```bash
kubectl get poddisruptionbudgets
```

## Check PDB Details

```bash
kubectl describe pdb my-app-pdb-min
```
