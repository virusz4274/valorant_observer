import os
#for virtual keypress
import pyautogui

#for finding local ip
import socket

#detect agent 
import detect

#server and fastapi
import uvicorn
from fastapi import FastAPI

allagents = {"defenders": [], "attackers": []}


def initdashboard():
    agents = detect.detectwithss()
    defenders = agents[0]
    attackers = agents[1]
    global allagents
    allagents = {"defenders": defenders, "attackers": attackers}
    print(allagents)
    return str(allagents)


app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Download the app from playstore","Link":"https://github.com/virusz4274/valorant_observer/releases"}


@app.get("/agents")
async def init():
    return allagents


@app.get("/init")
async def init():
    initdashboard()
    return {"message": "Dashboard initialized"}


@app.get("/control/{agent}")
async def control(agent: str):
    if agent == 'Agent1':
        pyautogui.press('1')
        print('Agent1')
    if agent == 'Agent2':
        pyautogui.press('2')
        print('Agent2')
    if agent == 'Agent3':
        pyautogui.press('3')
        print('Agent3')
    if agent == 'Agent4':
        pyautogui.press('4')
        print('Agent4')
    if agent == 'Agent5':
        pyautogui.press('5')
        print('Agent5')
    if agent == 'Agent6':
        pyautogui.press('6')
        print('Agent6')
    if agent == 'Agent7':
        pyautogui.press('7')
        print('Agent7')
    if agent == 'Agent8':
        pyautogui.press('8')
        print('Agent8')
    if agent == 'Agent9':
        pyautogui.press('9')
        print('Agent9')
    if agent == 'Agent10':
        pyautogui.press('0')
        print('Agent10')
    return {"message": "Switched to " + agent}


@app.get("/game/{action}")
async def game(action: str):
    if action == 'Molly':
        pyautogui.press('f')
        print('Molly')
    if action == 'Cam':
        pyautogui.press('=')
        print('Cam')
    if action == 'Score':
        with pyautogui.hold('tab'):
            pyautogui.sleep(seconds=2)
            print('Score')
    return {"message": "Done " + action}



if __name__ == "__main__":
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.connect(('8.8.8.8', 1))  # connect() for UDP doesn't send packets
    local_ip_address = s.getsockname()[0]
    print('''
    *********************************************************************************************************************
     VALORANT OBSERVER APP
     In case of any bugs file an issue in the github repository or contact telegram @virusz4274

     Use the following details to connect using app
    '''
    )
    print('     IP ADDRESS :', local_ip_address)
    print('     PORT : 4274')
    print('''
    *********************************************************************************************************************
    ''')
    if not os.path.exists('screenshots'):
        print('creating screenshots folder')
        os.makedirs('screenshots')
    uvicorn.run(app, host="0.0.0.0", port=4274, reload=False, log_level="debug",
                workers=1)