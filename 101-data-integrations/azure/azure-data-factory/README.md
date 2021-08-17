# Control-M Azure Data Factory plugin
Version 1.0.01

### Short description:
Control-M Integration plugin for Azure data factory (ADF) pipelines.
 
### Detailed description:

The Azure Data Factory plugin for Control-M enables the integration of ADF pipelines with your existing Control-M
workflows.

Azure data factory is a cloud-based ETL and data integration service that allows you to create data-driven workflows 
for orchestrating data movement and transforming data at scale.

Triggers and monitors Data Factory pipelines with this integration. Authentication can be handled by Service Principal
and Managed Identity.

#### Pre requisites

Control-M Version 9.20.000,
Fixpack 9.0.20.100,
Application pack Patch 9.0.20.101

Note: This plugin is not compatible with bmc Helix Control-M

#### Features

* #### 1. Service Principal and Managed Identity Authentication 

![](./images/connprof.png)

* #### 2. Trigger pipelines with parameters.

![jobparams](./images/jobparams.png)

* #### 3. Return the results of the pipeline steps to the output in the Control-M Monitoring domain.  

![output](./images/output.png)

* #### 4. Integrate Azure pipeline runs with all existing Control-M capabilities.  
    For example : 
                   
        a. Have your pipeline tasks defined in JSON and managed by your cicd process.          
        b. Attach SLA's to your pipeline.
        c. Wait for a b2b source to arrive and process it in an application and run a pipeline based on the outcome.
        d. Attach prior and post dependancy steps to your pipeline for a fully encompassed view of your environment.
        e. A single reference point for the entire lifecycle of your data, from creation to analytics.

* #### 5. Avoid connection timeouts and unnecessary pipeline reruns



 

