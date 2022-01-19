# Control-M SAP IBP plugin

First Release: 19-Jan-2022

## Short description:

Control-M Integration plugin for SAP IBP. 

>For the latest SAP IBP information, refer to SAP Notes:
> * 2503171 - Usage of External Job Scheduling solutions with SAP Integrated Business Planning
> * 2789802 - IBP - Common JOB issues when using external scheduler

## Download 

[PlugIn jobtype]: (104-erp-integrations\sapibp\resources\AI_SAPIBP.ctmai)
  
## Pre requisites

### Control-M

* Helix Control-M 
* Helix Control-M Agent v9.0.20.180+ [strong]only on Linux[/strong].
* Application pack v9.0.20.180+

> NOTE: It is likely compatible with Control-M on-premise systems, but it has not yet been tested with it.

### SAP IBP

Uses the published [SAP IBP API] (104-erp-integrations\sapibp\ExternalJobScheduling_Official.pdf)


## Features

* Authentication: Uses Basic Authentication
* Connection Profile:
    * Includes a configurable cycle time to avoid overloading the SAP IBP platform with excessive verification requests (default=60 seconds)
* Job Fields
    * Can be specified with a choice of the Template Name or the Template Text. Most users know the Template Text, but the API requires the Template Name to start the job.
    * Allows to specify the Maximum Duration (timeout) expected on each job.
        If the jobs surpasses the Maximum Duration, you can select to attempt to kill the SAP IBP job, or let it continue.<br>
        In either case, you should validate, per the SAP IBP API manual, that all components have completed.<br>
        See OData Call to Cancel / Unschedule a Job on the (104-erp-integrations\sapibp\resources\ExternalJobScheduling_Official.pdf)
* Return Codes
    * rc=0: IBP Reported completion successfully. JobStatus="F"
    * rc=10: URL for SAP IBP is malformed. Likely cause it is missing the "-api"
    * rc=11: The Template Text or Name specified could not be found.
    * rc=12: The execution in SAP IBP still continues after Control-M job ended. Likely a timeout without a request for termination.
    * rc=13: The execution in SAP IBP terminated with JobStatus=A. The job was cancelled in SAP IBP, or a timeout with termination occurred.
    * rc=14: There was an unknown return code (JobStatus different from A or F)
    * rc=24: The job was manually killed from Control-M. An attempt to terminate the SAP IBP job was automatically sent.

## Test information

### Test Jobs provided

* See (104-erp-integrations\sapibp\resources\AI_SAP_IBP_Test_Jobs.json)
### Sample CCP provided

* See (104-erp-integrations\sapibp\resources\AI_SAP_IBP_CP.json)