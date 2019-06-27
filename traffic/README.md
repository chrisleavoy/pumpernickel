# Project Pumpernickel Traffic Management

This is a terraform project to manage the global DNS and corresponding health checks for pumpernickel.sdk.ca.

Traffic is distributed between AWS as the Primary, and GCP as a secondary failover site.

## Operations

### Temporarily remove AWS from DNS

The follow would route all requests into GCP unless it becomes unhealthy. If both AWS and GCP are unhealthy, answers would be sent for both sites evenly.

```shell
terraform apply -var aws_weight=0 -var gcp_weight=10
```
