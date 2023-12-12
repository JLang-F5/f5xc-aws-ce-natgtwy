# f5xc-aws-ce-natgtwy

This is a non-official F5 repository.  This repo is not supported by F5 or DevCentral!

This repo will provide a solution for deploying F5 XC Secure Mesh via a NAT Gateway in AWS.

# Distributed Cloud AWS Secure Mesh via NaGateway Deployment

The goal of this solution is to provide the infrastructure for a working demo to deploy F5 Distributed Cloud Secure Mesh CE in AWS without a EIP on SLO of CE and through a NAT Gateway.
<!--TOC-->

- [F5 Distributed Cloud AWS Secure Mesh Nat Gateway Deployment](#f5-distribued-cloud-aws-secure-mesh-nat-gateway-deployment)
  - [Prerequisites](#prerequisites)
  - [F5 Distributed Cloud Configuration(s)](#f5-distributed-cloud-configurations)
  - [API Certificate](#api-certificate)
  - [Terraform](#terraform)
  - [To do](#to-do)
  - [High Level Topology](#topology)
  - [Requirements](#requirements)
  - [Inputs](#inputs)
  - [Deployment](#deployment)
  - [Troubleshooting](#troubleshooting)
  - [Support](#support)
  - [Community Code of Conduct](#community-code-of-conduct)
  - [License](#license)
  - [Copyright](#copyright)
  - [F5 Networks Contributor License Agreement](#f5-networks-contributor-license-agreement)

<!--TOC-->
## Prerequisites
- A Distributed Cloud Services Account.

## F5 Distributed Cloud Configuration(s)

Within F5 Distributed Cloud (F5XC), you will need to create yourself an API Certificate.  We will be be using the [F5 XCS Terraform Provider](https://registry.terraform.io/providers/volterraedge/volterra/latest/docs).

### API Certificate

1. Log in to your F5 XC Console.
2. In the upper right-hand corner, click the User Account Icon.
3. Then click "Account Settings"

![Screen Shot 2](/img/xcconsole.png)

4. Click Add Credentials
5. Enter a Credential Name
6. Verify that Credential Type is set to 'API Certificate'
7. Set a password
8. Set an Expiration date
9. Download your Key Pair

![Screen Shot 3](/img/credentials.png)

## Terraform

> **_Credentials:_** Before we get to the Terraform variables, there is an example prep script provided, this CAN be used to map API Certificate and password to ENV Vars, but you can use whatever method you are comfortable with for secrets.

```bash
export VOLT_API_P12_FILE=/creds/api-creds.p12
export VES_P12_PASSWORD=12345678
```

Run the script to map creds.

```bash
. ./prep.sh
```
Alternatively, you may extract the SSL certificate and key into separate files for use, vs using environment variables.

Extract Private Key
```bash
openssl pkcs12 -in <F5XC-tenant>.console.ves.volterra.io.api-creds.p12 -legacy -nodes -nocerts -out f5xc-api.key
```

Extract Certificate
```bash
openssl pkcs12 -in <F5XC-tenant>.console.ves.volterra.io.api-creds.p12 -legacy -nodes -out f5xc-api.cer
```

## To do

- Steps to deploy using this repo:
    - Apply
        - In aws_infra directory, make a copy of the 'terraform.tfvars.example' file and save it as terraform.tfvars
        - Update variables within terraform.tfvars file to match your environment
            - Run (first time only - terraform init) then terraform plan.  Validate the output is what you expected, then run terraform apply
            - Get all relevant info for XC Site build 
                - natgateway-id
                - subnet-id's
                    - Inside (SLI)
                    - OutSide (SLO)
                    - Workload
                - vpc-id
                - security-group-id
        - Change directories to xc_site
            - Export p12 file and password 
                - export VES_P12_PASSWORD=password 
                - export VOLT_API_P12_FILE=path/to/p12/file
            - Make a copy of the 'terraform.tfvars.example' file and save it as terraform.tfvars
            - Update variables.tf or terraform.tfvars file
            - Add aws cloud credentials to Distributed Cloud tenant 
                -  - [F5 Distributed Cloud AWS Pre-reqs](https://docs.cloud.f5.com/docs/reference/cloud-cred-ref/aws-vpc-cred-ref)
                -  - [F5 Distributed Cloud Upload AWS Cloud Credentials](https://docs.cloud.f5.com/docs/how-to/site-management/cloud-credentials)
            - Run (first time only - terraform init) then terraform plan.  Validate the output if it is what is expected then run terraform apply
    - Destroy / Clean Up
        - From xc_site directory 
            - run terraform destroy
            - Validate from XC console the Secure Mesh site was destroyed go into AWS VPC Site and Delete the site 
        - Change directories to aws_infra
            - run terraform destroy
            - Validate from the AWS console all AWS resources have been destroyed

## Topology
- High Level Topology 



<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [aws](#requirement\_aws) | ~> 4.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | 2.1.1 |
| <a name="requirement_volterrarm"></a> [volterrarm](#requirement\_volterrarm) | 0.11.28 |

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|


## Deployment

For manual deployment you can do the traditional terraform commands.

```bash
terraform init
terraform fmt
terraform plan
terraform apply --auto-approve
terraform destroy --auto-approve
```

<!-- For auto deployment you can do with the deploy.sh and destroy.sh scripts.

```bash
./deploy
./destroy
``` -->

## Troubleshooting

Please refer to the following: 
- F5 Distributed Cloud
    - [F5 Distributed Cloud](https://docs.cloud.f5.com/docs/)
- Terraform
    - [F5 Distributed Cloud Terraform Registry](https://registry.terraform.io/providers/volterraedge/volterra/latest/docs).

## Support

For support, please open a GitHub issue.  Note, the code in this repository is community supported and is not supported by F5 Networks.  For a complete list of supported projects please reference [SUPPORT.md](SUPPORT.md).

## Community Code of Conduct

Please refer to the [F5 DevCentral Community Code of Conduct](code_of_conduct.md).

## License

[GNU License 3.0](LICENSE)

## Copyright

Copyright 2014-2023 F5 Networks Inc.

### F5 Networks Contributor License Agreement

Before you start contributing to any project sponsored by F5 Networks, Inc. (F5) on GitHub, you will need to sign a Contributor License Agreement (CLA).

If you are signing as an individual, we recommend that you talk to your employer (if applicable) before signing the CLA since some employment agreements may have restrictions on your contributions to other projects.
Otherwise by submitting a CLA you represent that you are legally entitled to grant the licenses recited therein.

If your employer has rights to intellectual property that you create, such as your contributions, you represent that you have received permission to make contributions on behalf of that employer, that your employer has waived such rights for your contributions, or that your employer has executed a separate CLA with F5.

If you are signing on behalf of a company, you represent that you are legally entitled to grant the license recited therein.
You represent further that each employee of the entity that submits contributions is authorized to submit such contributions on behalf of the entity pursuant to the CLA.

