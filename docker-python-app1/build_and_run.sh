#docker build -t pinnaman/aws-tts .

docker run --rm \
-v $(pwd)/audio:/audio \
-w /audio pinnaman/aws-tts \
/flite/bin/flite -t "hello ajay, how are you" -o out.wav
