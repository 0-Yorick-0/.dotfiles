#!/usr/bin/env bash

awswrap() {
    m6_cloud_tools_updater
    saml2aws login --skip-prompt >&2
    \aws "$@"
}
alias aws=awswrap

terraformwrap() {
    m6_cloud_tools_updater
    saml2aws login --skip-prompt >&2
    _tf-autoswitch
    \terraform "$@"
}
alias terraform=terraformwrap

kubectlwrap() {
    m6_cloud_tools_updater
    saml2aws login --skip-prompt >&2
    \kubectl "$@"
}
alias kubectl=kubectlwrap

helmwrap() {
    saml2aws login --skip-prompt >&2
    \helm "$@"
}
alias helm=helmwrap

helmfilewrap() {
    saml2aws login --skip-prompt >&2
#    helm_default_login
    \helmfile "$@"
}
alias helmfile=helmfilewrap

kopswrap() {
    saml2aws login --skip-prompt >&2
    \kops "$@"
}
alias kops=kopswrap

awsiamauthenticatorwrap() {
    saml2aws login --skip-prompt >&2
    \aws-iam-authenticator "$@"
}
alias aws-iam-authenticator=awsiamauthenticatorwrap

sopswrap() {
  saml2aws login --skip-prompt >&2
  saml2aws exec --exec-profile=6cloud-services -- sops --config "$HOME/.sops.yaml" "$@"
}
alias sops=sopswrap

_tf-check-project-renamed() {

ORIGIN=$(git remote get-url origin)

## Here the list of renamed projects
RENAMED_PROJECT=$(cat <<-EOF
{
  "previous-git-remote-url": "new-git-remote-url",
  "git@github.m6web.fr:m6web/site-6play-v4.git": "git@github.m6web.fr:m6web/app-bedrock-web.git",
  "git@github.m6web.fr:m6web/app-6play-hbbtv.git": "git@github.m6web.fr:m6web/app-bedrock-tvjs.git"
}
EOF
)
NEW_ORIGIN=$(jq --arg origin "$ORIGIN" '.[$origin]' <<< "$RENAMED_PROJECT")
if [[ ${NEW_ORIGIN} = "null" ]]; then
  return 0
else
  echo "\e[0;31mYour current repo was renamed. Please run the following command : 'git remote set-url origin ${NEW_ORIGIN}'\e[0m"
  return 1
fi
}

# Terraform easy init command alias
tf-init() {
    _tf-autoswitch
    _tf-check-project-renamed
    if [[ $?  = 0 ]]; then #check if the user use an old project remote
      local TERRAFORM_VERSION
      TERRAFORM_VERSION="$(\terraform -v | head -n1 | cut -dv -f2)"
      local RE='[^0-9]*([0-9]*)[.]([0-9]*)([.]([0-9]*)([0-9A-Za-z-]*))?'
      local TERRAFORM_MAJOR_VERSION
      TERRAFORM_MAJOR_VERSION=$(echo "$TERRAFORM_VERSION" | sed -Ee "s#$RE#\1#")
      local TERRAFORM_MINOR_VERSION
      TERRAFORM_MINOR_VERSION=$(echo "$TERRAFORM_VERSION" | sed -Ee "s#$RE#\2#")
      local TERRAFORM_PATCH_VERSION
      TERRAFORM_PATCH_VERSION=$(echo "$TERRAFORM_VERSION" | sed -Ee "s#$RE#\4#")
      local TERRAFORM_SPECIAL_VERSION
      TERRAFORM_SPECIAL_VERSION=$(echo "$TERRAFORM_VERSION" | sed -Ee "s#$RE#\5#")

      if [[ $TERRAFORM_MAJOR_VERSION -lt 1 && $TERRAFORM_MINOR_VERSION -lt 13 ]]; then
        terraform init -backend-config=key="$(tf-backend-config-key)" -get -get-plugins -reconfigure "$@"
      else
        terraform init -backend-config=key="$(tf-backend-config-key)" -get -reconfigure "$@"
      fi
      (mkdir -p "$HOME/.terraform.d/plugins"
      for provider in $(find .terraform/plugins -maxdepth 2 -name terraform-provider-\*); do
          mv "$provider" "$HOME/.terraform.d/plugins/$(basename "${provider%%_x*}")"
      done) >/dev/null 2>&1 || true
    fi
}

