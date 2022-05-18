#!/bin/bash
##
# Setup Openshift Environment
##


# Install Operators
echo "Installing ArgoCD operator..."
oc apply -f ./bootstrap/argocd-operator.yaml
sleep 60

waitoperatorpod() {
  sleep 10
  oc get pods -n openshift-operators | grep ${1} | awk '{print "oc wait --for condition=Ready -n openshift-operators pod/" $1 " --timeout 300s"}' | sh
  sleep 20
}


echo "Waiting for Operators to be ready..."
waitoperatorpod gitops


echo "Creating Project and Applications in openshift-gitops namespace"
oc project openshift-gitops
helm template ./bootstrap/  --debug   | oc apply -f -
