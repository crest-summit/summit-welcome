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

    stage 'Dev Deploy'
    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-jenkins-credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) {
        sh "docker run --rm -v $location:/aws mikesir87/aws-cli jq '.family=\"welcome-dev\" | .containerDefinitions[0].image=\"606752838354.dkr.ecr.us-east-1.amazonaws.com/summit/welcome:build-${env.BUILD_NUMBER}\"' task-definition.json > updated-task-definition.json"
        sh "docker run --rm -e AWS_DEFAULT_REGION=us-east-1 -e AWS_ACCESS_KEY_ID=$env.AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$env.AWS_SECRET_ACCESS_KEY -v $location:/aws mikesir87/aws-cli aws ecs register-task-definition --cli-input-json file://updated-task-definition.json"
        sh "docker run --rm -e AWS_DEFAULT_REGION=us-east-1 -e AWS_ACCESS_KEY_ID=$env.AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$env.AWS_SECRET_ACCESS_KEY -v $location:/aws mikesir87/aws-cli aws ecs update-service --cluster static-dev --service welcome-dev-service --task-definition welcome-dev"
    }

}
