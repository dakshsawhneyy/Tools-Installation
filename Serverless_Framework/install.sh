npm install -g serverless

# Run the command to create a new service from the AWS Node.js template:
serverless create --template aws-nodejs --path serverless_framework

# For Canary Deployment -- deploymentSettings Block --
npm install --save-dev serverless-plugin-canary-deployments
