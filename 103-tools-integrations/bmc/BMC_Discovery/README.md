# Control-M BMC Discovery  plugin

Version 1.0.00

## Changes on this version

| Date | Who | What |
| - | - | - |
| 2020-11-23 | Daniel Companeetz | First release |
| 2022-04-05 | Daniel Companeetz | Uploaded to this repo |

## Contributions

| Date | Who | What |
| - | - | - |
|  | | |

### Short description

Control-M Integration plugin for BMC Discovery

### Detailed description

This Control-M Application Integrator job type enables the automation of BMC Helix Discovery REST API to cause an ad-hoc scan on a single host.

You can use this plugin to cause BMC Discovery to scan a host after it was created via some other automated method (such as terraform, or by deploying a container or a virtual machine), or after using some automated deployment tool to be able to ensure the "inventory" data related to the component is properly updated.

### Pre requisites

The job was created and tested with the following platforms and versions:

* Control-M/EM and Control-M/Server 9.0.19, running on Linux.
* Control-M/Agent and Control-M Application Integrator 9.0.19 (bundled in Control-M Application Pack), running on Linux and Windows.
* BMC Helix Discovery version 11.3.0.5

## Download

* [Click this to download a zip of the PlugIn jobtype](resources/AI_DISCSCAN.zip)  
   Click download and unzip the archive. Then, import the file into the Application Integrator designer.
* [Click this for the uncompressed raw AI_SAPIBP.ctmai file](resources/AI_DISCSCAN.ctmai)  
   This will allow you to retrieve the raw ctmai file as described in the repository [Readme](https://github.com/controlm/integrations-plugins-community-solutions#saving-application-integrator-files-for-use).
* Or use the following command:

   ```bash
   wget -O AI_SAPIBP.ctmai https://github.com/dcompane/integrations-plugins-community-solutions/blob/master/103-tools-integrations/bmc/BMC_Discovery/resources/AI_DISCSCAN.ctmai
   ```

### Features

#### Connection Profile

REST Protocol: HTTP/HTTPS  
REST Host: host name that will be used to connect to BMC Helix Discovery  
REST Port: port for the REST API call  
User Name: valid BMC Helix Discovery username to request the scan  
Password: the username password

#### Discovery Scan Job Form

Use Local Server?: If yes, the IP to scan is ignored, and the host where the agent is running the job is used  
IP to Scan: IP address to scan (do not use a host name)  
Wait till Scan Completes? (Yes/No) If yes, the scan will complete before the job finishes  
Scan Label: Label for the scan. All labels will be appended " - Order %%ORDERID:%%RUNCOUNT"

##### Runtime parameters

UUID: use the variable %%RUN-UCM-RESP_UUID to send the UUID to other jobs or for notification after completion.

Additional Information

The AI plug-in is very verbose as uploaded, to allow easy troubleshooting.  
Please provide feedback of your testing and modifications introduced to allows us to learn what is important for future developments.  
