# Control-M Google DataFlow plugin
Version 1.0.00

### Short description:
Control-M Integration plugin for Google DataFlow jobs.
 
### Detailed description:

The Google DataFlow plugin for Control-M enables the integration of Google DataFlow jobs with your existing Control-M
workflows.

Google DataFlow is a processing serverless engine, that can process data on batch or streaming. 
It allows users to run jobs based on templates, develop new templates and run, or create templates based on SQL.

Control-M integration with Google DataFlow allows triggering of new jobs based on any template (Classic or Flex) created on Google DataFlow.

Authentication can be handled by Service Principal and Managed Identity.

#### Features

* #### 1. Service Principal and Managed Identity Authentication 

![](./images/connection_profile.png)

* #### 2. Trigger jobs with parameters based any Template.

![jobparams](./images/job_creation.png)

* #### 3. Return the results of the job steps to the output in the Control-M Monitoring domain.  

![output](./images/output.png)

* #### 4. Integrate Google DataFlow runs with all existing Control-M capabilities.  
    For example : 
                   
        a. Have your job on DataFlow defined in JSON and managed by your cicd process.
        b. Attach SLA's to your pipeline.
        c. Wait for a b2b source to arrive and process it in an application and run a pipeline based on the outcome.
        d. Attach prior and post dependancy steps to your pipeline for a fully encompassed view of your environment.
        e. A single reference point for the entire lifecycle of your data, from creation to analytics.

* #### 5. Avoid connection timeouts and unnecessary job reruns


 