# Terraform easy workspace select
tf-ws() {
    if [[ "$#" -eq 1 ]]; then
        if [[ $1 = "default" ]] || [[ -f vars/${1}.tfvars ]]; then
            terraform workspace select "$1" || terraform workspace new "$1"
        else
            echo "vars/${1}.tfvars does not exists. Would you create a new workspace ${1} ? (yes/no)"
            if [[ -n "$ZSH_VERSION" ]]; then
                read -q -r
            else
                read -n 1 -r
            fi
            echo
            [[ ! "$REPLY" =~ ^[Yy]$ ]] && return

            touch "vars/${1}.tfvars"
            terraform workspace new "$1"
        fi
    else
        terraform workspace list
    fi
}

# Terraform plan with vars files in vars folder exists
tf-plan() {
    if [[ -d ".terraform" && -f ".terraform/terraform.tfstate" ]]; then
        KEY="$(jq -r '.backend.config.key' <.terraform/terraform.tfstate)"
        if [[ "$KEY" != "$(tf-backend-config-key)" ]]; then
            echo "\e[0;31mThe local state is referencing an unexpected remote, delete .terraform/ and re-init\e[0m" && return
        fi
    else
        echo "\e[0;31mWorkspace is not initialized, run tf-init\e[0m" && return
    fi
    if [[ -d "vars" ]]; then
        if ! [[ $(\terraform workspace show) == "default" ]]; then
            terraform plan -var-file="vars/$(\terraform workspace show).tfvars" "$@"
        else
            echo "\e[0;31mNo operations must be executed in 'default' workspace for multi-env project\e[0m"
        fi
    else
        terraform plan "$@"
    fi
}

# Called by tf-plan-all & tf-apply-all
tf-exec-all() {
    local ACTION
    ACTION=$1
    shift

    FIND_CMD="find -L vars -mindepth 1 -maxdepth 1 -type f -exec basename {} \; | sed -e 's/\.tfvars$//'"
    if [ -n "$1" ] && [ "-" != "${1:0:1}" ]
    then
        FIND_CMD="find -L vars -mindepth 1 -maxdepth 1 -name \"*$1*.tfvars\" -type f -exec basename {} \; | sed -e 's/\.tfvars$//'"
        shift
    fi

    if [ "tf-plan" = "${ACTION}" ]
    then
        rm -rf .terraform/plans
        mkdir -p .terraform/plans
    fi

    saml2aws login --skip-prompt >&2
    _tf-autoswitch
    eval "$FIND_CMD" | while IFS= read -r WORKSPACE
    do
        echo " > ${ACTION}-all: WORKSPACE=${WORKSPACE}" >&2
        if [ "tf-plan" = "${ACTION}" ]
        then
            echo " > ${ACTION}-all: ${ACTION} -out=.terraform/plans/${WORKSPACE}.tfplan $*" >&2
            TF_WORKSPACE="${WORKSPACE}" ${ACTION} "-out=.terraform/plans/${WORKSPACE}.tfplan" "$@"
        elif [ "tf-apply" = "${ACTION}" ]
        then
            echo " > ${ACTION}-all: terraform apply $* .terraform/plans/${WORKSPACE}.tfplan" >&2
            TF_WORKSPACE="${WORKSPACE}" \terraform apply "$@" ".terraform/plans/${WORKSPACE}.tfplan"
            rm ".terraform/plans/${WORKSPACE}.tfplan"
        else
            echo " > ${ACTION}-all: terraform ${ACTION} $*" >&2
            TF_WORKSPACE="${WORKSPACE}" \terraform "${ACTION}" "$*"
        fi
    done
}

