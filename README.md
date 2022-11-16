# valorant_observer

This repository container two items the dasboard app is a flutter based app which will work on Android and iOS 
the server app is a python based application

# GUIDE

* Download the apk and server.zip 
* Install apk
* Unzip the server.zip to your desired location
* Run app.exe and server.exe ( Both should be running in order to work, Give firewall access to both app.exe and server.exe make sure that private and public is ticked )
* Open the dashboard App in mobile 
* Enter the IP Address shown in app.exe console to Server Address field
* Enter the PORT shown in app.exe console to Server Port field
* Open your valorant custom game and make sure that you are in the buy phase ( time before the round starts )
* Tap on connect
* If agents are not loaded properly follow the Refresh / Restart Instruction
* Tap on buttons and you can see it working, if not working make sure window focus is on valorant ( alt + tab to valorant )

### Refresh / Restart Dashboard Mobile App

* On the dasboard at left bottom there is a settings button tap on that  
* to refresh tap on refresh button ( 1st button )
* to restart app tap on restart button ( 2nd button )


# ISSUES

Create an issue here in github, or contact me through telegram @virusz4274

# BUILD


## Mobile App ( valorant_observer_dashboard )

### Dependency
[Flutter](https://docs.flutter.dev/get-started/install)

```
cd valorant_observer_dashboard
flutter pub get
flutter build apk
```

## Server App ( valorant_observer_server )

### Dependency

* [Python](https://www.python.org/downloads/)
* [pip](https://pip.pypa.io/en/stable/cli/pip_install/)
* [pipenv](https://pypi.org/project/pipenv/)

#### These Dependencies will be automatically installed upon running below build.bat command

* [pyinstaller](https://pypi.org/project/pyinstaller/)
* [PyAutoGUI](https://pypi.org/project/PyAutoGUI/)
* [websockets](https://pypi.org/project/websockets/)
* [Pillow](https://pypi.org/project/Pillow/)


```
cd valorant_observer_server
./build.bat
```

