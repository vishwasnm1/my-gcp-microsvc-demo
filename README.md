# Step by Step Instructions for setup and deploy of GCP Microservices Demo Project via terraform and Github Actions

Reference from [GoogleCloudPlatform/microservices-demo](https://github.com/GoogleCloudPlatform/microservices-demo)

## Prerequisites
1. GCP account is required, if not please setup a free trail
2. [Create a new project or use an existing project](https://cloud.google.com/resource-manager/docs/creating-managing-projects#console) on Google Cloud, and ensure [billing is enabled](https://cloud.google.com/billing/docs/how-to/verify-billing-enabled) on the project.


## Steps:
1. Firstly in GCP create a service account and Workload identity federated pool. This is required to authenticate to GCP from github actions without the requirement of access keys/secrets. The reference documentation for this setup [here](https://cloud.google.com/blog/products/identity-security/enabling-keyless-authentication-from-github-actions)
   ![image](https://github.com/user-attachments/assets/4da95321-b9b5-4eb9-973a-67b213bbf8dd)
2. Enable the Google Kubernetes Engine API for the resprective GCP project.
3. In GitHub setup github workflow to create Kubernetes clusters via terraform. Terraform workflow composed [here](https://github.com/vishwasnm1/my-gcp-microsvc-demo/blob/main/.github/workflows/terraform.yml)
4. Configure GitHub secrets to secure the parameters that are to be passed in the workflow run-time.
   GCP_PROJECT_ID - GCP Project id
   SERVICE_ACCOUNT - service account details
   WIP_NAME - Workload identity federation pool deatils
   BUCKET_TF_STATE - Cloud Storage Bucket to store terraform backend state files
   ![image](https://github.com/user-attachments/assets/a93852c1-645e-493c-b5f4-d8f27e1af42d)
5. Create terraform folder and tf files which conisits of logic to create GKE cluster. Terraform folder - [here](https://github.com/vishwasnm1/my-gcp-microsvc-demo/tree/main/terraform)
6. Build terraform workflow to create infrastructure for GKE Cluster. GitHub Actions run - https://github.com/vishwasnm1/my-gcp-microsvc-demo/actions/runs/12741300195/job/35507691596
7. Once cluster is created, capture the cluster details.
8. 

