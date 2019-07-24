#!/bin/bash
# Path to netcat
NC="/bin/nc"
# Where are we sending messages from / to?
#ORIG_IP="192.168.190.11"
SOURCES=("192.168.190.2" "192.168.190.3" "192.168.190.4" "192.168.190.5" "192.168.190.6" "192.168.190.7")
#Destination network
DEST_IP="192.168.190.11"
# List of messages.
MESSAGES=("Error Event" "Warning Event" "Info Event")
# How long to wait in between sending messages.
SLEEP_SECS=1
# How many message to send at a time.
COUNT=1

FACILITIES=("kernel" "user" "mail" "system" "security" "syslog" "lpd" "nntp" "uucp" "time" "ftpd" "ntpd" "logaudit")
LEVELS=("emergency" "alert" "critical" "error" "warning" "notice" "info" "debug")
PRIORITIES=(0 1 2 3 4 5 6 7)

while [ 1 ]
do
	for i in $(seq 1 $COUNT)
	do
		# Picks a random syslog message from the list.
		RANDOM_MESSAGE=${MESSAGES[$RANDOM % ${#MESSAGES[@]} ]}
		PRIORITY=${PRIORITIES[$RANDOM % ${#PRIORITIES[@]} ]}
		SOURCE=${SOURCES[$RANDOM % ${#SOURCES[@]} ]}
		FACILITY=${FACILITIES[$RANDOM % ${#FACILITIES[@]} ]}
		LEVEL=${LEVELS[$RANDOM % ${#LEVELS[@]} ]}

			$NC $DEST_IP.11 -u 514 -w 1 <<< "<$PRIORITY>`env LANG=us_US.UTF-8 date "+%b %d %H:%M:%S"` $SOURCE [$FACILITY.$LEVEL] service: $RANDOM_MESSAGE"
			#echo $NC $DEST_IP.11 -u 514 -w 1  "<$PRIORITY>`env LANG=us_US.UTF-8 date "+%b %d %H:%M:%S"` $SOURCE service: $RANDOM_MESSAGE"

	done
	sleep $SLEEP_SECS
done
