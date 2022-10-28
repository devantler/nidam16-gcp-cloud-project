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
agent "GitHub Action"
agent "Terraform Job"

interface "GCP APIs"
cloud GCP {
    interface "Cloud CDN"
    interface "Load Balancer"
    package "Cloud Run" {
        [WebFrontend]
        [Backend]
    }
    [MongoDB Atlas]
    [Redis]
    [Google Maps]
}
[MobileFrontend]

' Relations
Developer -up-> [GitHub Repository]: Pushes code
User --> "Cloud CDN"
User --> MobileFrontend

[GitHub Repository] <.up. "GitHub Action" : Triggered by push
"GitHub Action" -up-> "Terraform Job" : Triggers Terraform
"Terraform Job" -up-> "GCP APIs": Calls provisioning APIs
"GCP APIs" --> GCP: Creates resources

"Cloud CDN" <--> "Load Balancer" : Requests and caching
"Load Balancer" --> WebFrontend
"Load Balancer" --> Backend
WebFrontend --> Backend
MobileFrontend ---> Backend
WebFrontend -right-> [Google Maps]
MobileFrontend ---> [Google Maps]

Backend --> "MongoDB Atlas"
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
