**Your cron entry should look something like this:**

```0 2 * * 1 cd /root/jhcloud-update-scripts/basic-apt && git pull origin --autostash && chmod +x update-bapt.sh && ./update-bapt.sh```