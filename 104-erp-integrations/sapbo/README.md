#Sample integration of Control—M with SAP Business Objects

==========================================================

Note:All trademarks are property of their respective owners 


## Table of Contents

[1. SAP BO prerequisites
[3](#sap-business-object-prerequisites)](#sap-business-object-prerequisites)

[2. Application Integrator: create the plugin
[3](#application-integrator-create-the-plugin)](#application-integrator-create-the-plugin)

[3. Add a Connection Profile Attribute in the "Attribute Management" tab
[6](#add-a-connection-profile-attribute-in-the-attribute-management-tab)](#add-a-connection-profile-attribute-in-the-attribute-management-tab)

[4. Create the Form [6](#create-the-form)](#create-the-form)

[5. Step Pre-Execution : Get SAP Token
[8](#step-pre-execution-get-sap-token)](#step-pre-execution-get-sap-token)

[6. Step Get Report ID from CUID
[11](#step-get-report-id-from-cuid)](#step-get-report-id-from-cuid)

[7. Step PUB Schedule Now
[12](#step-pub-schedule-now)](#step-pub-schedule-now)

[8. Sub-step PUB Schedule Now : Verify operation completion
[14](#sub-step-pub-schedule-now-verify-operation-completion)](#sub-step-pub-schedule-now-verify-operation-completion)

[9. Step Document Schedule now
[16](#step-document-schedule-now)](#step-document-schedule-now)

[10. Sub-step Document Schedule: Manual abort operation
[19](#sub-step-document-schedule-manual-abort-operation)](#sub-step-document-schedule-manual-abort-operation)

[11. Sub-step Document Schedule: Verify operation completion
[20](#sub-step-document-schedule-verify-operation-completion)](#sub-step-document-schedule-verify-operation-completion)

[12. Post-execution : logoff
[20](#post-execution-logoff)](#post-execution-logoff)

[13. Publish and Deploy your job type
[20](#publish-and-deploy-your-job-type)](#publish-and-deploy-your-job-type)

[14. Use your new job type in Control-M
[21](#use-your-new-job-type-in-control-m)](#use-your-new-job-type-in-control-m)

**\
**

**Control-M V21 Application Integrator\
***Example of how to create a REST API Integration with SAP Business
Objects*

**Introduction**

Application Integrator is a low code approach to creating an integration
with Control-M. The integrations are built in a UI designer**.**

This documentation shows an example contributed by a Control-M customer
who runs SAP Business Objects. It outlines a series of steps that can be
taken by customers to establish a basic integration with SAP Business
Objects. The document is provided as-is for your convenience, and is not
supported by BMC.


# SAP Business Object prerequisites

  -----------------------------------------------------------------------
  **Parameter**             **Value**
  ------------------------- ---------------------------------------------
  REST API endpoint         http(s)://server_name:6405/biprws

  User                      

  Password                  

  Authentication            secEnterprise,secLDAP,secWinAD,secSAPR3
  -----------------------------------------------------------------------

## Application Integrator: create the plugin

![](media/image1.png)

-   Enter your credentials in the login screen

![](media/image2.png)

-   Click on \"Add Plug-in\"

![](media/image3.png)

-   Name your job type and select REST API as the Steps Default
    Interface

![](media/image4.png)

##  Add a Connection Profile Attribute in the "Attribute Management" tab 

![](media/image5.png)

-   HostURL, UserName are Text Box

-   Password is type Password

    ![](media/image6.png)

-   AuthType is 'DropDown List' with Format

    ![](media/image7.png)

## Create the Form

-   Job Definition

![](media/image8.png)


+-------------------+--------------------------------------------------+
| **Attribut**      | **Format**                                       |
+===================+==================================================+
| Report Type       | Dropdown List                                    |
|                   |                                                  |
|                   | ![](vertopal_d928622f9963465cba9260d5cce71e4     |
|                   | 2/media/image9.png) 							   |
|                   |                    						       |
+-------------------+--------------------------------------------------+
| Report CUID       | Text Box                                         |
+-------------------+--------------------------------------------------+
| Instance title    | Text Box                                         |
+-------------------+--------------------------------------------------+
| Polling           | Text Box, default value 20                       |
+-------------------+--------------------------------------------------+
| Outut Format      | Dropdown List                                    |
|                   |                                                  |
|                   | ![](vertopal_d928622f9963465cba9260d5cce71e      |
|                   | 42/media/image10.png)                            |
+-------------------+--------------------------------------------------+
| Output            | Text Area                                        |
| Destinations xml  |                                                  |
+-------------------+--------------------------------------------------+
| Report Prompts    | Text Area                                        |
| xml               |                                                  |
+-------------------+--------------------------------------------------+

-   Form customization

    ![](media/image11.png)

##  Step Pre-Execution : Get SAP Token

-   REST API tab

    ![](media/image12.png)\
    ![](media/image13.png)

The body is:

{\"userName\":\"{{UserName}}\",\"password\":\"{{Password}}\",\"auth\":\"{{AuthType}}\"}

-   Output Handling tab

    ![](media/image14.png)

##  Step Get Report ID from CUID

-   REST API tab

![](media/image15.png)

![](media/image16.png)

Body is :

{\"query\":\"SELECT SI_ID FROM CI_INFOOBJECTS WHERE si_cuid=\'{{A_CUID}}\'\"}

-   Output Handling tab

    ![](media/image17.png)

##  Step PUB Schedule Now

This step will run the Publication report.

![](media/image18.png)

-   Conditions tab

    ![](media/image19.png)

-   REST API tab

    ![](media/image20.png)

URL is:

v1/publications/{{V_SI_ID}}/schedules/schedule/now

-   Output Handling tab

    ![](media/image21.png)

## Sub-step PUB Schedule Now : Verify operation completion

This sub-step runs loop till a specific value is captured in the Json
response.

-   REST API tab

![](media/image22.png)

The query is:

{\"query\":\"SELECT SI_SCHEDULE_STATUS FROM CI_INFOOBJECTS WHERE
SI_ID={{V_SCHEDULEID}}\"}

-   Output Handling tab

    ![](media/image23.png)\
    ![](media/image24.png)

## Step Document Schedule now

Add the step with these 2 options

![](media/image25.png){width="3.141087051618548in"
height="3.4295527121609797in"}

-   REST API tab

    ![](media/image26.png)\
    ![](media/image27.png)

The body is:

\<schedule\>

\<name\>{{A_INSTANCE}}\</name\>

{{D_FORMAT}}

{{D_DESTINATION}}

{{D_PARAMS}}

\</schedule\>

-   Output Handling tab

    ![](media/image28.png)

## Sub-step Document Schedule: Manual abort operation

-   REST API tab

    ![](media/image29.png)

## Sub-step Document Schedule: Verify operation completion

REST API tab and Output Handling tab are the same as 8.

## Post-execution : logoff

-   REST API tab

![](media/image30.png)

## Publish and Deploy your job type

Select \"Publish & Deploy\"\
![](media/image31.png)

If this window pop-ups, you can publish with Warnings

![](media/image32.png)

Select an Agent an Apply.

If none Agent is present, then deploy he Application Pack/Application
Integrator plugin to an agent.

![](media/image33.png)

##  Use your new job type in Control-M

Log in to the Control-M web environment

![](media/image34.png)

-   Create a new centralised connection profile for your job type:

![](media/image35.png)

Click on Add Connection Profile

Give your connection profile a name and populate the fields from your AI
job in the
blade![](media/image36.png)

-   Create a new job from your job type in the palette in the Planning
    Domain

![](media/image37.png)
