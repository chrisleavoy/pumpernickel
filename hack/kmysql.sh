POD=`kubectl get pods -l app=mysql | grep Running | grep 1/1 | awk '{print $1}'`
kubectl exec -it $POD -- mysql -uroot -ppassword
