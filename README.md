# SQ meetings - CI and Docker workshop (01/04/2022)

## Prerequisites

- Python 3.8 or newer
- Docker
- git
- A GitHub account (required for the CI part)
- A text editor
- Apptainer/Singularity (optional)
- pipeviewer (pv, optional)

The code in this repository was developed on a Linux machine and should run fine on macOS.
The code should in principle run on Windows. Nevertheless, a laptop with a UNIX-like os is highly recommended.

Singularity has recently been renamed to Apptainer. First try to install Apptainer and fall back on Singularity if Apptainer is not available for your OS/distribution.

### Installing Docker

If you are running a Linux distribution you can most likely install `Docker` through your system package manager (è.g. `apt`, `dnf`, `pacman`...).

In case your distribution does not package `Docker`, you can try to follow [these](https://docs.docker.com/engine/install/#other-linux-distributions) instructions.

On macOS the instructions vary sligthly depending on whether you device has an Apple Silicon (M1) CPU:
- Instructions for macOS w/ Intel CPUs - [link](https://docs.docker.com/desktop/mac/install/#mac-with-intel-chip)
- Instructions for macOS w/ Apple Silicon - [link](https://docs.docker.com/desktop/mac/install/#mac-with-apple-silicon)

Here are the instructions for Windows in case you don't have access to a laptop with Linux/macOS: [link](https://docs.docker.com/desktop/windows/install/)
If you are running macOS

### Installing Apptainer/Singularity
Apptainer/Singularity can only run on Linux. If you are using macOS or Windows feel free to skip this section.

Many Linux distributions have a package for Apptainer/Singularity.

In case yours doesn't, you can follow [these](https://github.com/apptainer/apptainer/blob/main/INSTALL.md) instructions to install Apptainer from source.

### Testing Docker and Apptainer/Singularity

Testing Docker:
```bash
sudo docker run ubuntu:20.04 cat /etc/os-release
```
Testing Apptainer/Singularity:
```bash
singularity exec docker://ubuntu:20.04 cat /etc/os-release
```

Both commands should produce an output like the following:
```
NAME="Ubuntu"
VERSION="20.04.4 LTS (Focal Fossa)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 20.04.4 LTS"
VERSION_ID="20.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=focal
UBUNTU_CODENAME=focal
```

<details>
<summary>In case you host machine is running Ubuntu 20.04</summary>

If your host machine is running Ubuntu 20.04, you can try to run the above commands with `fedora:36` instead of `ubuntu:20.04`
In this case the output should looke like this:

```
NAME="Fedora Linux"
VERSION="36 (Container Image Prerelease)"
ID=fedora
VERSION_ID=36
VERSION_CODENAME=""
PLATFORM_ID="platform:f36"
PRETTY_NAME="Fedora Linux 36 (Container Image Prerelease)"
ANSI_COLOR="0;38;2;60;110;180"
LOGO=fedora-logo-icon
CPE_NAME="cpe:/o:fedoraproject:fedora:36"
HOME_URL="https://fedoraproject.org/"
DOCUMENTATION_URL="https://docs.fedoraproject.org/en-US/fedora/f36/system-administrators-guide/"
SUPPORT_URL="https://ask.fedoraproject.org/"
BUG_REPORT_URL="https://bugzilla.redhat.com/"
REDHAT_BUGZILLA_PRODUCT="Fedora"
REDHAT_BUGZILLA_PRODUCT_VERSION=36
REDHAT_SUPPORT_PRODUCT="Fedora"
REDHAT_SUPPORT_PRODUCT_VERSION=36
PRIVACY_POLICY_URL="https://fedoraproject.org/wiki/Legal:PrivacyPolicy"
VARIANT="Container Image"
VARIANT_ID=container
```
</details>

## Repository structure

- `bedtools_ng/` contains the source files and unit tests for the toy application we will be using throughout the workshop
- `snippets/` contains few cheatsheets with common/useful commands
- `.github/workflows/` contains two example workflows that will be used as base to develop more complex workflows

## GitHub container registry (GHCR)
Packages published on the GHCR for the current repository are available in the `Package` section on the right:
![Packages on GHCR](https://user-images.githubusercontent.com/71787608/161065501-698480a5-692a-496e-b9b1-5de87bed4cb0.png)


## GitHub actions logs
Logs for GitHub actions runs ara available under the `Actions` tab in the top bar:
![GHA logs](https://user-images.githubusercontent.com/71787608/161066083-fa4956a3-662c-4e10-adae-899beb8bca38.png)
