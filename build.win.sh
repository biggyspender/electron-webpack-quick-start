#!/usr/bin/env bash
CURRENT_ID=`whoami`:`id -g -n`
sudo ./clean.sh 
docker build -t electronbuilder:wine .
docker run \
	--rm \
	-ti \
	--env-file <(env | grep -iE 'DEBUG|NODE_|ELECTRON_|YARN_|NPM_|CI|CIRCLE|TRAVIS_TAG|TRAVIS|TRAVIS_REPO_|TRAVIS_BUILD_|TRAVIS_BRANCH|TRAVIS_PULL_REQUEST_|APPVEYOR_|CSC_|GH_|GITHUB_|BT_|AWS_|STRIP|BUILD_') \
	--env ELECTRON_CACHE="/root/.cache/electron" \
	--env ELECTRON_BUILDER_CACHE="/root/.cache/electron-builder" \
	-v ${PWD}:/project \
	-v ${PWD##*/}-node-modules:/project/node_modules \
	-v ~/.cache/electron:/root/.cache/electron \
	-v ~/.cache/electron-builder:/root/.cache/electron-builder \
	electronbuilder:wine \
	bash -c './run-build.sh'
sudo chown -R $CURRENT_ID dist