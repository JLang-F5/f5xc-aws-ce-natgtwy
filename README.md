# f5xc-aws-ce-natgtwy

This is a non-official F5 repository.  This repo is not supported by F5 or DevCentral!

This repo will provide a solution for deploying F5 XC Secure Mesh via a NAT Gateway in AWS.

# Distributed Cloud AWS Secure Mesh via NaGateway Deployment

The goal of this solution is to provide the infrastructure for a working demo to deploy F5 Distributed Cloud Secure Mesh in AWS wihtout a CE EIP and through a NAT Gateway.
<!--TOC-->

- [F5 Distributed Cloud AWS Secure Mesh Nat Gateway Deployment](#f5-distribued-cloud-aws-secure-mesh-nat-gateway-deployment)
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

## To do

- Steps to deploy using this repo:
    - Apply
        - In aws_infra direcotry fill out variables or terrafomr.tfvars file
        - From aws_infra directory run (first time only run - terraform init) then terraform plan then terraform apply
        - Get all relevant info for XC Site build (natgateway-ID, subnet-ID's, vpc-id, security-group-id, etc...)
        - Change directories to xc_site
        - Export p12 file and password export VES_P12_PASSWORD=password export VOLT_API_P12_FILE=path/to/p12/file
        - Update variables or .tfvars file
        - Add aws cloud credentials to Distributed Cloud tenant 
            -  - [F5 Distributed Cloud AWS Pre-reqs](https://docs.cloud.f5.com/docs/reference/cloud-cred-ref/aws-vpc-cred-ref)
    - Destroy
        - From xc_site directory 
        - run terraform destroy
        - validate from xc console the Secure Mesh site was destroyed go into AWS VPC Site and Delete the site 
        - change directories to aws_infra
        - run terraform destroy
        - Validate from the aws console all aws resources have been destroyed

## Topology
- High Level Topology 



<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [aws](#requirement\_aws) | ~> 4.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | 2.1.1 |
| <a name="requirement_volterrarm"></a> [volterrarm](#requirement\_volterrarm) | 0.11.6 |

## Inputs

| Name | Description | Type | Default |
|------|-------------|------|---------|


## Deployment

For manual deployment you can do the traditional terraform commands.

```bash
terraform init
terraform plan
terraform apply --auto-approve
```

For auto deployment you can do with the deploy.sh and destroy.sh scripts.

```bash
./deploy
./destroy
```

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

[Apache License 2.0](LICENSE)

## Copyright

Copyright 2014-2022 F5 Networks Inc.

### F5 Networks Contributor License Agreement

Before you start contributing to any project sponsored by F5 Networks, Inc. (F5) on GitHub, you will need to sign a Contributor License Agreement (CLA).

If you are signing as an individual, we recommend that you talk to your employer (if applicable) before signing the CLA since some employment agreements may have restrictions on your contributions to other projects.
Otherwise by submitting a CLA you represent that you are legally entitled to grant the licenses recited therein.

If your employer has rights to intellectual property that you create, such as your contributions, you represent that you have received permission to make contributions on behalf of that employer, that your employer has waived such rights for your contributions, or that your employer has executed a separate CLA with F5.

If you are signing on behalf of a company, you represent that you are legally entitled to grant the license recited therein.
You represent further that each employee of the entity that submits contributions is authorized to submit such contributions on behalf of the entity pursuant to the CLA.

