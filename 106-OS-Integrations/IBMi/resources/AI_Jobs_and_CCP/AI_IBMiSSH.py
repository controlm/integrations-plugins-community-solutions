
from ctm_python_client.core.comm import *
from ctm_python_client.core.workflow import *

from aapi import *

from AI_IBMiSSH_Class import AIJobDCOIBMiSSH

workflow = BaseWorkflow()   # BaseWorkflow is a workflow which is not connected to any environment

# All params reported
aijob = AIJobDCOIBMiSSH('MySSHCommand',
            connection_profile='HOSTCP',
            usesbmjob = 'Y',
            command='ls',
            jobname = 'JOB NAME',
            jobowner = 'JOB OWNER',
            jobd = 'JOBD',
            jobq = 'JOBQ',
            curlib = 'CURLIB',
            outq = 'OUTQ',
            vercycle= 'Verification cycle time',
            log = 'LOG',
            inllibl = 'INLLIBL',
            logclpgm= 'LOGCLPGM',
            ifkill = 'If Kill is needed',
            killdelay = 'Kill Delay',
            addparms = 'Additional Parameters')

workflow.add(aijob, inpath='AIfolder')

print(workflow.dumps_json(indent=2))

# All params reported
aijob_incomplete = AIJobDCOIBMiSSH('MySSHCommand',
            connection_profile='HOSTCP',
            usesbmjob = 'Y',
            command='ls',
            jobname = 'JOB NAME',
            jobowner = 'JOB OWNER')

workflow.add(aijob_incomplete, inpath='AIfolder')

print(workflow.dumps_json(indent=2))