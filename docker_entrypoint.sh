#!/bin/bash

fakeTimeService=$(sed 's/\\/ /g' <<< ${fakeTimeEnv})
echo "docker entrypoint:  ${fakeTimeService}"