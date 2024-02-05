# Multitool for AWS

AWS CLI v2 is installed as described [here](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)!

Run on docker:
```
docker run -it --rm -v $HOME/.aws:/root/.aws --name multitool-aws nyvanga/multitool-aws
```

Directly run AWS commands:
```
docker run -it --rm -v $HOME/.aws:/root/.aws --name multitool-aws nyvanga/multitool-aws s3api list-buckets
```

Directly run scripts in `/usr/local/bin`:
```
docker run -it --rm -v $HOME/.aws:/root/.aws --name multitool-aws nyvanga/multitool-aws s3_delete_all_versions.py <bucket-name>
```

## Test build

First run:
```
docker compose up -d --build
```

Then to access the container:
```
docker compose exec -- test_build_multitool_aws_v2 bash
```

It will volume mount your ```$HOME/.aws``` folder into the container, so make sure it has the right AWS config and credentials.
