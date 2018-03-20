#!/bin/bash

configFile=${1}

run_docker_container() {
    echo "Comment is  ${1} args is ${2}"

    local dockerEnv
    [[ -n ${2} ]] && dockerEnv="faketime -f '${2}'"

    #echo "run docker with env ${dockerEnv}"
    export fakeTimeEnv=${dockerEnv}
    ./docker_entrypoint.sh

}

run_tests() {
    local comment
    local args

    while IFS='' read -r line || [[ -n "$line" ]]; do
        if [[ ${line} == \#* ]]
        then
            comment=${line}
        else
            args=${line}
        fi

        [[ -n ${args} ]] && run_docker_container ${comment} ${args}; args=''
    done < "$1"

    run_docker_container
}

run_tests ${configFile}

