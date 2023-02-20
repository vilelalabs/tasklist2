#!/bin/bash

yarn build
yarn generate
yarn cap copy
yarn cap add android
yarn cap open android
yarn cap sync android