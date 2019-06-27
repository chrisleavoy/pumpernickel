# Project Pumpernickel

This demo project hosts Wordpess and MySQL in Kubernetes over both AWS (EKS) and GCP (GKE).

## Prerequisuites

* Working AWS (EKS) and GCP (GKE) Kubernetes Clusters
* Private VPC peering between the AWS VPC and the GCP VPC
* Portworx for persistent volume management

## Tools

* k14s - Kubernetes Tools that follow Unix philosophy to be simple and composable
  * k14s/ytt - https://get-ytt.io - ytt is a templating tool that understands YAML structure allowing you to focus on your data instead of how to properly escape it.
  * k14s/kapp - https://get-kapp.io/ -  is a simple deployment tool focused on the concept of "Kubernetes application" — a set of resources with the same label.
* k9s - https://k9ss.io/ - Kubernetes CLI To Manage Your Clusters In Style
* Terraform - https://www.terraform.io/ - Write, Plan, and Create Infrastructure as Code

## Details

* Simple Wordpress Site on Kubernetes
* MySQL Multi-Master Asynchronous MIXED mode Replication between AWS and GCP
* Route53 DNS management with Terraform

## Setup

1. Deploy to AWS

    ```shell
    cd app
    ytt -f . -v k8s_env="chris-aws" | \
    kapp deploy -a simple-app -f- --diff-changes --kubeconfig-context chris-aws
    ```

2. Deploy to GCP

    ```shell
    cd app
    ytt -f . -v k8s_env="chris-gcp" | \
    kapp deploy -a simple-app -f- --diff-changes --kubeconfig-context chris-gcp
    ```

3. Setup Traffic

    ```shell
    cd traffic
    terraform apply -var aws_weight=0 -var gcp_weight=10
    ```

## Operations

Lets say we want to temporarily remove AWS from DNS. The follow would route all requests into GCP unless it becomes unhealthy. If both AWS and GCP are unhealthy, answers would be sent for both sites evenly.

```shell
terraform apply -var aws_weight=0 -var gcp_weight=10
```
