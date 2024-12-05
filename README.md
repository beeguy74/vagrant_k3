# vagrant_k3

## Project Description
vagrant_k3 is a project that sets up a Kubernetes cluster using Vagrant and VirtualBox. It automates the creation and configuration of virtual machines to form a multi-node Kubernetes cluster for development and testing purposes.

## Prerequisites
- Vagrant (>= 2.2.10)
- VirtualBox (>= 6.1)
- Git

## Setup Instructions
1. Clone the repository

### Setup for p1
1. Navigate to the `p1` directory:
    ```sh
    cd p1
    ```
2. Start the Vagrant environment:
    ```sh
    vagrant up
    ```
3. Follow any additional instructions provided in the `p1/scripts/virtual_install.sh` script.

### Setup for p2
1. Navigate to the `p2` directory:
    ```sh
    cd p2
    ```
2. Start the Vagrant environment:
    ```sh
    vagrant up
    ```
3. Follow any additional instructions provided in the `p2/scripts/patch_hosts.sh` script.

### Setup for p3
1. Navigate to the `p3` directory:
    ```sh
    cd p3
    ```
2. Run the install script to set up dependencies:
    ```sh
    ./scripts/install.sh
    ```
3. Start the cluster:
    ```sh
    ./scripts/start.sh
    ```