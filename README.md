# DevOps Project

This project demonstrates the integration of various DevOps tools to create a comprehensive CI/CD pipeline. The tools used include Prometheus, Grafana, Terraform, Jenkins, SonarQube, Artifactory, Ansible, Docker, Kubernetes, and Helm. Additionally, a sample Java and Maven project is included.

## Architecture

1. **Terraform**: Used for infrastructure as code to provision the necessary cloud infrastructure.
2. **Jenkins**: Automates the CI/CD pipeline.
3. **SonarQube**: Performs static code analysis to ensure code quality.
4. **Artifactory**: Manages binary repositories.
5. **Ansible**: Manages configuration and deployment tasks.
6. **Docker**: Containerizes applications.
7. **Kubernetes**: Orchestrates the deployment, scaling, and management of containerized applications.
8. **Helm**: Manages Kubernetes applications using Helm charts.
9. **Prometheus**: Monitors and collects metrics from the application.
10. **Grafana**: Visualizes metrics from Prometheus.

## CI/CD Pipeline Flow

1. **Code Development**: Sample Java and Maven project, committing code changes to a version control system

2. **Infrastructure Provisioning with Terraform**:

   - Terraform scripts define the cloud infrastructure (AWS) required for deployment.
3. **Deployment and Configuration with Ansible**:

   - Ansible scripts manage the configuration of servers and deployment of applications (Jenkins master and build slave)
   - Environment-specific configurations are applied.
4. **Continuous Integration (CI) with Jenkins**:

   - Jenkins monitors the version control system for changes.
   - Maven is used to compile the Java code, run tests, and generate artifacts.
5. **Static Code Analysis with SonarQube**:

   - Jenkins integrates with SonarQube to perform static code analysis.
   - SonarQube scans the code for bugs, vulnerabilities, and code smells.
   - Reports are generated to provide insights into code quality.
6. **Artifact Management with Artifactory**:

   - After successful builds, artifacts (Docker images) are stored in Artifactory.
7. **Containerization and Orchestration with Docker and Kubernetes**:

   - Docker is used to containerize the Java application into Docker images.
   - Kubernetes deploys these Docker containers into pods.
8. **Continuous Delivery (CD) with Kubernetes and Helm**:

   - Kubernetes orchestrates the deployment, scaling, and management of containerized applications.
   - Helm manages Kubernetes applications via Helm charts, enabling easy updates and rollbacks.
9. **Monitoring and Feedback**:

   - Prometheus and Grafana monitor the deployed applications and infrastructure.

## Setting up Prometheus and Grafana on Kubernetes

### Prerequisites

1. Kubernetes
2. Helm

### Setup Prometheus

1. Create a dedicated namespace for Prometheus

   ```sh
   kubectl create namespace monitoring
   ```
2. Add Prometheus Helm chart repository

   ```sh
   helm repo add prometheus-community https://prometheus-community.github.io/helm-charts 
   ```
3. Update the Helm chart repositories

   ```sh
   helm repo update
   helm repo list
   ```
4. Install Prometheus using Helm

   ```sh
    helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring
   ```
5. Change Prometheus service type to LoadBalancer (optional for external access):

   ```sh
   kubectl edit svc prometheus-kube-prometheus-prometheus -n monitoring
   ```
6. Loginto Prometheus dashboard to monitor application
   `https://ELB:9090`
7. Check for node_load15 executor to check cluster monitoring
8. Change Grafana service type to LoadBalancer (optional for external access):

   ```sh
   kubectl edit svc prometheus-grafana -n monitoring
   ```
9. Access Grafana dashboard to visualize metrics  `Use the external IP provided by LoadBalancer`
10. Monitoring Metrics

    * Node Load (15-minute average): Monitor cluster-wide load.
    * Node Exporter/USE Method/Node and Cluster: Utilization, Saturation, Errors (USE) metrics for nodes and clusters.
