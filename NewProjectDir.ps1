###################################################################
#      
#2014-02-28, V.00.00.01
#2016-04-12, V.00.01.00
#2016-04-13, V.01.00.00
#
# Powershell script to create project directories
# by Mathias Wiesbauer for the Dr. Sauer & Partners Corporation
# this script automatically assigns the correct access permissions
# to the directories
#
#############################################################
### PARAMETERS

Unblock-File -Path "C:\Windows\System32\WindowsPowerShell\v1.0\Modules\NTFSSecurity\NTFSSecurity.Init.ps1"

# LOCATION OF PROJECTS DIRECTORY ON FILE SERVER
$Drive = "D:\Projects" 


## FOLDER TEMPLATES FOR VARIOUS PROJECT TYPES
$Folders_D_C = @{
           "CAD" = "dr-sauer\Full Control - CAD";
           "Codes & Standards" = "dr-sauer\Full Control - Codes and Standards";
           "Design Management" = "dr-sauer\Full Control - Design Management";
           "Documents" = "dr-sauer\Full Control - Documents";
           "Mail in & Reference" = "dr-sauer\Full Control - Mail in and Reference";
           "QA QC" = "dr-sauer\Full Control - QA QC";
           "Submittals" = "dr-sauer\Full Control - Submittals";
           }

$Folders_E = @{                                
           "Documents" = "dr-sauer\Full Control - Execution";
           "Mail in & Reference" = "dr-sauer\Full Control - Execution";           
           "Submittals" = "dr-sauer\Full Control - Execution";
           }
#############################################################

function getProjectNumber
    {    
        $project_number = Read-Host "Please enter the project number (e.g. 123E) "
        return $project_number
    }

function getProjectName
    {    
        $project_name = Read-Host "Please enter the project name (e.g. Ottawa Light Rail) "
        return $project_name
    }

function getProjectCountry
    {    
        $project_country = Read-Host "Please enter the project country (e.g. Canada) "
        return $project_country
    }



## CHECK IF INPUT WAS RECEIVED
DO 
{
    $projectNumber = getProjectNumber
} While (!$projectNumber)
    
DO 
{
    $projectName = getProjectName
} While (!$projectName)


DO 
{
    $projectCountry = getProjectCountry
} While (!$projectCountry)



## CONCATENATE PATH TO CREATE DIRECTORIES
$Path = "$Drive\$projectCountry\$projectNumber - $projectName"

## GET PROJECT TYPE FROM PROJECT NUMBER
$projectType = $projectNumber[($projectNumber.Length - 3)*(-1)]


## ASSIGN FOLDER TEMPLATE BASED ON PROJECT TYPE
IF ($projectType -eq 'E') {
    $Folders = $Folders_E
}

IF ($projectType -eq 'C' -OR $projectType -eq 'D') {
    $Folders = $Folders_D_C
}


try{

    foreach ($Folder in $Folders.GetEnumerator()) {
        $Group = $Folders.Get_Item($Folder.Name)
        $Folder = "$Path\$($Folder.Name)"
    
        Write-Host $Folder
        Write-Host $Group
        new-item "$Folder" -ItemType directory
    
        Add-NTFSAccess -Path $folder -Account $Group -AccessRights FullControl               
    }
} catch {
    Write-Host("Projectnumber is incorrect, please verify : " + $projectNumber)
}
 