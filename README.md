# Apache Kafka AMI
This is based on the git project `https://github.com/fscm/packer-aws-kafka` that was outdated and needed to be rewritten. 

AMI that should be used to create virtual machines with Apache Kafka
installed.

## Synopsis

This script will create an AMI with Apache Kafka installed and with all of
the required initialization scripts.

The AMI resulting from this script should be the one used to instantiate a
Kafka server (standalone or cluster).

## What are we building 

![Layout for Kafka](docs/demo_functional_diagram_kafka.jpg)

## Getting Started

There are a couple of things needed for the script to work.

### Prerequisites

Packer and AWS Command Line Interface tools need to be installed on your local
computer. You also need Terraform and the terraform wrapper called `terragrunt`.  
To build a base image you have to know the id of the latest Debian AMI files
for the region where you wish to build the AMI.

#### Packer

Packer installation instructions can be found
[here](https://www.packer.io/docs/installation.html).

We start with building the packer image, or take the one that is already there. Look for a name like: 
`kafka-2.1.1-(20190527012503)` and take the AMI ID and past that into the variable file (terraform/vars.tf)
See below



#### AWS Command Line Interface

AWS Command Line Interface installation instructions can be found [here](http://docs.aws.amazon.com/cli/latest/userguide/installing.html)

#### Debian AMI's for Packer

This AMI will be based on an official Debian AMI (Stretch 9). The latest version of that
AMI will be used.

A list of all the Debian AMI id's can be found at the Debian official page:
[Debian official Amazon EC2 Images](https://wiki.debian.org/Cloud/AmazonEC2Image/)

### Usage

In order to create the AMI using this packer template you need to provide a
few options.
Set the two environment vars to have the aws access and secret keys (And do not submit these to git, duh)
Also replace the AWS_REGION by the AWS [region](https://docs.aws.amazon.com/general/latest/gr/rande.html) you want to deploy to.
and set the SSH_PUBLIC_KEY_STRING  
```
Usage:
packer build \
    -var "aws_access_key=$AWS_ACCESS_KEY" \
    -var "aws_secret_key=$AWS_SECRET_KEY" \
    -var 'aws_region=ap-southeast-2' \
    -var 'kafka_version=2.1.1' \
    -var "aws_public_key=$SSH_PUBLIC_KEY_STRING" \   
    kafka.json
  
```

#### Script Options

- `aws_access_key` - *[required]* The AWS access key.
- `aws_ami_name` - The AMI name (default value: "kafka").
- `aws_ami_name_prefix` - Prefix for the AMI name (default value: "").
- `aws_instance_type` - The instance type to use for the build (default value: "t2.micro").
- `aws_region` - *[required]* The regions were the build will be performed.
- `aws_secret_key` - *[required]* The AWS secret key.
- `java_build_number` - Java build number (default value: "11").
- `java_major_version` - Java major version (default value: "8").
- `java_token` - Java link token (default version: "d54c1d3a095b4ff2b6607d096fa80163").
- `java_update_version` - Java update version (default value: "131").
- `kafka_scala_version` - Kafka Scala version (default value: "2.11").
- `kafka_version` - *[required]* Kafka version.
- `system_locale` - Locale for the system (default value: "en_US").
- `zookeeper_version` - Zookeeper version (default value: "3.4.9").

#### Terraform 
You need to create or change the .aws/credentials file to be able to run against your aws account. Adapt it in the provider.tf file.  
Then run from the terraform folder, put in the vars section the name of the image just build. 
For instance: 

```bash
export SSH_PUBLIC_KEY_STRING=<yourkey>
terraform plan -var 'base_kafka_image_aim=ami-05aa27f98e8b3c6b8'  -var "aws_public_key=$SSH_PUBLIC_KEY_STRING" -out kafka.plan
``` 
Note that if you want to interpolate the bash variables you need to use double quotes around the values, not single quotes as otherwise this will take the literal string and not
the value in it. 


Then apply it by 
```bash
terraform apply kafka.plan
```

You also need to create a terragrunt/secrets.tfvars file with the ssh key you use to get to the kafka instance.
This is then injected by terragrunt.  



```bash
aws_public_key = "YOUR PUBLIC KEY HERE"
```


The secret* pattern is excluded from git so it will not be pushed into git. 


Now use the kafka.json script with packer to create the kafka image to use, this can be done by adding it to the commandline as before or set it in the 
default of the variable in the var.tf file. The script returns a ami id and you need to place 
this into the vars.tf file.
For instance 
```hcl-terraform
variable "base_kafka_image_aim" {
  type = "string"
  default = "ami-03fd73a66cf574a36"
}
```

After the terraform apply we have three servers, one with a public ip to be able to set up the cluster, and then two other brokers running on the same machine / base image. 


#### Result 
We now have three kafka servers with a fixed IP address 
10.201.1.100 - 10.201.1.101 - 10.201.1.102 with the first public accessible. (Note, you would never do that in production)

### Instantiate a Cluster

In order to end up with a functional Kafka Cluster some configurations have to
be performed after instantiating the servers.

To help perform those configurations a small script is included on the AWS
image. The script is called **kafka_config**.

A Zookeeper instance or cluster (for production environments) is required to
instantiate a Kafka cluster.

If required, a Zookeeper server/node can be started within this image (see
below for more information) however, for production environments, it is
recommended to use a dedicated and separated Zookeeper instance or cluster.

#### Kafka Configuration Script

The script can and should be used to set some of the Kafka options as well as
setting the Kafka service to start at boot.

```
Usage: kafka_config [options]
```

##### Options

* `-a <ADDRESS>` - Sets the Kafka broker advertised address (default value is 'localhost').
* `-D` - Disables the Kafka service from start at boot time.
* `-E` - Enables the Kafka service to start at boot time.
* `-i <ID>` - Sets the Kafka broker ID (default value is '0').
* `-m <MEMORY>` - Sets Kafka maximum heap size. Values should be provided following the same Java heap nomenclature.
* `-S` - Starts the Kafka service after performing the required configurations (if any given).
* `-W <SECONDS>` - Waits the specified amount of seconds before starting the Kafka service (default value is '0').
* `-z <ENDPOINT>` - Sets a Zookeeper server endpoint to be used by the Kafka broker (defaut value is 'localhost:2181'). Several Zookeeper endpoints can be set by either using extra `-z` options or if separated with a comma on the same `-z` option.

We configure and run the kafka and zookeepers from the user_data script in the terraform script. 
Check the `template.tf` and the `instances.tf` scripts. For documentation we show what we actually run on the 
servers on deployment complete: 


We are running from the 10.201.1.100 (Public broker 0)
```bash
# Zoopkeeper
zookeeper_config -E -S -i 1 -m 512m -n 1:0.0.0.0,2:10.201.1.101,3:10.201.1.102

# Kafka
kafka_config -a 10.201.1.100 -E -i 1 -m 2048m -S -z 10.201.1.100:2181,10.201.1.101:2181,10.201.1.102:2181
```


We are running from the 10.201.1.101 (Private broker 0)
```bash
# Zoopkeeper
zookeeper_config -E -S -i 2 -m 512m -n 1:10.201.1.100,2:0.0.0.0,3:10.201.1.102

# Kafka
kafka_config -a 10.201.1.101 -E -i 2 -m 2048m -S -z 10.201.1.100:2181,10.201.1.101:2181,10.201.1.102:2181
```


We are running from the 10.201.1.102 (Private broker 1)
```bash
# Zoopkeeper
zookeeper_config -E -S -i 3 -m 512m -n 1:10.201.1.100,2:10.201.1.101,3:0.0.0.0

# Kafka
kafka_config -a 10.201.1.102 -E -i 3 -m 2048m -S -z 10.201.1.100:2181,10.201.1.101:2181,10.201.1.102:2181
```


#### Configuring a Kafka Broker

To prepare an instance to act as a Kafka broker the following steps need to be
performed.

Run the configuration tool (*kafka_config*) to configure the instance.

```
kafka_config -a kafka01.mydomain.tld -E -S -i 1 -z zookeeper01.mydomain.tld:2181
```

Localhost:
```bash
kafka_config -a localhost -E -S -i 1 -z localhost:2181
```

After this steps a Kafka broker (for either a single instance or a cluster
setup) should be running and configured to start on server boot.

More options can be used on the instance configuration, see the
[Configuration Script](#kafka-configuration-script) section for more details

### Instantiate Zookeeper

Is it possible to use the included Zookeeper installation to instantiate a
Zookeeper node (standalone or as part of a cluster).

In order to end up with a functional Zookeeper node some configurations have to
be performed after instantiating the servers.

To help perform those configurations a small script is included on the AWS
image. The script is called **zookeeper_config**.

#### Zookeeper Configuration Script

The script can and should be used to set some of the Zookeeper options as well
as setting the Zookeeper service to start at boot.

```
Usage: zookeeper_config [options]
```

##### Options

* `-D` - Disables the Zookeeper service from start at boot time.
* `-E` - Enables the Zookeeper service to start at boot time.
* `-i <ID>` - Sets the Zookeeper broker ID (default value is '1').
* `-m <MEMORY>` - Sets Zookeeper maximum heap size. Values should be provided following the same Java heap nomenclature.
* `-n <ID:ADDRESS>` - The ID and Address of a cluster node (e.g.: '1:127.0.0.1'). Should be used to set all the Zookeeper nodes. Several Zookeeper nodes can be set by either using extra `-n` options or if separated with a comma on the same `-n` option.
* `-S` - Starts the Zookeeper service after performing the required configurations (if any given).
* `-W <SECONDS>` - Waits the specified amount of seconds before starting the Zookeeper service (default value is '0').

First start: 
```bash
sudo su
zookeeper_config -E -i 1 -m 512m -n 1:10.201.1.140
```

#### Configuring a Zookeeper Node

To prepare an instance to act as a Zookeeper node the following steps need to
be performed.

Run the configuration tool (*zookeeper_config*) to configure the instance.

```
zookeeper_config -E -S
```

After this steps a Zookeeper node (for a standalone setup) should be running
and configured to start on server boot.

For a cluster with more than one Zookeeper node other options have to be
configured on each instance using the same configuration tool
(*zookeeper_config*).

```
zookeeper_config -E -i 1 -n 1:zookeeper01.mydomain.tld -n 2:zookeeper02.mydomain.tld,3:zookeeper03.mydomain.tld -S
```

After this steps, the first node of the Zookeeper cluster (for a three node
cluster) should be running and configured to start on server boot.

More options can be used on the instance configuration, see the
[Configuration Script](#zookeeper-configuration-script) section for more details

## Services

This AMI will have the SSH service running as well as the Kafka services. The
Zookeeper service may also be running on this AMI.
The following ports will have to be configured on Security Groups.

| Service      | Port      | Protocol |
|--------------|:---------:|:--------:|
| SSH          | 22        |    TCP   |
| Zookeeper    | 2181      |    TCP   |
| Zookeeper    | 2888:3888 |    TCP   |
| Kafka Broker | 9092      |    TCP   |

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request

Please read the [CONTRIBUTING.md](CONTRIBUTING.md) file for more details on how
to contribute to this project.

## Versioning

This project uses [SemVer](http://semver.org/) for versioning. For the versions
available, see the [tags on this repository](https://github.com/fscm/packer-aws-kafka/tags).

## Authors

* **Frederico Martins** - [fscm](https://github.com/fscm) - Initial project
* **Philip Rodrigues** - [phiro](https://github.com/phiroict)  - Expansion and upgrades

See also the list of [contributors](https://github.com/fscm/packer-aws-kafka/contributors)
who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE)
file for details
