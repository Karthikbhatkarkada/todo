#!/bin/bash
set -e

# Clone and build the ToDo MVC nodejs example
rm -rf todomvc
git clone https://github.com/tastejs/todomvc.git

# Navigate into the Node.js example
cd todomvc/examples/nodejs-express

# Install dependencies
npm install

# Return to workspace and package the whole repository so Packer can copy it into the image
cd ../../..
mkdir -p build
tar czf build/todoapp.tar.gz todomvc

echo "✅ To-Do app build complete: build/todoapp.tar.gz"
