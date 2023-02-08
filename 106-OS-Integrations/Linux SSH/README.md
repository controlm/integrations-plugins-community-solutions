# Helix Control-M Remote Command Line via SSH plugin

As of this publication, this is still being tested, but it is already functional and can be used as a really good starting point.

## Changes on this version

| Date | Who | What |
| - | - | - |
| 2023-02-07 | Daniel Companeetz | Initial release |


## Contributions

| Date | Who | What |
| - | - | - |
| 2023-02-07 | Wendel Bordelon | Provided the base development of the ssh plugin  |

## Who is using it (from comments in the BMC Communities)

| Date | Who | See comments on |
| - | - | - |

## Short description

Helix Control-M Integration plugin for SSH remote execution.

This integration allows to execute jobs on a any platform that accepts submission via SSH, from a Linux Helix Control-M agent.


## Download

* [Click this to download a zip of the PlugIn jobtype](resources/AI_DCOSSH.zip)  
   Click download and unzip the archive. Then, import the file into the Application Integrator designer.
* [Click this for the uncompressed raw AI_IBMiSSH.ctmai file](resources/AI_DCOSSH.ctmai)  
   This will allow you to retrieve the raw ctmai file as described in the repository [Readme](https://github.com/controlm/integrations-plugins-community-solutions#saving-application-integrator-files-for-use).
* Or use the following command:

   ```bash
   wget -O AI_DCOSSH.ctmai https://github.com/controlm/integrations-plugins-community-solutions/raw/master/106-OS-Integrations/Linux%20SSH/resources/AI_DCOSSH.ctmai
   ```

## Pre requisites

### Control-M

* Helix Control-M
* Helix Control-M Agent 9.21.081 **only on Linux**.

> NOTE: It is likely compatible with Control-M on-premise systems, but it has not yet been tested with it.

### Linux requirements

* sshpass (v1.06 or higher) must be installed and available to the agent user

## Features

### Authentication

Three authentication possibilities

1. Username/password
2. Username and key with passphrase
3. Username and key without passphrase (not recommended!!)

* Connection Profile:
  * Enter the host, port, Communication User and Password. The Password will be obscured.
  * Additional options to debug the sshpass and the SSH connectivity are in the CP
* Job Fields
  * Select the appropriate connection profile
  * Enter the remote command to execute
  
* Return Codes
  
  * rc=0:  The execution of the command completed successfully
  * rc!=0: Errors occurred. Check the output

