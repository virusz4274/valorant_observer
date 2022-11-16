@ECHO OFF 
pipenv shell
ECHO installing dependency
pipenv install
pyinstaller --onefile .\app.py
pyinstaller --onefile .\server.py