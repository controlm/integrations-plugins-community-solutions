# Conversion - Autosys AI FWText
Version 1.0
## Short description
Control-M FWText job that will search for existence or absence of a string in a file.
## Detailed description
You can define a FWText job to search a text file on a Windows or UNIX for a text string.  

The fields in the job are:  
**File name**: Specifies the path to and name of the text file to search.  
(If the file doesn't exist, the job will fail)  
**Text in file**: Defines the text string to search for.  
**Text exist in file**: specifies whether the job monitors for the existence of a text string in a text file. Either True or False. Default: True
