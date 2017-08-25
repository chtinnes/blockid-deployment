for i in {0..1}
do
export BC_NODE_ID=$i
#Delete all unpersisted resources
kubectl delete -f blockid-full-template.yaml-${BC_NODE_ID}.yaml
kubectl delete --namespace default --all pv,pvc
done