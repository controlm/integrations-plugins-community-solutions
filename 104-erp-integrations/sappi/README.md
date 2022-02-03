* Detailed Description

This Control-M Application Integrator job type enables the automation of SAP PI channels.

The job uses SAP PI REST API services to request a channel action.

The AI plug-in can run on Windows and Unix (bash and csh), and this template can be easily adapted to other shells as needed.

The objective of this fully functional module is to show how easy it is to configure a job type based on any application that has an available API.

The job form also allows to load the channels properties using load options to ensure no typos occur when adding the required parameters to the job.

For additional information on the REST API Adapter, see the [PI REST Adapter overview SAP Blog](https://blogs.sap.com/2014/12/18/pi-rest-adapter-blog-overview/)

The available actions are:

    Start
        Start
        Start and monitor for a specific state, and raise an error and fail the job if not received.
        Start and Stop the channel after a specified time
    Check
        Check for a specific status
    Stop the channel

Changes on this version:

| Date | Who | What |
| - | - | - |
| 2020-03-11 | Daniel Companeetz | Changed the wait time logic for the start and close module. Sleep was not well constructed for Windows.|
| 2020-09-22 | Daniel Companeetz | Changed start task protocol to use parameter. Thanks Paul Harbord for input via comments!|
| 2022-02-03 | Daniel Companeetz | Uploaded to this integration sharing space with no modifications. |

Connection Profile

    REST Protocol: HTTP/HTTPS
    REST Host: host name that will be used to connect to SAP
    REST Port: port for the REST API call
    User Name: valid SAP username to act on the specified channel
    Password: the username password

SAP PI Job Form

Parameters

    Party
    Service
    Channel
    Action: As described above
    Channel expected state: The expected state of the channel when a start action is completed. If this state is not received, a message is written to the output and the job fails
    Close channel after time: Checkmark for the close after start action
    Close Channel time: units of time to wait until requesting the channel close
    Close Channel time units: minutes/hours
    Raise Alert if error: if the channel did not start with the expected state, write a message and fail the job..

Additional Information

    The AI plug-in is very verbose as uploaded, to allow easy troubleshooting.

Please provide feedback of your testing and modifications introduced to allows us to learn what is important for future developments.

Requirements

    Control-M/Agent with Control-M Application Integrator plug-in installed, running on Unix/Linux or Windows.
    Control-M/Agent and Control-M Application Integrator 9.0.19 (bundled in Control-M Application Pack), running on Linux and Windows.

Platforms and versions

The job was created and tested with the following platforms and versions:

    Control-M/EM and Control-M/Server 9.0.19, running on Linux.
    Control-M/Agent and Control-M Application Integrator 9.0.19 (bundled in Control-M Application Pack), running on Linux and Windows.