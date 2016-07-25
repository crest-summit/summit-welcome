node {

    sh "pwd > location"
    def location = readFile("location").trim()
    sh "rm location"


    stage 'Checkout'
    checkout scm

    stage 'build image'
    docker.build "summit/welcome"

    stage 'push image'
    docker.withRegistry('https://606752838354.dkr.ecr.us-east-1.amazonaws.com', 'ecr:aws-jenkins-credentials') {
        docker.image('summit/welcome').push('latest');
        docker.image('summit/welcome').push("build-${env.BUILD_NUMBER}")
    }

}
