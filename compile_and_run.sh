#!/bin/bash
mkdir -p Config
swiftc -parse-as-library *.swift ./Protocol/*.swift ./Struct/*.swift ./Tools/*.swift -o kub_parser && ./kub_parser