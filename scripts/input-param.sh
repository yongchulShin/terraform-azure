#!/bin/bash

PS3="환경을 선택하세요: "
options=("003dev" "008dev" "dev" "prod" "종료")

select env in "${options[@]}"
do
    if [[ "$env" == "종료" ]]; then
        echo "프로그램을 종료합니다."
        exit 0
    fi
    
    echo "선택한 환경: $env"
    export env
    break
done
