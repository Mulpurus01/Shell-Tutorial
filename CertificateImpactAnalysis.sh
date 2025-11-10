#!/bin/bash 

echo ======================================================================================= 
echo "Started the Execution" 
echo ======================================================================================= 

# ====== Service credentials (Base64 encoded) ====== 
adapter_preprod_store_KEYSTORE_ENCODED='' 
adapter_preprod_store_TRUSTSTORE_ENCODED='' 
adapter_preprod_store_KEYSTORE_PASSWORD_ENCODED='SEFJTF9IWURSQQ' 
adapter_preprod_store_TRUSTSTORE_PASSWORD_ENCODED='SEFJTF9IWURSQQ' 

preprod_adaptor_store_KEYSTORE_ENCODED='' 
preprod_adaptor_store_TRUSTSTORE_ENCODED='' 
preprod_adaptor_store_KEYSTORE_PASSWORD_ENCODED='SEFJTF9IWURSQQ' 
preprod_adaptor_store_TRUSTSTORE_PASSWORD_ENCODED='SEFJTF9IWURSQQ' 
# =================================================== 

# ==========CERTI CHECK============================== 
SEARCH_CERTIFICATE1='CN=preprod-certificate1-name.com' 
SEARCH_CERTIFICATE2='CN=preprod-certificate2-name.com' 
# =================================================== 

#If Service name has '-'<hyphen> modify it to '_' <Underscore> script is failing if it has '-' 
SERVICES=('adapter_preprod_store' 'preprod_adaptor_store') 

TARGET_PATH="C:/Users/Keystore_Truststore/testGen"  

for SERVICE in "${SERVICES[@]}"; do 

echo ======================================================================================= 
echo "Processing $SERVICE" 
echo ======================================================================================= 

mkdir -p "$TARGET_PATH/$SERVICE"  

# Indirect expansion to get the right vars 
KEYSTORE_VAR="${SERVICE}_KEYSTORE_ENCODED" 
TRUSTSTORE_VAR="${SERVICE}_TRUSTSTORE_ENCODED" 
KEYSTORE_PASS_VAR="${SERVICE}_KEYSTORE_PASSWORD_ENCODED" 
TRUSTSTORE_PASS_VAR="${SERVICE}_TRUSTSTORE_PASSWORD_ENCODED" 

echo "${!KEYSTORE_VAR}" | base64 --decode > "$TARGET_PATH/$SERVICE/$SERVICE.jks" 
echo "${!TRUSTSTORE_VAR}" | base64 --decode > "$TARGET_PATH/$SERVICE/${SERVICE}-T.jks" 

KEYSTORE_STORE_PASS=$(echo "${!KEYSTORE_PASS_VAR}" | base64 --decode) 
TRUSTSTORE_STORE_PASS=$(echo "${!TRUSTSTORE_PASS_VAR}" | base64 --decode) 

keytool -list -v \ 
  -keystore "$TARGET_PATH/$SERVICE/$SERVICE.jks" \ 
  -storepass "$KEYSTORE_STORE_PASS" > "$TARGET_PATH/$SERVICE/${SERVICE}.txt"  

keytool -list -v \ 
  -keystore "$TARGET_PATH/$SERVICE/${SERVICE}-T.jks" \ 
  -storepass "$TRUSTSTORE_STORE_PASS" > "$TARGET_PATH/$SERVICE/${SERVICE}-T.txt" 

grep -i -B 5 -A 3 "OWNER.*${SEARCH_CERTIFICATE1}" "$TARGET_PATH/$SERVICE/${SERVICE}.txt" \ 
  --group-separator="===== Next occurrence =====" >> "${SERVICE}_CheckFile.txt" 

echo '><><><><><><>CERTIFICATE-2<><><><><><><' >> "${SERVICE}_CheckFile.txt" 

grep -i -B 5 -A 3 "OWNER.*${SEARCH_CERTIFICATE2}" "$TARGET_PATH/$SERVICE/${SERVICE}.txt" \ 
  --group-separator="===== Next occurrence =====" >> "${SERVICE}_CheckFile.txt" 

echo ======================================================================================= >> "${SERVICE}_CheckFile.txt" 
echo '                               STARTING THE TRUSTORE' >> "${SERVICE}_CheckFile.txt" 
echo ======================================================================================= >> "${SERVICE}_CheckFile.txt" 

grep -i -B 5 -A 3 "OWNER.*${SEARCH_CERTIFICATE1}" "$TARGET_PATH/$SERVICE/${SERVICE}-T.txt" \ 
  --group-separator="===== Next occurrence =====" >> "${SERVICE}_CheckFile.txt" 

echo '><><><><><><>CERTIFICATE-2<><><><><><><' >> "${SERVICE}_CheckFile.txt"  

grep -i -B 5 -A 3 "OWNER.*${SEARCH_CERTIFICATE2}" "$TARGET_PATH/$SERVICE/${SERVICE}-T.txt" \ 
  --group-separator="===== Next occurrence =====" >> "${SERVICE}_CheckFile.txt" 

done 
echo ======================================================================================= 
echo "All services processed." 
echo ======================================================================================= 
