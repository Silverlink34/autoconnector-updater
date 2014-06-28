;AutoConnector Updater by Brandon
;This program is the updater for AutoConnector.
;Parameters for the script listed here
#SingleInstance, Force ;if the script is ran and it was already running, this will cause it to reload itself.
#NoTrayIcon ;Kinda self explanatory.
#NoEnv ;supposed to make compatibility better
;Set working directory to AutoConnector's directory
fileread,acdir,%a_mydocuments%\AutoConnector\updater\autoconnectordir
filedelete,%a_mydocuments%\AutoConnector\updater\autoconnectordir
SetWorkingDir %acdir%

;Update and progressbar starts here
Progress,show,Downloading AutoConnector from source..,Updating AutoConnector
sleep,2000
Progress,10
urldownloadtofile,https://github.com/Silverlink34/autoconnector/archive/master.zip, %a_mydocuments%\AutoConnector\updater\
sleep, 5000
progress,20,Extracting source...
run, %a_mydocuments%\autoconnector\programbin\unzip.exe %a_mydocuments%\AutoConnector\updater\autoconnector-master.zip
msgbox, go check the dir
exit



