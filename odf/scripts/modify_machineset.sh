CLUSTERID=$(oc get machineset -n openshift-machine-api -o jsonpath='{.items[0].metadata.labels.machine\.openshift\.io/cluster-api-cluster}')
REGION=$(oc get machineset -n openshift-machine-api -o jsonpath='{.items[0].spec.template.spec.providerSpec.value.placement.region}')
AMI=$(oc get machineset -n openshift-machine-api -o jsonpath='{.items[0].spec.template.spec.providerSpec.value.ami.id}')
sed -e "s/CLUSTERID/${CLUSTERID}/g" base/create_machineset.yaml > base/create_machineset.yaml.modified
sed -ie "s/REGION/${REGION}/g" base/create_machineset.yaml.modified
sed -ie "s/AMI/${AMI}/g" base/create_machineset.yaml.modified
