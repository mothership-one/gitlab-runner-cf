# Docker GitLab Runner optimized for Cloud Foundry

A Dockerized **GitLab Runner** that automatically registers with the GitLab CI Server.
Built and tested with **SAP Cloud Foundry**.

## Installation

The Docker image can be run directly from Docker Hub:

```
git clone "https://github.com/Cyclenerd/gitlab-runner-cf.git"
cd gitlab-runner-cf
cf push --docker-image cyclenerd/gitlab-runner-cf:latest
```

All settings according to the [GitLab Runner help](https://docs.gitlab.com/runner/commands/README.html#gitlab-runner-register
) can be passed as system variables:

```
cf set-env gitlab-runner-cf CI_SERVER_URL "https://gitlab.com/"
cf set-env gitlab-runner-cf RUNNER_NAME "gitlab-runner-cf-sandbox"
cf set-env gitlab-runner-cf REGISTRATION_TOKEN "XYZ"
cf set-env gitlab-runner-cf REGISTER_NON_INTERACTIVE true
cf set-env gitlab-runner-cf REGISTER_RUN_UNTAGGED true
cf set-env gitlab-runner-cf RUNNER_TAG_LIST "sap,cloud,shell,cf,sandbox"
cf set-env gitlab-runner-cf RUNNER_EXECUTOR "shell"
```

## Help 👍

If you have found a bug or have any improvements, send me a pull request.