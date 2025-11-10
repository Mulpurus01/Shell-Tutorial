##This code is used to download the Environment properties of given secure-credential-broker in specified PCF ORG & Space in JSON format.

## Extension .bat 

@echo off 
setlocal enabledelayedexpansion 

REM Org and space names 
set "ORG_NAME=B2BDMCAT" 
set "SPACE_NAME=preprod" 

REM List of services (space-separated) 
set SERVICES=aria-credentials-credhub mysql-credhub-preprod 

REM Target CF org/space 
cf target -o %ORG_NAME% -s %SPACE_NAME% 

for %%S in (%SERVICES%) do ( 
    echo Generating Backup for %%S 
    for /f "usebackq tokens=*" %%G in (`cf service %%S --guid`) do set "SERVICE_GUID=%%G" 
    cf curl /v3/service_instances/!SERVICE_GUID!/parameters > %%S-Backup.json 
    echo Completed Backup for %%S 
) 

echo ---------------------------------------------- 
echo Back Up Generation Completed 
echo ---------------------------------------------- 
echo HAIL HYDRA 
endlocal 

============================================================================================== 
## Extension .bat Have the JQ Exe in the folder in which this script is present 
## JQ Exe is downloaded from internet and used, JQ helps in character encoding properly

@echo off 
setlocal enabledelayedexpansion 

REM Org and space names 
set "ORG_NAME=BFF-MICROSERVICES" 
set "SPACE_NAME=preprod" 

REM List of services (space-separated) 
set SERVICES=preprod_cs_microservice_1 preprod_cs_microservice_2  

REM Target CF org/space 
cf target -o %ORG_NAME% -s %SPACE_NAME% 

for %%S in (%SERVICES%) do ( 
    echo Generating Backup for %%S 
    for /f "usebackq tokens=*" %%G in (`cf service %%S --guid`) do set "SERVICE_GUID=%%G" 
    cf curl /v3/service_instances/!SERVICE_GUID!/parameters | jq -c . > %%S-Backup.json 
) 

echo ---------------------------------------------- 
echo Back Up Generation Completed 
echo ---------------------------------------------- 
echo HAIL HYDRA 
endlocal 
