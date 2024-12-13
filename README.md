# Kubernetes Cluster Management Tool

A Swift-based command-line tool for monitoring and managing Kubernetes cluster resources. This tool helps analyze container status, manage resource allocation, and handle container lifecycle operations.

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
│ └── string.swift
├── main.swift
├── kube_status.txt
├── compile_and_run.sh
└── README.md
```

## Installation

1. Clone the repository:

```bash
git clone <repository-url>
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

Alternatively, compile and run manually:

```bash
swiftc -parse-as-library .swift ./Protocol/.swift ./Struct/.swift ./Tools/.swift -o kub_parser
./kub_parser

```

## Input File Format

The `kube_status.txt` file should follow this format

```
Node: <node_id>
Ressources: CPU: <cpu_count> | RAM: <ram_size>
Pod: <pod_id>
Container: <container_name> | Status: <status> | CPU: <cpu_usage> | RAM: <ram_usage>

```

## Features

1. **Container Status Monitoring**

   - View status of all containers
   - Identify crashed, running, and stopped containers

2. **Resource Management**

   - Track CPU and RAM usage per node
   - Calculate available resources
   - Monitor resource allocation per service

3. **Container Operations**
   - Automatic restart of crashed containers
   - Resource requirement verification before restart
   - Service-specific resource allocation

## Contributing

1. Fork the repository
2. Create a feature branch:

```bash
git checkout -b feature/your-feature-name
```

3. Follow the coding style:

   - Use protocol-oriented programming
   - Maintain clear separation of concerns
   - Add comments for complex logic
   - Follow Swift style guidelines

4. Test your changes:

   - Ensure all existing functionality works
   - Add new test cases if needed
   - Verify resource calculations

5. Submit a pull request:
   - Provide clear description of changes
   - Reference any related issues
   - Update documentation if needed

## Development Guidelines

- Follow protocol-oriented design patterns
- Maintain immutability where possible
- Use clear naming conventions
- Add documentation for public interfaces
- Handle errors appropriately
- Keep functions focused and small

## License

Copyright (c) 2011-2024 GitHub Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Support

For support, please open an issue in the repository or contact the maintainers.
