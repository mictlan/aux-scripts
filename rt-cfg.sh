#!/bin/sh
#
# cuantos cpus
CPUS="0 1 2 3"

# load mod for firewire1
modprobe raw1394

# dar prioridades alto a hilos 
# de la sistema relacionados con audio

for cpu in ${CPUS}
do 

	# hrtimer
	chrt -f -p 95 $(pgrep sirq-hrtimer/${cpu})
	
	# timer
	chrt -f -p 93 $(pgrep sirq-timer/${cpu})
	
	# sched 
	chrt -f -p 90 $(pgrep sirq-sched/${cpu})
	
	# tasklet
	chrt -f -p 91 $(pgrep sirq-tasklet/${cpu})

done

# reloj
chrt -f -p 88 $(pgrep irq/8-rtc0)
	
	
# firewire2
# chrt -f -p 86 $(pgrep irq/16-firewire)

# firewwire1
chrt -f -p 86 $(pgrep irq/16-ohci1394)

# usb izquierda
chrt -f -p 86 $(pgrep irq/16-ehci_hcd)

# fix perms firewire2
#chgrp audio /dev/fw1
#chmod g+rw /dev/fw1


