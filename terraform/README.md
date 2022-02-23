# Terraform

This is a project to deploy a simple infrastructure containing a
- EKS cluster with a VPC 
- ECR for our Docker images
- Codebuild for our pipeline

![](Screen Shot 2022-02-22 at 21.37.14.png)

### AWS ECR
```
cd ecr/multi-repo
terraform init
terraform apply
```

### AWS Codebuild
```
cd ci
terraform init
terraform apply
```


### AWS EKS
It will deploy the EKS cluster
```
cd eks
terraform init
terraform apply
```

The following script will:
- Update local kubeconfig
- Install the recommended Kubernetes packages
- Create an admin RBAC to access the Kubernetes dashboard
- Generate a secret for the Kubernetes dashboard
```
./eks_kubeconfig.sh 
```