# Terraform plan for each workspace
# usage : tf-plan-all [workspace-filter] [terraform-args...]
#         workspace-filter may be an environment, tenant, or any string you can find in a filename in `vars/`
#         terraform_args are any terraform argument preceded by a "-" like "-target"
# examples :
# tf-plan-all
# tf-plan-all staging
# tf-plan-all rtlmutu
# tf-plan-all -target module.s3
# tf-plan-all staging -target module.s3
tf-plan-all() {
    tf-exec-all "tf-plan" "$@"
}

# Terraform apply with vars files in vars folder exists
tf-apply() {
    if [[ -d ".terraform" && -f ".terraform/terraform.tfstate" ]]; then
        [[ -f .terraform/environment ]] && WORKSPACE_PATH="$(cat .terraform/environment)/" || WORKSPACE_PATH=""
        STATE_FILE="$(cat .terraform/terraform.tfstate)"
        KEY="$(jq -r '.backend.config.key' <<<"$STATE_FILE")"

        if [[ "$KEY" != "$(tf-backend-config-key)" ]]; then
            echo "\e[0;31mThe local state is referencing an unexpected remote, delete .terraform/ and re-init\e[0m" && return
        fi

        BUCKET="$(jq -r '.backend.config.bucket' <<<"$STATE_FILE")"
        PROFILE="$(jq -r '.backend.config.profile' <<<"$STATE_FILE")"
        TERRAFORM_VERSION="$(\terraform -v | head -n1 | cut -dv -f2)"
        TERRAFORM_VERSION_INT="$(echo "$TERRAFORM_VERSION" | cut -c3-4)"
        local RE='[^0-9]*([0-9]*)[.]([0-9]*)([.]([0-9]*)([0-9A-Za-z-]*))?'
        local TERRAFORM_MAJOR_VERSION
        TERRAFORM_MAJOR_VERSION=$(echo "$TERRAFORM_VERSION" | sed -Ee "s#$RE#\1#")
        local TERRAFORM_MINOR_VERSION
        TERRAFORM_MINOR_VERSION=$(echo "$TERRAFORM_VERSION" | sed -Ee "s#$RE#\2#")
        local TERRAFORM_PATCH_VERSION
        TERRAFORM_PATCH_VERSION=$(echo "$TERRAFORM_VERSION" | sed -Ee "s#$RE#\4#")
        local TERRAFORM_SPECIAL_VERSION
        TERRAFORM_SPECIAL_VERSION=$(echo "$TERRAFORM_VERSION" | sed -Ee "s#$RE#\5#")
        if [[ $TERRAFORM_MAJOR_VERSION -lt 1 ]]; then
            TERRAFORM_VERSION_INT=$TERRAFORM_MINOR_VERSION
        else
            TERRAFORM_VERSION_INT=$((15 + TERRAFORM_MAJOR_VERSION))
        fi

        STATE_VERSION="$(jq -r '.terraform_version' <<<"{$(aws --profile "$PROFILE" s3api get-object --bucket "$BUCKET" --key "${WORKSPACE_PATH/#default\//}$KEY" --range bytes=0-100 /dev/stdout 2>/dev/null | grep 'terraform_version' | rev | cut -c 2- | rev)}")"
        local STATE_MAJOR_VERSION
        STATE_MAJOR_VERSION=$(echo "$STATE_VERSION" | sed -Ee "s#$RE#\1#")
        local STATE_MINOR_VERSION
        STATE_MINOR_VERSION=$(echo "$STATE_VERSION" | sed -Ee "s#$RE#\2#")
        local STATE_PATCH_VERSION
        STATE_PATCH_VERSION=$(echo "$STATE_VERSION" | sed -Ee "s#$RE#\4#")
        local STATE_SPECIAL_VERSION
        STATE_SPECIAL_VERSION=$(echo "$STATE_VERSION" | sed -Ee "s#$RE#\5#")
        if [[ $STATE_MAJOR_VERSION -lt 1 ]]; then
            STATE_VERSION_INT=$STATE_MINOR_VERSION
        else
            STATE_VERSION_INT=$((15 + STATE_MAJOR_VERSION))
        fi

        if [[ ($((TERRAFORM_VERSION_INT - STATE_VERSION_INT)) -lt 2) && ($((TERRAFORM_VERSION_INT - STATE_VERSION_INT)) -gt -2) || ("$STATE_VERSION" == "null") ]]; then
            if [[ ("$TERRAFORM_VERSION" != "null") && ("$STATE_VERSION" != "null") && ("$TERRAFORM_VERSION" != "$STATE_VERSION") ]]; then
                echo -en "\e[41;97m!!! Your Terraform version (\e[1m${TERRAFORM_VERSION}\e[0;41;97m) "
                echo -en "does not match current state (\e[1m${STATE_VERSION}\e[0;41;97m) "
                echo -en "!!! continue ? y/[\e[1mn\e[0;41;97m]:\e[0m "
                if [[ -n "$ZSH_VERSION" ]]; then
                    read -q -r
                else
                    read -n 1 -r
                fi
                echo
                [[ ! "$REPLY" =~ ^[Yy]$ ]] && return
            fi
        else
            echo -en "\e[41;97mYour Terraform version (\e[1m${TERRAFORM_VERSION}\e[0;41;97m) "
            echo -en "is too far from the current state version (\e[1m${STATE_VERSION}\e[0;41;97m), "
            echo -e "cancelling the action.\e[0m"
            return
        fi
    else
        echo -e "\e[0;31mWorkspace is not initialized, run tf-init\e[0m" && return
    fi
    if [[ -d "vars" ]]; then
        if ! [[ $(\terraform workspace show) == "default" ]]; then
            terraform apply -var-file="vars/$(\terraform workspace show).tfvars" "$@"
        else
            echo -e "\e[0;31mNo operations must be executed in 'default' workspace for multi-env project\e[0m"
        fi
    else
        terraform apply "$@"
    fi
}

