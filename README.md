# Deployment of ODF with ArgoCD

This Repo intention is to give an example of a Helm chart for ODF and how it can be
deployed with the help of ArgoCD, it's a starting point for further improvement
and customization by the final user. Is not an official Redhat supported repo.

1. Fork and clone this Github Repo: https://github.com/red-hat-storage/argocd-odf

``` 
gh repo fork https://github.com/red-hat-storage/argocd-odf.git  --clone 
```

2. Modify the values/variables for the Helm charts as needed:

- Argocd Bootstrap and ODF,LSO application configuration, at a bare minimum you
  would need to modify the helmRepoUrl variable in the bootstrap/values.yaml file and set it with your forked
  GitHub repo URL.

```
bootstrap/values.yaml
```
- Related to ODF deployment, if not deploying in AWS with dedicated nodes, you
  need to label the worker nodes with
  cluster.ocs.openshift.io/openshift-storage='' for ODF to use them during
  deployment

```
odf/values.yaml
```

- If LSO is going to be used as target PVs for OSDs also modify LSO values, LSO
  will only discover local disks on nodes with the
  cluster.ocs.openshift.io/openshift-storage='' label.

```
lso/values.yaml
```

3. Commit and push the modifications you made to the diferent values.yaml files to your forked repository. 

4. Then login into your OCP cluster with a cluster-admin account 

```
$ oc login  https://host:6443 -u XXX  -p XX
```

5. Run the setup script to start the deployment, ArgoCD will get bootstraped and ODF Deployed.

```
$ bash setup.sh
```
