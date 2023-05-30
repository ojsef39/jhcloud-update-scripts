**Your cron entry should look something like this:**

```0 2 * * 1 cd /root/jhcloud-update-scripts/amp && git pull origin --autostash && chmod +x update-port.sh && ./update-amp.sh```