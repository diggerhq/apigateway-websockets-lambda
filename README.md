# apigateway-websockets-lambda
Sample repository for using API gateway to handle lambda websockets

# Steps

## 1. Create default ECR repository

Use the following to create a default ECR repository in your region:

```
dg env create default --target diggerhq/target-lambda@default
dg env apply default
# This is needed to create an initial image in the repository (you can select any service)
dg env build
dg env push
```
Once this command is done you will see a docker_registry as output. You can copy that value and append `:latest` to it. Create a file `digger.config.yml` and include the following contents in it:

```
default:
  image_uri: "<<account_id>>.dkr.ecr.eu-central-1.amazonaws.com/lambda-default:latest"
```

## 2. Create an environment

Use the following commands to create the environment with your services:

```
dg env create test --target diggerhq/target-lambda@ws
dg env apply test
```

## 3. Create DynamoDB table

Create a DynamoDB table with a name of your chooice. Next, you can configure the environment variables as follows:

<img width="1251" alt="Screenshot 2021-05-24 at 22 28 45" src="https://user-images.githubusercontent.com/1627972/119398098-bf692500-bcdf-11eb-950b-4e18e73e45d5.png">


over in app.digger.dev, create the following environment variable with `TABLE_NAME={your_table_name}`

<img width="1280" alt="Screenshot 2021-05-24 at 22 30 54" src="https://user-images.githubusercontent.com/1627972/119398110-c2641580-bcdf-11eb-99e3-f62ba953a3dd.png">


# 4. Release your services

```
# (select any service)
dg env build test
dg env push test
# do the release for all services
dg env release test
```

## 4. Configure API gateway

The template will create an API Gateway with the name of `{project_name}-{environment_name}`

You need to link three endpoints to your corresponding three services: `onConnect`, `onDisconnect` and `sendMessage`

<img width="1280" alt="Screenshot 2021-05-24 at 22 31 44" src="https://user-images.githubusercontent.com/1627972/119407446-e9751400-bcec-11eb-9f89-1474069cb36c.png">


Finally you need to deploy your API. Create a new stage (example Default). Note down the API Gateway URL as well as the stage name for the next step.


## 5. Test the websocket connection

For this step you can use the Gateway Endpoint as well as the stage as you have noted them down in the next step. You can test using `wscat`:

```
npm install -g wscat
```

```
$ wscat -c wss://{YOUR-API-ID}.execute-api.{YOUR-REGION}.amazonaws.com/{STAGE}
```

Send message and check that it is received from other clients:

```
$ wscat -c wss://{YOUR-API-ID}.execute-api.{YOUR-REGION}.amazonaws.com/prod
connected (press CTRL+C to quit)
> {"action":"sendmessage", "data":"hello world"}
< hello world
```

### Acknowledgements

Thanks to Simple websockets chat app for the inspiration: https://github.com/aws-samples/simple-websockets-chat-app
