# Multitool

Multi tool image based on [Debian "bookworm"](https://www.debian.org/releases/bookworm/), inspired by [Praqma/Network-Multitool](https://github.com/Praqma/Network-MultiTool).

There are 5 versions:
- [General purpose](multitool) The base multitool image with lots of handy stuff included. See [Dockerfile](multitool/Dockerfile#L13-L19) for details.
	- Images: [nyvanga/multitool](https://hub.docker.com/r/nyvanga/multitool)
- [Terraform](multitool-tf): Multi tool image with Terraform installed. Builds the latest 3 versions occasionally.
	- Images: [nyvanga/multitool-tf](https://hub.docker.com/r/nyvanga/multitool-tf)
- [Kubernetes](multitool-k8s): Multi tool image with kubectl included, and running ```kubectl proxy``` as entrypoint.
	- Images: [nyvanga/multitool-k8s](https://hub.docker.com/r/nyvanga/multitool-k8s)
- [AWS CLI v1](multitool-aws-v1): Multi tool image with AWS CLI v1 included.
	- Images: [nyvanga/multitool-aws:v1](https://hub.docker.com/r/nyvanga/multitool-aws)
- [AWS CLI v2](multitool-aws-v2): Multi tool image with AWS CLI v2 included.
	- Images: [nyvanga/multitool-aws](https://hub.docker.com/r/nyvanga/multitool-aws)
