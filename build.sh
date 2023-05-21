#!/bin/bash
mkdir -p "$(pwd)/build"
VERSION=$(cat VERSION)
GIT_VERSION=$(git describe --always --dirty)
echo "Building version $VERSION-$GIT_VERSION"
sleep 2
rm -rf build/*

# Only build if running outside GitHub Actions, otherwise it's built in the workflow
if [ "$GITHUB_ACTIONS" != "true" ]; then
    docker build -f "$(pwd)/build-tools/Dockerfile" -t brokenfly-build .
fi


for file in $(pwd)/boards/*.h; do
  BOARD="$(basename "$file" .h)"
  docker run --rm  -v "$(pwd)/build:/build-artifacts" brokenfly-build $BOARD $VERSION $GIT_VERSION
done
