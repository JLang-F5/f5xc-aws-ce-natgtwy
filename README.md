# f5xc-aws-ce-natgtwy
Build and deploy a f5xc ce in aws and register via a nat gateway

Apply:
Step 1 - In aws_infra direcotry fillout variables or terrafomr.tfvars file
Step 2 - From aws_infra directory run (first time only - terraform init) then terraform plan then terraform apply
Step 3 - Get all relevant info for XC Site build
Step 4 - Change directories to XC_Site 
Step 5 - Export p12 file and password export VES_P12_PASSWORD=password export VOLT_API_P12_FILE=path/to/p12/file
Step 6 - Update variables or .tfvars file
Step 7 - Apply Site (first time only - terraform init) then terraform plan then terraform apply

Destroy:
Step 1 - In XC_Site folder run terraform destroy
Step 2 - Validate Site has been destroyed and log into XC console and under aws vpc site - delete the site
Step 3 - Change Directory to aws_infra
Step 4 - run terraform destroy
Step 5 - validate all resource are destroyed

