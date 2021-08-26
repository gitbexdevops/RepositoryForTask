# build artifact
docker build -t $IMAGE /app

# test artifact
if [ -e /app/test/sh ]; then 
  /app/test.sh 
fi

# tag artifact
docker tag $IMAGE $ACCOUNT/$IMAGE:$TAG 
docker tag $IMAGE $ACCOUNT/$IMAGE:latest

# push artifact
docker push $ACCOUNT/$IMAGE:$TAG 
docker push $ACCOUNT/$IMAGE:latest
