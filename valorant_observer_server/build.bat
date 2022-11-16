@ECHO OFF 
pipenv shell
ECHO installing dependency
pipenv install
pyinstaller --onefile .\valorant_observe.py
pyinstaller --onefile .\server.py