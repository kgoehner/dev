#!/bin/bash
set -e

command="$1"
resource="$2"
value="$3"

window_size=60%

valid_commands="[ get, describe, logs, connect, delete, port-forward, stop-port-forward, scale ]"

if [[ -z $command ]]; then
    echo "Command is required: $valid_commands"
    exit 1
fi

# AWS Profile for EKS
export AWS_PROFILE=scientist
#export AWS_PROFILE=mm_scientist

set_resource () {
    # Search for a k8s resource by name
    if [[ -z $resource ]]; then
        if [[ -z $1 ]]; then
            resource=$(kubectl api-resources --no-headers | tr -s " " | cut -d " " -f 1,2 | fzf --tmux $window_size  --border-label "Select Resource" | cut -d " " -f 1)
        else
            resource=$(kubectl api-resources --no-headers | tr -s " " | cut -d " " -f 1,2 | fzf --tmux $window_size -q $1 --border-label "Select Resource" | cut -d " " -f 1)
        fi
    fi
    if [[ -z $resource ]]; then
        echo "No resource selected, exiting..."
        exit 1
    fi
}

set_value () {
    # Search for a resource instance
    if [[ -z $value ]]; then
        value=$(kubectl get $resource | fzf --tmux 60% -q $2 --border-label "$1 $resource" | cut -d " " -f1)
    fi
}

set_values () {
    # Search for a list of resource instances
    if [[ -z $values ]]; then
        values=$(kubectl get $resource | fzf -m --tmux 60% -q $2 --border-label "$1 $resource" | cut -d " " -f1)
    fi
}

confirm() {
    # Confirm a command for things that might be dangerous to automatically execute
    echo -n "Do you want to run '$*'? [N/y] "
    read -n 1 reply
    echo
    if test "$reply" = "y" -o "$reply" = "Y"; then
        "$@"
    else
        echo "Skipped..."
    fi
}

case "$command" in
    "get" | "g")
        set_resource
        kubectl get $resource ;;
    "describe" | "desc")
        set_resource "pods"
        set_value "Describe" $USER
        kubectl describe $resource $value ;;
    "logs")
        resource="pod"
        set_value "Tail" $USER
        kubectl logs -f $value ;;
    "connect" | "c")
        resource="pod"
        set_value "Connect" $USER
        kubectl exec -it $value -- /bin/bash ;;
    "delete" | "del")
        set_resource "pods"
        set_values "Delete" $USER
        for val in $values; do
            confirm kubectl delete --wait=false $resource $val
        done ;;
    "scale")
        resource="deployments"
        set_values "Scale" $USER
        echo -n "What do you want to scale to? "
        read reply
        echo -n "--replics=$reply $resource/$value"
        kubectl scale --replicas=$reply $resource/$value ;;
    "port-forward" | "pf")
        resource="pods"
        set_values "Port-Forward" $USER
        local_port=4201
        remote_port=8001
        for pod in $values; do
            kubectl-port-forward.sh $pod ${local_port}:${remote_port} &
            echo "${local_port}:${remote_port}"
            ((local_port+=1))
        done ;;
    "stop-port-forward" | "spf")
        # Stop all kubectl processes.
        # NOTE: This will also stop this bash script. Oh well.
        pkill -f kubectl ;;
    *)
        echo "Unknown command: $command - expected one of: $valid_commands"
        exit 1 ;;
esac

