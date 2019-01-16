pipeline {
    agent any

    stages {
        stage('Build image') {
            steps {
                sh 'docker build . -t "awscli"'
            }
        }
        stage('Build html') {
            steps {
                sh 'docker run awscli make install'
		sh 'docker run awscli ls "./api-docs/node_modules/.bin/parcel 2>/dev/null"'
                sh 'docker run awscli make html-production'
            }
        }
        stage('Upload HTML files') {
            steps {
                sh '${DOCKER_CMD} s3 cp build/html s3://${AWS_BUCKET}/ --recursive ${AWS_OPTIONS} \
                        --exclude ".buildinfo" \
                        --exclude "contents" \
                        --exclude "genindex" \
                        --exclude "objects.inv" \
                        --exclude "search" \
                        --exclude "searchindex.js" \
                        --exclude "_sources/*" \
                        --exclude "_images/*" \
                        --exclude "_static/*" \
                        --content-type "text/html"'
            }
        }
        stage('Upload static assets') {
            steps {
                sh '${DOCKER_CMD} s3 cp build/html/_images s3://${AWS_BUCKET}/_images/ --recursive ${AWS_OPTIONS}'
                sh '${DOCKER_CMD} s3 cp build/html/_static s3://${AWS_BUCKET}/_static/ --recursive ${AWS_OPTIONS}'
             }
        }
        stage('Upload static content to assets directory') {
            steps {
                sh '${DOCKER_CMD} s3 cp build/html/_images s3://${AWS_BUCKET}/assets/_images/ --recursive ${AWS_OPTIONS}'
                sh '${DOCKER_CMD} s3 cp build/html/_static s3://${AWS_BUCKET}/assets/_static/ --recursive ${AWS_OPTIONS}'
            }
        }
    }

    post {
        success {
			sh '${DOCKER_CMD} cloudfront create-invalidation --distribution-id "${CLOUDFRONT_DISTRIBUTION_ID}" --paths "/*"'
            slackSend (color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        }

        failure {
            slackSend (color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
        }
    }

    environment {
        AWS_BUCKET = 'centra-api-documentation'
        AWS_REGION = credentials('api-docs-aws-region')
        AWS_ACCESS_KEY_ID = credentials('api-docs-aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('api-docs-aws-secret-access-key')
        AWS_OPTIONS = "${'--region ' + env.AWS_REGION + ' --cache-control max-age=3600'}"
        DOCKER_CMD = 'docker run awscli aws'
    }
}
