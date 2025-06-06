@echo off
cd C:\Users\ACER\Documents\onedrive\Desktop\practice

if %errorlevel% neq 0 (
     Failed
     pause
)
echo Building power builder application...
"C:\Users\ACER\Documents\onedrive\Desktop\practice\pbautobuild220.exe" /f "C:\Users\ACER\Documents\onedrive\Desktop\practice\genapp.json"
if %errorlevel% neq 0 (
     echo power bulider Build failed!
     pause
)
echo Build Successful. moving app.exe to deployment folder Deploying...
Xcopy "C:\Users\ACER\Documents\onedrive\Desktop\practice\genapp.exe" "C:\Users\ACER\Documents\onedrive\Desktop\practice\DP" /Y
Xcopy "C:\Users\ACER\Documents\onedrive\Desktop\practice\genapp.pbd" "C:\Users\ACER\Documents\onedrive\Desktop\practice\DP" /Y
echo Deployment complete!
if %errorlevel% neq 0 (
      echo power builder deployment failed!
      pause
)  