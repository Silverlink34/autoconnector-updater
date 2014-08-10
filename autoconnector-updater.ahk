;AutoConnector Updater by Brandon
;This program is the updater for AutoConnector.
;Parameters for the script listed here
#SingleInstance, Force ;if the script is ran and it was already running, this will cause it to reload itself.
#NoTrayIcon ;Kinda self explanatory.
#NoEnv ;supposed to make compatibility better
;Set working directory to AutoConnector's directory
fileread,acdir,%a_mydocuments%\AutoConnector\updater\autoconnectordir
filedelete,%a_mydocuments%\AutoConnector\updater\autoconnectordir

;Update and progressbar starts here
startupdate:
Progress,10,Downloading AutoConnector from source..,Updating AutoConnector
filedelete, %a_mydocuments%\AutoConnector\updater\autoconnector-master.zip
fileremovedir, %a_mydocuments%\AutoConnector\updater\autoconnector-master, 1
urldownloadtofile,https://github.com/Silverlink34/autoconnector/archive/master.zip, %a_mydocuments%\AutoConnector\updater\autoconnector-master.zip
if errorlevel
{	
	if retryupdate = 1
	{
		progress,off
		msgbox, Update failed. Running AutoConnector out-of-date.
		fileappend,1,%a_mydocuments%\AutoConnector\updater\updatefailed
		run, %acdir%\autoconnector.ahk
		exitapp
	}
	else
	{
		progress,off
		msgbox, There was a problem downloading update. Trying 1 more time..
		retryupdate = 1
		gosub startupdate
	}
}
progress,50,Extracting source...
runwait, %comspec% /c %a_mydocuments%\autoconnector\programbin\7za x %a_mydocuments%\autoconnector\updater\autoconnector-master.zip -o%a_mydocuments%\autoconnector\updater\autoconnector autoconnector -r -aoa,hide
sleep, 1000
msgbox, %acdir%
ifnotexist %a_mydocuments%\AutoConnector\updater\autoconnector
	gosub extractfailed
progress,70,Killing AutoConnector.exe if open..
Process,close,AutoConnector.exe*
progress,75,Installing...
filedelete,%acdir%\autoconnector.exe
filemove,%a_mydocuments%\AutoConnector\updater\autoconnector\autoconnector-master\AutoConnector\AutoConnector.exe,%acdir%
progress,100,Install Complete. Running updated AutoConnector.
sleep, 3000
progress, off
msgbox
run, %acdir%\autoconnector.exe
exitapp
extractfailed:
progress, off
msgbox, extract failed.
exit

