#!/bin/bash

sudo networksetup -removepreferredwirelessnetwork en0 CORP_net 
sudo networksetup -setairportpower en0 off