# Helix Control-M IBMi Command Line via SSH plugin

As of this publication, this is still being tested, but it is already functional and can be used as a really good starting point.

## Changes on this version

| Date | Who | What |
| - | - | - |
| 2023-02-07 | Daniel Companeetz | Initial release |


## Contributions

| Date | Who | What |
| - | - | - |
| 2023-02-07 | Wendel Bordelon | Provided the base development of the ssh plugin  |
| 2023-02-07 | Arbel Yahel | Provided all the IBMi knowledge needed to develop the interface |

## Who is using it (from comments in the BMC Communities)

| Date | Who | See comments on |
| - | - | - |

## Short description

Control-M Integration plugin for IBMi.

This integration allows to execute jobs on the IBMi platform via SSH, from a Linux Helix Control-M agent.

Jobs can be sent for interactive run, or submitted via SBMJOB.

## Download

* [Click this to download a zip of the PlugIn jobtype](resources/AI_IBMiSSH.zip)  
   Click download and unzip the archive. Then, import the file into the Application Integrator designer.
* [Click this for the uncompressed raw AI_IBMiSSH.ctmai file](resources/AI_IBMiSSH.ctmai)  
   This will allow you to retrieve the raw ctmai file as described in the repository [Readme](https://github.com/controlm/integrations-plugins-community-solutions#saving-application-integrator-files-for-use).
* Or use the following command:

   ```bash
   wget -O AI_IBMiSSH.ctmai https://github.com/controlm/integrations-plugins-community-solutions/raw/master/106-OS-Integrations/IBMi/resources/AI_IBMiSSH.ctmai
   ```

## Pre requisites

### Control-M

* Helix Control-M
* Helix Control-M Agent 9.21.081 **only on Linux**.

> NOTE: It is likely compatible with Control-M on-premise systems, but it has not yet been tested with it.

### Linux requirements

* sshpass (v1.06 or higher) must be installed and available to the agent user

### IBMi

* Tested with IBMi 7.4
* The user must have the necessary permissions to
  * Login to the IBMi system and
  * Execute the commands required

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
  * Select if the job should use the SBMJOB command
    * If yes, additional options will appear
  * Enter the IBMi command to execute
  * Includes a configurable cycle time per job to avoid overloading the IBMi with excessive verification requests (default=10 seconds)
* Return Codes
  
  * rc=0:  The execution of the command completed successfully
  * rc!=0: Errors occurred. Check the output
    * rc=42: An attempt to run on a **Windows platform** (as defined in the CP) was detected

## Test information

### Sample CCP provided

* [See Connection Profile](resources/AI_Jobs_and_CCP/AI_IBMiSSH_CP.json)

### Test Jobs provided

* [See Sample JSON Test Jobs](resources/AI_Jobs_and_CCP/AI_IBMiSSH_Test_Jobs.json)

## Overall flow for the plugin

* If the job is interactive, the command is run and completes in the same step.
* If the  job is submitted (SBMJOB),
  * 1. after the job is started, WRKJOB is used to check if the job completed.
  * 2. If there are logs, it is found via WRKSPLF
    * Only QPJOBLOG is extracted if it exists and added to the output.
    * Otherwise, DSPLOG is used to retrieve the log and added to the output.
