#!/usr/bin/env python3
"""Sends an email alert. Called by the bash monitoring scripts."""
import smtplib
import sys
import os
from email.mime.text import MIMEText


def load_env(path="config.env"):
    """Load KEY=VALUE pairs from config.env into the environment."""
    if not os.path.exists(path):
        print(f"Missing {path}. Copy config.env.example to config.env first.")
        sys.exit(1)
    with open(path) as f:
        for line in f:
            line = line.strip()
            if not line or line.startswith("#") or "=" not in line:
                continue
            key, value = line.split("=", 1)
            os.environ[key] = value.strip('"')


def send_email(subject, body):
    load_env()
    sender = os.environ["ALERT_EMAIL_FROM"]
    password = os.environ["ALERT_EMAIL_PASSWORD"]
    recipient = os.environ["ALERT_EMAIL_TO"]

    msg = MIMEText(body)
    msg["Subject"] = subject
    msg["From"] = sender
    msg["To"] = recipient

    with smtplib.SMTP_SSL("smtp.gmail.com", 465) as server:
        server.login(sender, password)
        server.sendmail(sender, recipient, msg.as_string())


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: send_email.py <subject> <body>")
        sys.exit(1)
    send_email(sys.argv[1], sys.argv[2])
