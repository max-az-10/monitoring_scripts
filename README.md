# System Health Monitor

Bash-based system health monitoring tool that tracks CPU, memory, and disk
usage, compares them against configurable thresholds, logs every check, and
sends an email alert when a threshold is exceeded.

## Features
- Independent scripts for CPU, memory, and disk monitoring
- Configurable thresholds via `config.env`
- Email alerts via Gmail SMTP (Python `smtplib`)
- Persistent logging to `logs/monitor.log`
- Designed to run on a schedule via `cron`

## Project structure
```text
monitoring_scripts/
├── cpu_monitor.sh        # Checks CPU usage
├── memory_monitor.sh     # Checks memory usage
├── disk_monitor.sh       # Checks disk usage
├── system_monitor.sh     # Runs all three, called by cron
├── send_email.py         # Sends alert emails
├── config.env.example    # Template for thresholds/email config
├── .gitignore            # Excludes secrets and logs from git
└── logs/                 # Runtime logs (not committed)
```

## Setup

1. Clone the repo and enter the directory:

   git clone https://github.com/<your-username>/system-health-monitor.git
   cd system-health-monitor

2. Create your config file from the template:

   cp config.env.example config.env

3. Edit `config.env` with your thresholds and email credentials. For Gmail,

   generate an [App Password](https://myaccount.google.com/apppasswords)
   (requires 2-Step Verification enabled) — do not use your normal password.

4. Make the scripts executable:

   chmod +x cpu_monitor.sh memory_monitor.sh disk_monitor.sh system_monitor.sh

5. Run it manually to test:

   ./system_monitor.sh
   cat logs/monitor.log

## Automating with cron

Run every 5 minutes:
crontab -e

Add:

*/5 * * * * /full/path/to/system-health-monitor/system_monitor.sh

## Thresholds

Set in `config.env`:

| Variable          | Default | Meaning                          |
|-------------------|---------|-----------------------------------|
| `CPU_THRESHOLD`   | 80      | Alert if CPU usage >= 80%         |
| `MEM_THRESHOLD`   | 80      | Alert if memory usage >= 80%      |
| `DISK_THRESHOLD`  | 85      | Alert if disk usage (`/`) >= 85%  |

## Possible extensions
- Add Slack/Discord webhook alerts alongside email
- Track multiple mount points, not just `/`
- Push metrics to Prometheus/Grafana for dashboards
- Add a systemd timer as an alternative to cron

## Push to GitHub
git init
git add .
git status          # confirm config.env and logs/ are NOT listed
git commit -m "Add system health monitoring scripts with email alerts"

## create a repo on github.com first, then:
git remote add origin https://github.com/<your-username>/system-health-monitor.git
git branch -M main
git push -u origin main

## Author
Max A.
Graduate Student/ Linux Engineer/ DevOps Engineer

GitHub: https://github.com/max-az-10

Repository: https://github.com/max-az-10/monitoring_scripts.git

## Crontab for cron job

## Review

## Edit your cron jobs
crontab -e

## List your cron jobs
crontab -l

## Remove all cron jobs
crontab -r

## Edit another user's crontab (requires sudo)
sudo crontab -u username -e

## List another user's cron jobs
sudo crontab -u username -l

# Common cron schedules

## Every 5 minutes
*/5 * * * * command

## Every minute
* * * * * command

## Every hour
0 * * * * command

## Every day at 2:00 AM
0 2 * * * command

## Every day at 6:30 AM
30 6 * * * command

## Every Sunday at midnight
0 0 * * 0 command

``` text
Easy way to remember the five fields
*     *     *     *     *
│     │     │     │     │
│     │     │     │     └── Day of week
│     │     │     └──────── Month
│     │     └────────────── Day of month
│     └──────────────────── Hour
└────────────────────────── Minute
```

