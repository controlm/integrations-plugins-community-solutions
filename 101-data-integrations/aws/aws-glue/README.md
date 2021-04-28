# Control-M AWS Glue plugin
Version 1.0.01

### Short description:
Control-M Integration plugin for AWS Glue pipelines.

Coming Soon
 
### Detailed description:

The Glue plugin for Control-M enables the integration of Glue pipelines with your existing Control-M
workflows.

AWS Glue is a cloud-based ETL and data integration service that allows you to create data-driven workflows 
for orchestrating data movement and transforming data at scale.

Trigger and monitor Data Factory pipelines with this integration. Authentication can be handled by Service Principal
and Managed Identity.

#### Features

* #### 1. Service Principal and Managed Identity Authentication 



* #### 2. Trigger pipelines with parameters.



* #### 3. Return the results of the pipeline steps to the output in the Control-M Monitoring domain.  



* #### 4. Integrate Glue pipeline runs with all existing Control-M capabilities.  
    For example : 
                   
        a. Have your pipeline tasks defined in JSON and managed by your cicd process.          
        b. Attach SLA's to your pipeline.
        c. Wait for a b2b source to arrive and process it in an application and run a pipeline based on the outcome.
        d. Attach prior and post dependancy steps to your pipeline for a fully encompassed view of your environment.
        e. A single reference point for the entire lifecycle of your data, from creation to analytics.

* #### 5. Avoid connection timeouts and unnecessary pipeline reruns


