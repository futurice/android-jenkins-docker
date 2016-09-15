# android-jenkins-docker
Docker image with Jenkins that can build Android apps.

# Building the image
Run the command
>docker build -t android-jenkins .

# Run the image
Run the command
>docker run --name android-jenkins -p 8080:8080 -p 50000:50000 -v SOME_HOST_PATH:/var/jenkins_home android-jenkins

Replace ```SOME_HOST_PATH``` with the path to a folder on your host system where you want Jenkins to store its builds and configurations, for example ```/var/android_jenkins_home``` on Linux systems. If port 8080 is already used by another process on your host, you can modify which port redirects to Jenkins. If you want Jenkins to be accessible on port 8090 on your host, then replace the port argument with ```8090:8080``` in the run command.

## Windows tips