_tf-autoswitch() {
    local TERRAFORM_VERSION
    TERRAFORM_VERSION=$(hclreqversion 2>/dev/null)
    tf-switch "$TERRAFORM_VERSION" "AUTO switching to tf $TERRAFORM_VERSION"
}

# Terraform apply for each workspace
# usage : tf-apply-all [workspace-filter] [terraform-args...]
#         workspace-filter may be an environment, tenant, or any string you can find in a filename in `vars/`
#         terraform_args are any terraform argument preceded by a "-" like "-target"
# examples :
# tf-apply-all
# tf-apply-all staging
# tf-apply-all rtlmutu
# tf-apply-all -target module.s3
# tf-apply-all staging -target module.s3
tf-apply-all() {
    tf-exec-all "tf-apply" "$@" #-auto-approve
}

# Switch terraform binary to chosen major version
# usage : tf-switch [version]
# examples :
# tf-switch 14
# tf-switch 11
tf-switch() {
    VERSION="${1}"
    INFO_MSG="${2:-}"
    BIN="${INSTALL_DIRECTORY:-${HOME}/bin}"
    TERRAFORM_FILE="${BIN}/terraform-0.11.15" # Hard coded because, will not change

    if [[ ! "${VERSION}" =~ 1[1-5] && ! "${VERSION}" == 1 ]]; then
      echo "Supported versions [11|12|13|14|15|1]"
      return 1
    fi

    # test if current terraform version is already what we are trying to switch to
    if [ "$(type -p terraform | head -n1 | rev | cut -d' ' -f1 | rev)" -ef "$(type -p "terraform-$VERSION" | head -n1 | rev | cut -d' ' -f1 | rev)" ]; then
        return 0
    fi

    TERRAFORM_FILE="${BIN}/terraform-${VERSION}"

    if [[ "${INFO_MSG}" != "" ]]; then
        echo -e "$INFO_MSG" >&2
        if [[ "${VERSION}" == "11" ]];then
            sleep 2
        fi
    fi

    ln -sf "${TERRAFORM_FILE}" "${BIN}/terraform"
}

