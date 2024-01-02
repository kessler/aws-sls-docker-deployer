# aws-sls-docker-deployer

Creates docker images to deploy serverless lambdas to aws linux. This is good for when you have native deps that needs to be compiled to aws linux before they are used.

Basically, runs `npm install` / `pipenv install` inside the container and then runs `serverless deploy`

There are two "flavors" one for nodejs and one for python.

The nodejs one is set on node v18 while the python is set for v3.9

## building the images

make sure you have docker installed then `./build-node.sh` or `./build-python.sh`

## using the images

The images accept the source via mounting to a preset directory (/app). To use the image, run it:

```bash
docker run --env-file .awsenv -v `pwd`:/app sls-node-deployer --stage=dev
```
1. the ```.awsenv``` file should contain the environment variables: 

```ini
AWS_ACCESS_KEY_ID=id here
AWS_SECRET_ACCESS_KEY=secret here
```

if using aws sso, then this file can be generated via:

```bash
aws configure export-credentials --profile <your profile name here> --format env-no-export > .awsenv
```

2. ```-v \`pwd\`:/app``` mounts the current directory to /app dir inside the container, this is where the lambda's code should be.

3. all the arguments after `sls-node-deployer` are passed "as is" to `sls deploy` command, in this example ```--stage=dev``` is passed

## TODO
1. complete python implementation
2. fix code replication between node/python related files