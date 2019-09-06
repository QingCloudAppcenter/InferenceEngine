#!/usr/bin/env bash
set -e
git clone https://github.com/tensorflow/serving.git
export TF_SERVING_ROOT=$(pwd)/serving
echo "export TF_SERVING_ROOT=$(pwd)/serving" >> ~/.bashrc
docker build \
     -f Dockerfile.devel-mkl \
     --build-arg TF_SERVING_BAZEL_OPTIONS="--incompatible_disallow_data_transition=false --incompatible_disallow_filetype=false" \
     --build-arg TF_SERVING_VERSION_GIT_BRANCH="1.14.0" \
     -t tensorflow/serving:latest-devel-mkl .
cd $TF_SERVING_ROOT/tensorflow_serving/tools/docker/
docker build \
     -f Dockerfile.mkl \
     --build-arg TF_SERVING_VERSION_GIT_BRANCH="1.14.0" \
     -t qingcloud/tensorflow-serving:1.14-mkl .