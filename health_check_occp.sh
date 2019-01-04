#!/bin/bash

dateTime=$(date   +"%Y-%m-%d_%H_%M_%S")

LOG=~/health_reports/`hostname`-health_check-$dateTime.log

echo "***** Health Check Report for $HOSTNAME at $dateTime *****" >> $LOG
echo -e "\t\t\t\t ***** SCTP Associations *****" >> $LOG
echo -e "\t\t\t\t =============================" >> $LOG
netstat -an|grep sctp >> $LOG
echo -e "\t\t\t\t ***** VoLTE GW log *****" >> $LOG
echo -e "\t\t\t\t ========================" >> $LOG
tail -n 10 /opt/voltegw/log/voltegw.log >> $LOG
echo -e "\t\t\t\t ***** Server.log *****" >> $LOG
echo -e "\t\t\t\t ======================" >> $LOG
tail -n 10 /var/opt/OC/hpoc-see/wildfly/server/see-1/log/server.log >> $LOG
echo -e "\t\t\t\t ***** PMON Status *****" >> $LOG
echo -e "\t\t\t\t =======================" >> $LOG
sudo /opt/OC/bin/pmon status >> $LOG
echo -e "\t\t\t\t ***** Latest CDRs *****" >> $LOG
echo -e "\t\t\t\t =======================" >> $LOG
sudo /bin/ls -lrt /var/opt/OC/FSC/CDR | tail >> $LOG
echo "*************** END of Health Check Report for $HOSTNAME ***************" >> $LOG
scp $LOG venkat@10.194.114.38:~/reports
		
