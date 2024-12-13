# Kubernetes Cluster Management Tool

A Swift-based command-line tool for monitoring and managing Kubernetes cluster resources. This tool helps analyze container status, manage resource allocation, and handle container lifecycle operations through an interactive interface.

## Architecture

The project follows a protocol-oriented architecture with clear separation of concerns:

### Core Protocols

- `ClusterProtocol`: Defines the cluster structure containing nodes
- `NodeProtocol`: Defines node properties (CPU, RAM, pods)
- `PodProtocol`: Defines pod structure containing containers
- `ContainerProtocol`: Defines container properties and status

### Data Structures

- `Cluster`: Implementation of cluster management
- `Node`: Represents a cluster node with its resources
- `Pod`: Groups related containers
- `Container`: Represents individual containers with their status and resource usage

### Utilities

- `Tools/parser.swift`: Handles parsing of cluster status file
- `Tools/analysis.swift`: Contains analysis and reporting functions
- `Tools/kubTool.swift`: Implements container management operations
- `Tools/string.swift`: String manipulation utilities
- `Tools/InteractiveMenu.swift`: Interactive command-line interface

### Configuration

- `Config/service_requirements.json`: Defines CPU and RAM requirements for different service types

## Prerequisites

- Swift 5.0 or later
- macOS or Linux operating system
- Text editor or IDE (Xcode recommended for macOS)

## Project Structure

```
├── Protocol/
│ ├── ClusterProtocol.swift
│ ├── NodeProtocol.swift
│ ├── PodProtocol.swift
│ └── ContainerProtocol.swift
├── Struct/
│ ├── ClusterStruct.swift
│ ├── NodeStruct.swift
│ ├── PodStruct.swift
│ └── ContainerStruct.swift
├── Tools/
│ ├── parser.swift
│ ├── analysis.swift
│ ├── kubTool.swift
│ ├── string.swift
│ └── InteractiveMenu.swift
├── Config/
│ └── service_requirements.json
├── main.swift
├── kube_status.txt
├── compile_and_run.sh
└── README.md
```

## Installation

1. Clone the repository:

```bash
git clone https://github.com/damien-mathieu1/kubernetes-cluster-tool.git
cd kubernetes-cluster-tool
```

2. Ensure Swift is installed:

```bash
swift --version
```

## Running the Application

1. Make the compile script executable:

```bash
chmod +x compile_and_run.sh
```

2. Run the application:

```bash
./compile_and_run.sh
```

3. When prompted, enter the path to your cluster status file or press Enter to use the default path (`./kube_status.txt`).

## Interactive Features

### File Loading

- Interactive cluster status file selection
- Default path support
- Error handling with retry option

### Main Menu Options

1. Container Status Management

   - View all container statuses
   - View cluster summary
   - Count containers by type

2. Resource Management

   - View pod resources
   - Check available resources for a node
   - Calculate service resources

3. Container Operations
   - Restart all crashed containers
   - Restart specific container
   - View service requirements

## Input Files

### Cluster Status File Format (kube_status.txt)

The file should follow this format:

```
Node: <node_id>
Ressources: CPU: <cpu_count> | RAM: <ram_size>
Pod: <pod_id>
Container: <container_name> | Status: <status> | CPU: <cpu_usage> | RAM: <ram_usage>
```

### Service Requirements Configuration (service_requirements.json)

JSON file defining resource requirements for various services:

```json
{
    "service_name": {
        "cpu": <cpu_count>,
        "ram": <ram_size>
    }
}
```

## License

MIT License - See LICENSE file for details.

## Support

For support, please open an issue in the repository or contact the maintainers.
