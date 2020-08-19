# aci_fault_cleaner
Cisco ACI faults batch delete tool
```bash
0.      Login root uesr.
1.      enable_testapi.bin 3600                                                         //enable testapi
2.      ./del.sh -s F1321                                                               //Search ALL F1321 faults
3.      ./del.sh -d F1321                                                               //DELETE ALL F1321 Fault
4.      ./del.sh -o \"topology/pod-1/node-102/sys/ch/ftslot-1/ft/fault-F1321\"          //Delete ONE specific dn fault
```
