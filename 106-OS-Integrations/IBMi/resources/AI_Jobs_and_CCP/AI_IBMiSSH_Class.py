from ctm_python_client.core.comm import *
from ctm_python_client.core.workflow import *

from aapi import *
import attrs

# All JobTypes are decorated with attrs

@attrs.define
class AIJobDCOIBMiSSH(AIJob):   # We derive from AIJob, the name of the class can be any valid python class name
    _type = AIJob.type_field('AI DCOIBMiSSH')   # We add a "type" field, with the same name you would see in the web interface.
                                                # the name in type IS important and should match the one seen in the Web Interface
                                                # in the Planning section

    # the field name argument needs to match the one in the Web interface

    usesbmjob = AIJob.field('Use SBMJOB?')
    command = AIJob.field('IBMi Command')
    jobname = AIJob.field('JOB NAME')
    jobowner = AIJob.field('JOB OWNER')
    jobd = AIJob.field('JOBD')
    jobq = AIJob.field('JOBQ')
    curlib = AIJob.field('CURLIB')
    outq = AIJob.field('OUTQ')
    vercycle= AIJob.field('Verification cycle time')
    log = AIJob.field('LOG')
    inllibl = AIJob.field('INLLIBL')
    logclpgm= AIJob.field('LOGCLPGM')
    ifkill = AIJob.field('If Kill is needed')
    killdelay = AIJob.field('Kill Delay')
    addparms = AIJob.field('Additional Parameters')

assert __name__ != "__main__", "Do not call me directly... This is existentially impossible!"
