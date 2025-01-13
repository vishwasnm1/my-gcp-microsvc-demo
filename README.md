# Step by Step Instructions for setup and deploy of GCP Microservices Demo Project via terraform and Github Actions

Reference from [GoogleCloudPlatform/microservices-demo](https://github.com/GoogleCloudPlatform/microservices-demo)

## Prerequisites
1. GCP account is required, if not please setup a free trail
2. [Create a new project or use an existing project](https://cloud.google.com/resource-manager/docs/creating-managing-projects#console) on Google Cloud, and ensure [billing is enabled](https://cloud.google.com/billing/docs/how-to/verify-billing-enabled) on the project.

## Tools used:
   - GitHub Actions - For automation of deployment to GCP
   - GCP - Google Cloud Platform to host the kubernetes
   - Kuberenets Cluster and kubectl 
   - Terraform  - For infrastructure provisiong automation 

## Steps:
1. Firstly in GCP create a service account and Workload identity federated pool. This is required to authenticate to GCP from github actions without the requirement of access keys/secrets. The reference documentation for this setup [here](https://cloud.google.com/blog/products/identity-security/enabling-keyless-authentication-from-github-actions)
   ![image](https://github.com/user-attachments/assets/4da95321-b9b5-4eb9-973a-67b213bbf8dd)

2. Enable the Google Kubernetes Engine API for the GCP project.

3. In GitHub leverage github actions workflow to create Kubernetes clusters via terraform. Terraform workflow composed [here](https://github.com/vishwasnm1/my-gcp-microsvc-demo/blob/main/.github/workflows/terraform.yml)

4. Configure GitHub secrets to secure the parameters that are to be passed in the workflow run-time.
   - GCP_PROJECT_ID - GCP Project id
   - SERVICE_ACCOUNT - service account details
   - WIP_NAME - Workload identity federation pool deatils
   - BUCKET_TF_STATE - Cloud Storage Bucket to store terraform backend state files
   ![image](https://github.com/user-attachments/assets/a93852c1-645e-493c-b5f4-d8f27e1af42d)

5. Create terraform folder and tf files which required to create GKE cluster. Terraform folder - [here](https://github.com/vishwasnm1/my-gcp-microsvc-demo/tree/main/terraform)

6. Build terraform workflow to create infrastructure for GKE Cluster. GitHub actions [run](https://github.com/vishwasnm1/my-gcp-microsvc-demo/actions/runs/12741300195/job/35507691596)

7. Once cluster is created, capture the cluster details
   ![image](https://github.com/user-attachments/assets/e4f1b08c-607c-4d7a-8db4-5077170f5d86)

8. Create a GitHub workflow to Deploy GoogleCloudPlatform/microservices-demo app. Deployment to GCP kubernetes cluster worflow is composed [here](https://github.com/vishwasnm1/my-gcp-microsvc-demo/blob/main/.github/workflows/gke-app-deploy.yml). This workflow action clones the source code required to deploy the app https://github.com/vishwasnm1/microservices-demo which is a forked from original [GoogleCloudPlatform/microservices-demo](https://github.com/GoogleCloudPlatform/microservices-demo). Secrets configured for this workflow:
      - GKE_CLUSTER - GCP Kuberbets Cluster name
      - GKE_REGION - GCP region
   ![image](https://github.com/user-attachments/assets/8f79f581-24d5-450d-8ea8-9bc9bc12d77b)

10. Build the workflow to deploy the app to our GKE cluster - [workflow run](https://github.com/vishwasnm1/my-gcp-microsvc-demo/actions/runs/12743319240)

11. Application deployed to GKE - success, as seen from GCP Console pods are running/healthy
    ![image](https://github.com/user-attachments/assets/5370c450-ec89-4331-9df9-d5ea0cc616f7)

12. Application launched from public url: http://35.193.71.177/
    ![image](https://github.com/user-attachments/assets/eca1d8a4-2cbb-4efa-b157-455a424bdfe8)
    Note: Currently the Public URL is IP based, to enable DNS based url a sample domain can be purchased and GCP Cloud DNS routing has to be performed
