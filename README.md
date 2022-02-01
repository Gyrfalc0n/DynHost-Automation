# DynHost-Automation
OVH dynamic DNS automation

## What is it ?

This is a simple script that allows you to check DNS entries for a list of subdomains and replace the record if the public IP of the network in which the script is run differs from that of the record. Assigned to a scheduled task exploits the full power of the script. Original script from [this Github repo](https://github.com/yjajkiew/dynhost-ovh).

## Installation

Simply download the `dynhost.sh` script. Then, make it executable with : 

```bash
sudo chmod +x dynhost.sh
```
Now, you can execute it.

## Configuration

You have to modify **subdomain.domain.com**, **username** and **password** to match your subdomain address, your __DynHost id__ and the __password__ assigned to it. 
```bash
domaines[0]='subdomain.domain.com;username;password'
```
You can add as much domains as you want, just duplicate the line above and modify the values to match your DynHost domain entry. **Dont forget to increment the index in `domaines[X]`**.

## Scheduled task

The interest of this script is to be executed periodically. The best way to do this is to create a scheduled task with CRON, or any other task scheduler of your choice.
