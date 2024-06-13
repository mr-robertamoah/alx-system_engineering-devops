<p align='center'>
<img src='https://drive.google.com/file/d/13BS3iYDnTekR2KDUcJBXfoOSkBHCZ3Cb/view?usp=sharing' alt='TalkTherapy logo'/>
</p>

# Postmortem

[TalkTherapy app](https://talktherapy.com) was released for user-testing purposes around 7:00am GMT, March 19, 2024. An outage lead the constant complains by some users about receiving double of some emails, for two days. This is the [blog](https://medium.com/@mr-robertamoah/postmortem-ae40a406aacd).

## Debugging Process

- Checked emails the complaints where about.
- Logged into the system
- Ran ```crontab -e``` to inspect cron job responsible for the emails.
- Ran ```sudo grep cron /var/log/syslog``` to reveal cron logs for inspection.
- Ran ```sudo ls /var/spool/cron/crontabs``` command to display user crontab files currently running.
- Ran code below.
```bash
# removing the root user from the crontab processes
crontab -u root -r
# restarting cron service
sudo service cron restart
```
- Added a schedule that send me an email, to the application.

## Summation

<p>
Two user crontab files were having the same cron job definitions which lead to duplication of notifications.
</p>
<p>
Removing one of the user files solved the issue.
</p>

## Prevention

- Ensure there is only one user crontab file.
- Or ensure user crontab files have unique cron job definitions.
