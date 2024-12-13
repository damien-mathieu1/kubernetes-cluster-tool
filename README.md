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

## Interactive Menu Features

The tool provides an interactive command-line interface with the following menus:

### 1. Container Status Management

- View all container statuses
- View cluster summary
- Count containers by type

### 2. Resource Management

- View pod resources
- Check available resources for a node
- Calculate service resources

### 3. Container Operations

- Restart all crashed containers
- Restart specific container
- View service requirements

## Input File Format

The `kube_status.txt` file should follow this format:

```
Node: <node_id>
Ressources: CPU: <cpu_count> | RAM: <ram_size>
Pod: <pod_id>
Container: <container_name> | Status: <status> | CPU: <cpu_usage> | RAM: <ram_usage>
```

## Service Requirements

The tool comes pre-configured with resource requirements for various services:

- postgres_db: 2 CPU, 8 RAM
- kafka_broker: 4 CPU, 16 RAM
- redis_cache: 1 CPU, 2 RAM
- nginx_webserver: 2 CPU, 8 RAM
- And many more...

## License

MIT License

Copyright (c) 2024 Damien MATHIEU

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## Support

For support, please open an issue in the repository or contact the maintainers.