tg-init() {
  saml2aws login --skip-prompt >&2
  terragrunt run-all init --terragrunt-non-interactive
}

tg-plan() {
  saml2aws login --skip-prompt >&2
  terragrunt run-all plan --terragrunt-non-interactive --terragrunt-no-auto-init
}

tg-apply() {
  saml2aws login --skip-prompt >&2
  echo "WARNING: 'tg-apply' won't ask for your validation before applying. Be sure to have run 'tg-plan' before anything else."
  echo "Would you like to go ahead and apply every layer anyway? (yes/no)"
  if [[ -n "$ZSH_VERSION" ]]; then
    read -q -r
  else
    read -n 1 -r
  fi
  echo
  [[ ! "$REPLY" =~ ^[Yy]$ ]] && return
  terragrunt run-all apply --terragrunt-non-interactive --terragrunt-no-auto-init
}

# Activate tf debug
alias tf-debug-enable='export TF_LOG=debug'
# Activate tf debug
alias tf-debug-disable='unset TF_LOG'

# Prepare plans for Pull Request body in system clipboard
# usage : tf-pr
tf-pr () {
    local cp2clipboard
    case $(uname | tr '[:upper:]' '[:lower:]') in
    darwin)
        cp2clipboard=pbcopy
        ;;
    linux)
        if command -v xclip >/dev/null; then
            cp2clipboard=xclip
        else
            cp2clipboard=cat
        fi
        ;;
    esac

    template () {
        local WORKSPACE=$1
        local FILE=$2
        cat <<EOT
<details>
<summary>${WORKSPACE}</summary>

\`\`\`terraform
$(TF_WORKSPACE="${WORKSPACE}" \terraform show -no-color "$FILE")
\`\`\`

</details>
EOT
    }

    _tf-autoswitch
    (
        for plan in .terraform/plans/*.tfplan
        do
            template "$(basename "$plan" | sed -e 's/\.tfplan$//')" "${plan}"
        done
    ) | "${cp2clipboard}"
}

tf-providers-lock () {
    terraform providers lock \
        -platform=linux_amd64 \
        -platform=darwin_amd64 \
        -platform=darwin_arm64
}

tf-fmt () {
    terraform fmt "$@"
}

tf-providers-fix () {
   local ws
   ws=$(terraform workspace show)
   rm -rf .terraform .terraform.lock.hcl ~/.terraform.d/plugin-cache/* ~/.terraform.d/plugins/
   tf-init
   tf-providers-lock
   tf-ws "${ws}"
}

tf-output () {
  terraform output "$@"
}

tf-dependencies-upgrade() {
  rm -rf .terraform .terraform.lock.hcl ~/.terraform.d/plugin-cache/* ~/.terraform.d/plugins/
  tf-init -upgrade
  if [[ -r versions.tf ]]; then
    local TERRAFORM_VERSION
    TERRAFORM_VERSION=$(hclreqversion 2>/dev/null)

    if [[ $TERRAFORM_VERSION -lt 11 || $TERRAFORM_VERSION -ge 14 ]]; then
        tf-providers-lock
    fi
  fi
}


# Usage: rds_login profile region rds_name permission
# Note: permission must be "ro" or "rw" only
function rds_login {
  local profile=$1 # 6cloud-staging
  local region=$2 # eu-west-3
  local rds_name=$3 # bedrock-database-master
  local rds_dbname=$4 # bedrock_database_master
  local permission=$5 # ro || rw

  local rds_user="iam-${permission}"
  local rds_host
  local rds_port
  local rds_engine
  local role
  local rds_token
  local permission_titled
  local tmp_dir
  permission_titled=$(tr '[:lower:]' '[:upper:]' <<< "${permission:0:1}")"${permission:1}"

  tmp_dir=$(mktemp -d)
  curl -s -o "${tmp_dir}/rds-combined-ca-bundle.pem" "https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem"

  rds_information=$(aws rds describe-db-instances --profile="${profile}" --region="${region}" --db-instance-identifier="${rds_name}")
  rds_host=$(echo "${rds_information}" | jq -r '.DBInstances[0].Endpoint.Address')
  rds_engine=$(echo "${rds_information}" | jq -r '.DBInstances[0].Engine')
  role=$(aws iam get-role --role-name="rds_iam_${permission}" --profile="${profile}" --query "Role.Arn")

  saml2aws login --role "arn:aws:iam::794815120048:role/OktaRoleForRds${permission_titled}" --force
  eval $(saml2aws exec "aws sts assume-role --role-arn=${role} --role-session-name $USER" | jq -r '.Credentials | "export AWS_ACCESS_KEY_ID=\(.AccessKeyId)\nexport AWS_SECRET_ACCESS_KEY=\(.SecretAccessKey)\nexport AWS_SESSION_TOKEN=\(.SessionToken)\n"')

  rds_port=$([ "${rds_engine}" = "mysql" ] && echo "3306" || echo "5432")
  rds_token=$(aws rds generate-db-auth-token --hostname="${rds_host}" --port "${rds_port}" --username="${rds_user}" --region="${region}")
  if [ "${rds_engine}" = "mysql" ]; then
    LIBMYSQL_ENABLE_CLEARTEXT_PLUGIN=1 mysql --database="${rds_dbname}" --host="${rds_host}" --port="${rds_port}" --ssl-ca="${tmp_dir}/rds-combined-ca-bundle.pem" --user="${rds_user}" --password="${rds_token}"
  else
    psql "dbname=${rds_dbname} host=${rds_host} port=${rds_port} sslmode=verify-full sslrootcert=${tmp_dir}/rds-combined-ca-bundle.pem user=${rds_user} password=${rds_token}"
  fi
  rm -rf "${tmp_dir}"
}

# Helmfile template easy
helmfile-template() {
    if [[ "$#" -eq 2 ]] || [[ "$#" -eq 3 ]] ; then
        if [[ -n "$3" ]] && [[ "$3" == "IS_PREVIEW" ]] ; then
            export IS_PREVIEW=true
        fi
        TENANT=$1 \
        GH_SERVER_REPOSITORY_URL=$(tf-backend-config-key | sed -e 's/\.cloud\/.*//') \
        HELM_EXPERIMENTAL_OCI=1 \
        HELM_REGISTRY_CONFIG=~/.docker/config.json \
        DOCKER_TAG=vtemplate \
        AWS_PROFILE=6cloud-services \
        AWS_REGION=eu-west-3 \
        helmfile --helm-binary helm3 --environment $2 template
    else
        echo "helmfile-template {TENANT} {ENV} {IS_PREVIEW:optional}"
    fi
}

ssm-k8s() {
    local node_name=$1
    if [[ -z "${node_name}" ]] ; then
        echo "Node name is needed"
        return
    fi

    provider_id=$(kubectl get node ${node_name} -o 'custom-columns=ID:spec.providerID' --no-headers)
    if [ $? != 0 ] ; then
        return
    fi

    profile=$(kubectl config view --minify -o jsonpath='{.users[0].user.exec.env[?(@.name == "AWS_PROFILE")].value}')
    node_id=$(echo "${provider_id}" | awk -F "/" '{ print $5 }')
    region=$(echo "${provider_id}" | awk -F "/" '{ print $4 }' | sed -E "s/^(.*)(a|b|c)$/\1/g")
    echo "Connecting to ${node_id} [${region}]"
    aws ssm start-session --target ${node_id} --profile ${profile} --region ${region}
}

