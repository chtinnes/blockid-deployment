#Delete all unpersisted resources
kubectl delete -f blockid-full.yaml
#Delete Persistend Volume Claims TODO Variable in the number of deployments
kubectl delete pvc tmdir-tm-0
kubectl delete pvc imdir-tm-0
kubectl delete pvc tmdir-tm-1
kubectl delete pvc imdir-tm-1
kubectl delete pvc tmdir-tm-2
kubectl delete pvc imdir-tm-2