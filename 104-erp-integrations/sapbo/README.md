#Sample integration of Control—M with SAP Business Objects
**

# Table of Contents 

[[1](#_Toc72225198)](#_Toc72225198)

[1. SAP BO prerequisites
[3](#sap-bo-prerequisites)](#sap-bo-prerequisites)

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
***Creating a SAP BO REST API Integration*

**Introduction**

Application Integrator is a low code approach to creating an integration
with Control-M. The integrations are built in a UI designer**.**

This documentation serves as an example created by one of our valued
customers and not by BMC. It\'s important to note that this document
does not contain code or proprietary solutions but rather outlines a
series of steps that can be taken by customers to establish a basic
integration with SAP BusinessObjects (SAP BO). Both the customer and BMC
bear no accountability for the content provided in this documentation.

The primary aim of this document is to inspire and offer ideas to our
community of customers, illustrating how straightforward it can be to
create integrations with SAP BO using our Application Integrator. While
this document is based on the experience and insights of a single
customer, it is shared with the hope that it will be a valuable resource
for others, sparking creativity and simplifying the process of
integrating SAP BO with our solutions.

#  {#section .list-paragraph}

# SAP BO prerequisites

  -----------------------------------------------------------------------
  **Parameter**             **Value**
  ------------------------- ---------------------------------------------
  REST API endpoing         http(s)://server_name:6405/biprws

  User                      

  Password                  

  Authentication            secEnterprise,secLDAP,secWinAD,secSAPR3
  -----------------------------------------------------------------------

# Application Integrator: create the plugin

![](media/image1.png){width="6.17in"
height="3.2095866141732285in"}

-   Enter your credentials in the login screen

![](media/image2.png){width="5.296685258092738in"
height="3.345513998250219in"}

-   Click on \"Add Plug-in\"

![](media/image3.png){width="6.5in"
height="1.1729166666666666in"}

-   Name your job type and select REST API as the Steps Default
    Interface

![](media/image4.png){width="3.7913254593175854in"
height="4.96148731408574in"}

#  Add a Connection Profile Attribute in the "Attribute Management" tab 

![](media/image5.png){width="6.262948381452318in"
height="3.824463035870516in"}

-   HostURL, UserName are Text Box

-   Password is type Password

    ![](media/image6.png){width="2.18542760279965in"
    height="0.5090288713910761in"}

-   AuthType is 'DropDown List' with Format

    ![](media/image7.png){width="4.942849956255468in"
    height="2.5141994750656167in"}

# Create the Form

-   Job Definition

![](media/image8.png){width="5.054126202974628in"
height="4.689395231846019in"}

+-------------------+--------------------------------------------------+
| **Attribut**      | **Format**                                       |
+===================+==================================================+
| Report Type       | Dropdown List                                    |
|                   |                                                  |
|                   | ![](vertopal_8273c859cea744769ed324d2db28463     |
|                   | 9/media/image9.png){width="3.8723654855643046in" |
|                   | height="1.3391929133858267in"}                   |
+-------------------+--------------------------------------------------+
| Report CUID       | Text Box                                         |
+-------------------+--------------------------------------------------+
| Instance title    | Text Box                                         |
+-------------------+--------------------------------------------------+
| Polling           | Text Box, default value 20                       |
+-------------------+--------------------------------------------------+
| Outut Format      | Dropdown List                                    |
|                   |                                                  |
|                   | ![](vertopal_8273c859cea744769ed324d2db2846      |
|                   | 39/media/image10.png){width="4.52005905511811in" |
|                   | height="2.250371828521435in"}                    |
+-------------------+--------------------------------------------------+
| Output            | Text Area                                        |
| Destinations xml  |                                                  |
+-------------------+--------------------------------------------------+
| Report Prompts    | Text Area                                        |
| xml               |                                                  |
+-------------------+--------------------------------------------------+

-   Form customization

    ![](media/image11.png){width="4.960337926509187in"
    height="4.074563648293963in"}

#  Step Pre-Execution : Get SAP Token

-   REST API tab

    ![](media/image12.png){width="6.5in"
    height="4.595138888888889in"}\
    ![](media/image13.png){width="6.5in"
    height="1.2881944444444444in"}

The body is:

{\"userName\":\"{{UserName}}\",\"password\":\"{{Password}}\",\"auth\":\"{{AuthType}}\"}

-   Output Handling tab

    ![](media/image14.png){width="6.5in"
    height="2.7222222222222223in"}

#  Step Get Report ID from CUID

-   REST API tab

![](media/image15.png){width="6.5in"
height="4.727083333333334in"}

![](media/image16.png){width="6.5in"
height="1.3118055555555554in"}

Body is :

{\"query\":\"SELECT SI_ID FROM CI_INFOOBJECTS WHERE
si_cuid=\'{{A_CUID}}\'\"}

-   Output Handling tab

    ![](media/image17.png){width="6.946385608048994in"
    height="2.703597987751531in"}

#  Step PUB Schedule Now

This step will run the Publication report.

![](media/image18.png){width="3.4628947944007in"
height="4.050667104111986in"}

-   Conditions tab

    ![](media/image19.png){width="6.5in"
    height="1.30625in"}

-   REST API tab

    ![](media/image20.png){width="6.5in"
    height="4.716666666666667in"}

URL is:

v1/publications/{{V_SI_ID}}/schedules/schedule/now

-   Output Handling tab

    ![](media/image21.png){width="6.5in"
    height="3.5680555555555555in"}

# Sub-step PUB Schedule Now : Verify operation completion

This sub-step runs loop till a specific value is captured in the Json
response.

-   REST API tab

![](media/image22.png){width="6.5in"
height="5.682638888888889in"}

The query is:

{\"query\":\"SELECT SI_SCHEDULE_STATUS FROM CI_INFOOBJECTS WHERE
SI_ID={{V_SCHEDULEID}}\"}

-   Output Handling tab

    ![](media/image23.png){width="6.5in"
    height="2.936111111111111in"}\
    ![](media/image24.png){width="4.799887357830271in"
    height="3.943497375328084in"}

# Step Document Schedule now

Add the step with these 2 options

![](media/image25.png){width="3.141087051618548in"
height="3.4295527121609797in"}

-   REST API tab

    ![](media/image26.png){width="6.5in"
    height="4.7243055555555555in"}\
    ![](media/image27.png){width="6.5in"
    height="1.2840277777777778in"}

The body is:

\<schedule\>

\<name\>{{A_INSTANCE}}\</name\>

{{D_FORMAT}}

{{D_DESTINATION}}

{{D_PARAMS}}

\</schedule\>

-   Output Handling tab

    ![](media/image28.png){width="6.758537839020122in"
    height="2.860102799650044in"}

# Sub-step Document Schedule: Manual abort operation

-   REST API tab

    ![](media/image29.png){width="6.5in"
    height="5.182638888888889in"}

# Sub-step Document Schedule: Verify operation completion

REST API tab and Output Handling tab are the same as 8.

# Post-execution : logoff

-   REST API tab

![](media/image30.png){width="6.5in"
height="4.675694444444445in"}

# Publish and Deploy your job type

Select \"Publish & Deploy\"\
![](media/image31.png){width="6.5in"
height="1.45625in"}

If this window pop-ups, you can publish with Warnings

![](media/image32.png){width="1.8689643482064742in"
height="0.7382928696412948in"}

Select an Agent an Apply.

If none Agent is present, then deploy he Application Pack/Application
Integrator plugin to an agent.

![](media/image33.png){width="4.095405730533684in"
height="4.095405730533684in"}

#  Use your new job type in Control-M

Log in to the Control-M web environment

![](media/image34.png){width="6.17in"
height="3.486621828521435in"}

-   Create a new centralised connection profile for your job type:

![](media/image35.png){width="6.5in"
height="3.495138888888889in"}

Click on Add Connection Profile

Give your connection profile a name and populate the fields from your AI
job in the
blade![](media/image36.png){width="4.08823053368329in"
height="4.609688320209973in"}

-   Create a new job from your job type in the palette in the Planning
    Domain

![](media/image37.png){width="4.533081802274715in"
height="3.7202537182852145in"}
