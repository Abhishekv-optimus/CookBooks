#! /bin/bash

function errorExit ()
{
    while [[ -n "${1:-}" ]];
    do
        echo -e "${1:-}"
        shift 1
    done
    exit -1
}

echo "Configuring the system..."

# @Parameters
declare HOST_PREFIX=""
declare HOST_NAME=""
declare TIME_ZONE="Canada/Pacific"

# Read the parameter values supplied via the command line
while getopts p:n:z: option
do
        case "${option}"
        in
                p) HOST_PREFIX=${OPTARG};;
                n) HOST_NAME=${OPTARG};;
                z) TIME_ZONE=${OPTARG};;
        esac
done

# Validate the parameters
if [[ -z "${HOST_PREFIX:-}" ]];
then
    echo "WARNING: HOST_PREFIX is not set ... using 'ip' by default"
    HOST_PREFIX="ip"
fi

declare -r HOST_IP="$(hostname -I)"
if [[ -z "${HOST_NAME:-}" ]];
then
    echo "WARNING: HOST_NAME is not set ... using '${HOST_PREFIX}-${HOST_IP//./-}' by default"
    HOST_NAME="${HOST_PREFIX}-${HOST_IP//./-}"
fi

if [[ -z "${TIME_ZONE:-}" ]];
then
    echo "WARNING: TIME_ZONE is not set ... using 'Canada/Pacific' by default"
    TIME_ZONE="${TIME_ZONE:-Canada/Pacific}"
fi

if [[ ! -f "/usr/share/zoneinfo/${TIME_ZONE}" ]];
then
    errorExit "FATAL: Invalid timezone: ${TIME_ZONE}" \
              "USAGE: $(basename "${0}") [-p <host-prefix>=ip] [-n <host-name>=<host-prefix>-<ip-address>] [-z <time-zone>=Canada/Pacific]"
fi


echo "Configuring the hostname..."

/bin/hostname "${HOST_NAME}"
/bin/sed -E "s/^(HOSTNAME)=(.*)$/\1=${HOST_NAME}/" -i /etc/sysconfig/network
cat << EOF | /usr/bin/tee -a /etc/hosts > /dev/null
${HOST_IP}    ${HOST_NAME}
EOF

echo "Hostname set to $(hostname -s)."



echo "Configuring the timezone..."

/bin/rm /etc/localtime
/bin/ln -sf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime

echo "Timezone set to ${TIME_ZONE}."


echo "Done. The system is configured."

