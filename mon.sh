# __  ___  __      ____    ____  __  ___ ____    ____  ___      
#|  |/  / |  |     \   \  /   / |  |/  / \   \  /   / /   \     
#|  '  /  |  |      \   \/   /  |  '  /   \   \/   / /  ^  \    
#|    <   |  |       \_    _/   |    <     \      / /  /_\  \   
#|  .  \  |  `----.    |  |     |  .  \     \    / /  _____  \  
#|__|\__\ |_______|    |__|     |__|\__\     \__/ /__/     \__\ 
                                                               
#!/bin/bash

# Check hostname
echo -e "Hostname :" $HOSTNAME

# Check Internal IP
internalip=$(hostname -I | awk '{print $1}')
echo -e "Internal IP :" $internalip

# Check Logged In Users
who>/tmp/who
echo -e "Logged In users :" $(cat /tmp/who | awk '{$2=""; print $0}')

# Check CPU Usages
#cpuUsage=$(top -bn1 | awk '/Cpu/ { print $2}')
#echo "CPU Usage: $cpuUsage%"

# Check Load Average
loadaverage=$(top -n 1 -b | grep "load average:" | awk '{print $12}')
echo -e "Load Average : ${loadaverage%?}"

# Check RAM, SWAP and CACHE Usages
memUsage=$(free -m | awk '/Mem/{print $3}')
echo -e "Ram Usages : $memUsage MB"
memFree=$(free -m | awk '/Mem/{print $4}')
echo -e "Ram Free : $memFree MB"
buff=$(free -m | awk '/Mem/{print $6}')
echo -e "Buff/cache : $buff MB"

# Check Disk Usages
diskUsage=$(df -h| grep 'Filesystem\|/dev/vda1' > /tmp/diskusage)
echo -e "Disk Usages : $(cat /tmp/diskusage | awk '/dev/{print $5}')"

# Check System Uptime
uptime=$(uptime | awk '{print $3,$4}' | cut -f1 -d,)
echo -e "System Uptime Days/(HH:MM) : $uptime"

# Unset Variables
unset internalip loadaverage uptime diskUsage memFree memUsage buff

# Remove Temporary Files
rm /tmp/who /tmp/diskusage
