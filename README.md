# DSP-Powershell-Scripts


## NewProjectDir.ps1
### Setup
1. This script requires _[File System Security PowerShell Module 4.2.1](https://gallery.technet.microsoft.com/scriptcenter/1abd77a5-9c0b-4a2b-acef-90dbb2b84e85)_ or greater.
2. Copy the downloaded ZIP to the Powershell modules Path (e.g. _C:\Windows\System32\WindowsPowerShell\v1.0\Modules_)
3. Unblock the *.DLLs in the Modules Directory 
4. Adjust the Execution Policy for Powershell to allow the execution of the script.
5. Adjust the _powershell_ise.exe.config_ located in _C:\Windows\System32\WindowsPowerShell\v1.0_ as follows

```xml
<?xml version="1.0"?>
     <configuration>
          <startup useLegacyV2RuntimeActivationPolicy="true">
                <supportedruntime version="v4.0.30319"/>
                <supportedruntime version="v2.0.50727"/>
          </startup>
          <runtime>
                <loadfromremotesources enabled="true"/>
          </runtime>
</configuration>
```

### How to Use
The powershell script will create a Project directory including predetermined subfolders, and set the permissions on the subfolders based on the configuration within the file.



