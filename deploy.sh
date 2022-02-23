docker build -t tegetege/multi-client:latest -t tegetege/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tegetege/multi-server:latest -t tegetege/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tegetege/multi-worker:latest -t tegetege/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tegetege/multi-client:latest
docker push tegetege/multi-server:latest
docker push tegetege/multi-worker:latest

docker push tegetege/multi-client:$SHA
docker push tegetege/multi-server:$SHA
docker push tegetege/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tegetege/multi-server:$SHA
kubectl set image deployments/client-deployment client=tegetege/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tegetege/multi-worker:$SHA
