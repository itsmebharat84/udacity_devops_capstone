# Tag image
docker tag flask-app:latest itsmebharatb/flask-app:latest

# Login to docker-hub
docker login --username=itsmebharatb

# Push image
docker push itsmebharatb/flask-app:latest