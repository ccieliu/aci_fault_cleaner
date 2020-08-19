#!/bin/bash
# ------------------------------------------------------------------
# @yuxuliu@cisco.com 'faultInst' delete tool.
# Delete fault depend on "Fault ID"
# Version: 1.2
# ------------------------------------------------------------------

if [[ "$1" == "-h" || "$1" == "" ]]  ;then
  echo """
0.      Login root uesr.
1.      enable_testapi.bin 3600                                                         //enable testapi
2.      ./del.sh -s F1321                                                               //Search ALL F1321 faults
3.      ./del.sh -d F1321                                                               //DELETE ALL F1321 Fault
4.      ./del.sh -o \"topology/pod-1/node-102/sys/ch/ftslot-1/ft/fault-F1321\"          //Delete ONE specific dn fault
"""
elif [ "$1" == "-s" ]; then
  echo ""
  moquery -c faultInst -f 'fault.Inst.code=="'$2'"' | grep -E "dn" |  awk '{print $3}'
  echo ""
elif [ "$1" == "-o" ]; then
  echo -e "\nDelete ONE fault 'dn'= \""$2\" \?\?\?
  read -p "Confirm action? [N/y]: " confirm
  case $confirm in
    [yY])
    icurl -X POST http://localhost:7777/testapi/mo/.xml -d '<faultInst dn="'$2'" status="deleted" />'
    echo -e "\nDONE!\n";;
    *)
    echo -e "\nCanceled! THINKING BEFORE DOING!\n";;
esac
elif [ "$1" == "-d" ]; then
  echo -e "\nDelete ALL fault 'id'= \""$2\" \?\?\?
  read -p "Confirm action? [N/y]: " confirm
  case $confirm in
    [yY])
          for i in `moquery -c faultInst -f 'fault.Inst.code=="'$2'"' | grep -E "dn" |  awk '{print $3}'`
          do
                icurl -X POST http://localhost:7777/testapi/mo/.xml -d '<faultInst dn="'$i'" status="deleted" />'
          done
          echo -e "\nDONE!\n";;
    *)
    echo -e "\nCanceled! THINKING BEFORE DOING!\n";;
  esac
fi