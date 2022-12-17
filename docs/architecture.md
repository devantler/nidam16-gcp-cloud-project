# Architecture

- The frontend app should be an app that can be installed on a phone or tablet or a PWA.
- The backend should be integrated into the Google Cloud Platform using Terraform and GitHub Actions.

## Diagram

```plantuml
@startuml
skinparam linetype polyline

' Entities
actor User
actor Developer

artifact "GitHub Repository"
agent "GitHub Action" as gha
agent "Terraform Job" as iac

interface "GCP APIs" as gcpapis
cloud GCP {
    interface "Cloud CDN" as cdn
    interface "Load Balancer" as lb1
    interface "Load Balancer" as lb2
    package "Cloud Run" {
        [WebFrontend]
        [Backend]
    }
    database "MongoDB Atlas" as mongo
    database Redis
    [Google Maps]
}
[MobileFrontend]

' Relations
Developer -up-> [GitHub Repository]: Pushes code
User --> cdn

[GitHub Repository] .up.> gha : Triggered by push
gha -up-> iac : Runs Terraform
iac -up-> gcpapis: Calls provisioning APIs
gcpapis --> GCP: Creates resources

cdn <--> lb1 : Requests and caching
lb1 --> WebFrontend
WebFrontend --> Backend
WebFrontend -right-> [Google Maps]

Backend --> mongo
Backend -right-> Redis : Caching and state
@enduml
```

Tools that we should implement:

- Cloud Secret Manager (+++)
- Cloud DNS (++)

Tools that might be relevant:

- Cloud Armor
- Cloud Identity (Cloud IAM)
- Cloud Operations Suite

Relevant for the report:

- Google Cloud Compute Engine
- Cloud functions
- Cloud Vision API
- Cloud Natural Language API
- Cloud ML
- Baremetal or on prem is not supported by our approach.
- Google Cloud Premium Network Tier (VPC) vs Google Cloud Standard Network Tier
  - Public Internet vs Cloud Interconnect
