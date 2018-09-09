docker build -t samuvain/multi-client:latest -t samuvain/multi-client.$SHA -f ./client/Dockerfile ./client
docker build -t samuvain/multi-server:latest -t samuvain/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t samuvain/multi-worker:latest -t samuvain/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push samuvain/multi-client:latest
docker push samuvain/multi-server:latest
docker push samuvain/multi-worker:latest

docker push samuvain/multi-client:$SHA
docker push samuvain/multi-server:$SHA
docker push samuvain/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=samuvain/multi-server:$SHA
kubectl set image deployments/client-deployment client=samuvain/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=samuvain/multi-worker:$SHA