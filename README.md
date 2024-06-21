# Inception-of-Things
K3d and K3s with Vagrant

## p1 - K3s and Vagrant

This README provides guidance on setting up a Kubernetes (K3s) cluster using Vagrant with two virtual machines: one as the server (controller) and the other as a worker node. Both machines are configured with specific IP addresses and are set up to allow passwordless SSH access.

### Overview

Two machines will be set up using Vagrant and K3s will be installed on both:
- **Server**: Runs K3s in controller mode.
- **ServerWorker**: Runs K3s in agent mode.

### Specifications

- **Machine Names**: The names of the machines must be the login of a team member.
  - The first machine (Server) will have a hostname ending in 'S'.
  - The second machine (ServerWorker) will have a hostname ending in 'SW'.
- **IP Addresses**: Each machine will have a dedicated IP on the eth1 interface.
  - Server: `192.168.56.110`
  - ServerWorker: `192.168.56.111`
- **SSH Access**: Both machines must be accessible via SSH without a password.

### Prerequisites

- **Vagrant**: Used to create and manage the virtual machines.
- **VirtualBox**: Hypervisor to run the virtual machines.

### Setup

1. **Vagrantfile**: Create a Vagrantfile to define and configure both machines.
2. **Starting the Machines**: Use Vagrant to start and provision both machines.
```bash
vagrant up
```
3. **Accessing the Machines**: Connect to the machines using SSH.
```bash
vagrant ssh <hostname>
```

## p2 - K3s and three simple applications

This README guides you through setting up a Kubernetes (K3s) deployment that hosts three different web applications. Access to these applications is controlled by the `HOST` header in HTTP requests, allowing you to access each app by visiting a specific domain name pointed at the IP `192.168.56.110`.

This command should displays you the info from `app-one`.
```bash
curl -H "Host:app1.com" 192.168.56.110
```

### Overview

We will set up three web applications, referred to as `app1`, `app2`, and `app3`. The access to these applications will be managed by an Ingress controller, which routes traffic to the appropriate application based on the `HOST` header:

- **app1.com:** Routes to `app1`
- **app2.com:** Routes to `app2`
- **Default:** Any other `HOST` value will route to `app3`

![p2](img/p2.png)

### Prerequisites

- VirtualBox, used to create the VM and the deployment over it.
- The Kubernetes cluster is hosted over a VM, specified in this [Vagrantfile](Vagrantfile).
- A Kubernetes cluster (K3s) set up and accessible.

### 1: Deployments

We'll create three [deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/), one for each web application.

### 2: Services

For each deployment, create a corresponding [service](https://kubernetes.io/docs/concepts/services-networking/service/). This will allow the Ingress controller to route traffic to the correct pods.

### 3: Ingress

Finally, configure an [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/#hostname-wildcards) to route traffic based on the HOST header.

### Usage

Deploy:

```bash
vagrant up
```

If case you want to access the VM:

```bash
vagrant ssh rcabezas
```

Inside the VM this will be the result:

```bash
k get all
```

![p2_k3s](img/p2_k3s.png)

### Resources

- [Ingressing with k3s](https://carpie.net/articles/ingressing-with-k3s)
- [Ingress Controller on k3s](https://www.suse.com/c/rancher_blog/deploy-an-ingress-controller-on-k3s/)

### p3 - K3d and Argo CD
