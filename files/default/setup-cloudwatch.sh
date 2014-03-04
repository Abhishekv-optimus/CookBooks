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

echo "Configuring the CloudWatch monitor..."

# @Parameters
declare FORCE_SETUP="false"

# Read the parameter values supplied via the command line
while getopts f: option
do
        case "${option}"
        in
                f) FORCE_SETUP=${OPTARG};;
        esac
done

# Validate the parameters
if [[ ! "${FORCE_SETUP:-}" =~ ^(true|false)$ ]];
then
    errorExit "FATAL: Invalid value supplied for the force option: '${FORCE_SETUP}' - 'true' or 'false' expected." \
              "USAGE: $(basename "${0}") [-f (true|false)]"
fi

# Ensure the setup script is previously downloaded to a known location via Elastic Beanstalk
# or CloudFormation -- download it if the force option is used
declare -r CW_DIR="/opt/cloudwatch"
declare -r MON_SCRIPT="${CW_DIR}/aws-scripts-mon/mon-put-instance-data.pl"
declare -r CW_URL="http://ec2-downloads.s3.amazonaws.com/cloudwatch-samples/CloudWatchMonitoringScripts-v1.1.0.zip"
if [[ ! -e "${MON_SCRIPT}" ]];
then
    if ${FORCE_SETUP};
    then
        mkdir -p "${CW_DIR}"
        pushd "${CW_DIR}" > /dev/null
        wget "${CW_URL}" -O "cwmon.zip"
        unzip "cwmon.zip"
        rm "cwmon.zip"
        popd > /dev/null
    else
        errorExit "FATAL: ${MON_SCRIPT} can't be found." \
                  "If you're running this script manually outside CloudFormation or Elastic Beanstalk" \
                  "you can force downloading the script by using the -f command line option."
    fi
fi

declare -r MON_METRICS="--mem-util --mem-used --mem-avail --swap-util --swap-used --disk-path=/ --disk-space-util --disk-space-used --disk-space-avail"

# Configure the cron job
cat << EOF | tee /etc/cron.d/cwpump > /dev/null
* * * * * root perl ${MON_SCRIPT} ${MON_METRICS} --from-cron
* * * * * root perl ${MON_SCRIPT} ${MON_METRICS} --auto-scaling=only --from-cron
EOF

echo "CloudWatch monitor set."

