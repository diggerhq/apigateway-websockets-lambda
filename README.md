# apigateway-websockets-lambda
Sample repository for using API gateway to handle lambda websockets

# Steps

## 1. Create default ECR repository

Use the following to create a default ECR repository in your region:

```
dg env create default --target diggerhq/target-lambda@default
dg env apply default
```
Once this command is done you will see a docker_registry as output. You can copy that value and append `:latest` to it. Create a file `digger.config.yml` and include the following contents in it:

```
default:
  image_uri: "<<account_id>>.dkr.ecr.eu-central-1.amazonaws.com/lambda-default:latest"
```

## 2. Create an environment

## 3. Create DynamoDB table

## 4. Configure API gateway

## 5. Test the websocket connection

You can test using `wscat`:

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
