Add-DhcpServerv4Scope -Name "Administration" -StartRange "10.0.10.10" -EndRange "10.0.10.200" -SubnetMask "255.255.255.0" -State Active
Add-DhcpServerv4Scope -Name "DMZ" -StartRange "10.0.20.10" -EndRange "10.0.20.200" -SubnetMask "255.255.255.0" -State Active
Add-DhcpServerv4Scope -Name "Gestion" -StartRange "10.0.30.10" -EndRange "10.0.30.200" -SubnetMask "255.255.255.0" -State Active
Add-DhcpServerv4Scope -Name "Voix" -StartRange "10.0.40.10" -EndRange "10.0.40.200" -SubnetMask "255.255.255.0" -State Active﻿
Add-DhcpServerv4Scope -Name "Donnees" -StartRange "10.0.50.10" -EndRange "10.0.50.200" -SubnetMask "255.255.255.0" -State Active
Add-DhcpServerv4Scope -Name "Medical" -StartRange "10.0.60.10" -EndRange "10.0.60.200" -SubnetMask "255.255.255.0" -State Active
