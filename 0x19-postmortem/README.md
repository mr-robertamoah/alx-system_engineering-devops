# Postmortem

[TalkTherapy app](https://talktherapy.com) was released for user-testing purposes around 7:00am GMT. An outage lead the constant complains by some users about receiving double of some emails, and this happened a lot of times. For some, they may be ok with receiving duplicates but for others, this is spammy and reduces the credibility of your application.

<p>
Also, this was leading to increased use of server resources as well as inefficient use of Mailgun’s third party service.
</p>

## Debugging Process

System Manager, Robert Amoah took logs of the complains are went through them. This first task took place on Thursday, March 21, 2024.
The emails having unique subjects revealed that the emails that were being sent twice were from scheduled commands which were run by cron. The following were the next steps:
- Logging into the system, ```crontab -e``` was used to determine whether or not the cron job is written appropriately. There was no issue with the definition of the cron job.
- Since the definition was not the problem, Robert Amoah decided to look at the cron logs by running the command ```sudo grep cron /var/log/syslog``` and inspecting the logs. A careful inspection of the logs revealed that crontab could be running as root and an admin user created for the purposes of server administration.
- For verification, ```sudo ls /var/spool/cron/crontabs``` command was run and the output was the names of the two system user accounts. Meaning these users are running the same crontab.
- To correct this error, a short bash script was written and run to remove the root user from cron process and restart the cron service.
```bash
# removing the root user from the crontab processes
crontab -u root -r
# restarting cron service
sudo service cron restart
```
- After, a schedule was added to the app that sends at least one administrator an email. This prompted administrators that the solution was successful and there has not been such complaints again.

## Summation

<p>
A user-testing process is useful in catching and dealing with some outages early before full-blown use of an application.
</p>
<p>
Annoying emails were being sent simply because cron jobs were being run byt both users on the server and so simply deleting one user process, which is not deleting the actual user but just the cron being ran by that user fixes duplication of processes.
</p>

## Prevention

This outage was a web server error. To prevent such outages from occurring, you must have at least the following which adds little to no costs to your set-up:
You have to log at least one of the scheduled actions to be able to know whether the actions are being run the appropriate number of times, and at the right times.
You should have a scheduled action that sends a similar alert, in this case an email, to at least one of the administrators so you may know if the alerts are appropriate.
