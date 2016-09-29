#!/bin/sh
#sed -i "s/192.168.8.61/192.168.8.61/g" `grep "192.168.8.61" -rl  .` 
#sed -i "s/192.168.0.110/192.168.8.61/g" `grep  "192.168.0.110" -rl  .|grep -v "sed.sh" `
sed -i "s/192.168.8.61/killinux.com/g" `grep  "192.168.8.61" -rl  .|grep -v "sed.sh" `
