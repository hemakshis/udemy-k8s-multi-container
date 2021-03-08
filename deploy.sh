# Build all the images
docker build -t hemakshis/udemy-k8s-multi-container-client:latest -t hemakshis/udemy-k8s-multi-container-client:$SHA -f ./client/Dockerfile ./client
docker build -t hemakshis/udemy-k8s-multi-container-server:latest -t hemakshis/udemy-k8s-multi-container-server:$SHA -f ./server/Dockerfile ./server
docker build -t hemakshis/udemy-k8s-multi-container-worker:latest -t hemakshis/udemy-k8s-multi-container-worker:$SHA -f ./worker/Dockerfile ./worker
# Login is already done in "before_install" step, so will skip here
# Push these images to Docker Hub
docker push hemakshis/udemy-k8s-multi-container-client:latest
docker push hemakshis/udemy-k8s-multi-container-server:latest
docker push hemakshis/udemy-k8s-multi-container-worker:latest

docker push hemakshis/udemy-k8s-multi-container-client:$SHA
docker push hemakshis/udemy-k8s-multi-container-server:$SHA
docker push hemakshis/udemy-k8s-multi-container-worker:$SHA
# Run kubectl commands
kubectl apply -f k8s
kubectl set image deployments/client-deployment client=hemakshis/udemy-k8s-multi-container-client:$SHA
kubectl set image deployments/server-deployment server=hemakshis/udemy-k8s-multi-container-server:$SHA
kubectl set image deployments/worker-deployment worker=hemakshis/udemy-k8s-multi-container-worker:$SHA