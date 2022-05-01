arcname=$(uname -a)
cpuP=$(nproc)
cpuV=$(grep processor /proc/cpuinfo | wc -l)
Memory=$(free -m | grep "Mem:" | awk '{printf("%d/%dMB (%.2f%%)", $3, $2, ($3 * 100 / $2))}')
Disk_usage=$(df -h --total | grep "total" | awk '{printf("%.1f/%.1fGB (%.2d%%)", $3, $2, $5)}')
CpuL=$(top -bn1 | grep '^%Cpu' | cut -c 9- | xargs | awk '{printf("%.1f%%"), $1 + $3}')
LastReboot=$(who -b | awk '{print($3, $4)}')
lvmt=$(lsblk | grep "lvm" | wc -l)
lvmu=$(if [ $lvmt -eq 0 ]; then echo no; else echo yes; fi)
ctcp=$(ss -s | grep "TCP:" | awk '{print $2}')
ulog=$(users | wc -w)
ip=$(hostname -I)
mac=$(ip a | grep "ether" | awk '{print "("$2")"}')
cmds=$(cat /var/log/sudo/sudo.log | grep "COMMAND" | wc -l)
echo "#Arcitecture: $arcname"
echo "#CPU physical : $cpuP"
echo "#vCPU : $cpuV"
echo "#Memory Usage: $Memory"
echo "#Disk Usage $Disk_usage"
echo "#CPU load: $CpuL"
echo "#Last boot: $LastReboot"
echo "#LVM use: $lvmu"
echo "#Connexions TCP: $ctcp ESTABLISHED"
echo "#User log: $ulog"
echo "#Network: IP $ip ($mac)"
echo "#Sudo: $cmds cmd"