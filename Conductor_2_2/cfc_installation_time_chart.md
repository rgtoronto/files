#### installation time comparison result

-------------------------------
cfc\OS | X86 Ubuntu 16.04 | X86 RHEL 7.2 | ppc64le Ubuntu 16.04 | ppc64le RHEL 7.2
------------ | -------------|-----|-----|----
cfc 0.2.0  | | | |15m10s  | 
cfc 0.3.0 daily build | | | |15m30s
cfc 0.3.0  | 
cfc 0.4.0 rc |  23 minutes, 30 seconds | | |14 minutes, 46 seconds

--------------------

#### Note:
###### installation time for cfc 0.2.0 env on ppc64le
    [master]
    9.37.234.112
    
    [worker]
    9.37.234.113
    9.37.234.115
    9.37.234.114
    
    [proxy]
    9.37.234.112
 
###### installation time for cfc 0.4.0 env 
    [master]
    9.21.58.86
    
    [worker]
    9.21.58.23
    
    [proxy]
    9.21.58.86