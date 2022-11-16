#pillow for image manipulation
from PIL import Image
import PIL.ImageGrab

#websocket dependencies
import asyncio
import websockets

#for virtual keypress
import pyautogui

#for finding local ip
import socket

#for creating directory
import os

def initdashboard():
    #takes screenshot of monitor 1
    screenshot = PIL.ImageGrab.grab()
    screenshot_save_path = 'valorant.png'
    screenshot.save(screenshot_save_path)

    
    valorant = Image.open(r"valorant.png")
    # Size of the image in pixels (size of original image)
    #will use these to support higher and lower resolution 
    # supports 1080p monitors only
    width, height = valorant.size

    top = 29
    bottom = 71

    # Setting the points for cropped image
    agent1 = valorant.crop((445, top, 487, bottom))
    agent2 = valorant.crop((510, top, 552, bottom))
    agent3 = valorant.crop((576, top, 618, bottom))
    agent4 = valorant.crop((644, top, 686, bottom))
    agent5 = valorant.crop((708, top, 750, bottom))

    agent6 = valorant.crop((1172, top, 1214, bottom))
    agent7 = valorant.crop((1238, top, 1280, bottom))
    agent8 = valorant.crop((1302, top, 1344, bottom))
    agent9 = valorant.crop((1368, top, 1410, bottom))
    agent10 = valorant.crop((1436, top, 1478, bottom))

    # saving cropped images into Agents folder
    agents = [agent1, agent2, agent3, agent4, agent5, agent6, agent7, agent8, agent9, agent10]
    count =1
    for agent in agents:
        agent.save('Agents/agent'+ str(count) +'.png','PNG')
        count+=1



async def check(websocket):
    async for message in websocket:
        print(message)
        if message == 'init':
            initdashboard()
            await websocket.send('initialized')
        if message == 'Agent1':
            pyautogui.press('1')
            await websocket.send('Key 1 Pressed')
        if message == 'Agent2':
            pyautogui.press('2')
            await websocket.send('Key 2 Pressed')
        if message == 'Agent3':
            pyautogui.press('3')
            await websocket.send('Key 3 Pressed')
        if message == 'Agent4':
            pyautogui.press('4')
            await websocket.send('Key 4 Pressed')
        if message == 'Agent5':
            pyautogui.press('5')
            await websocket.send('Key 5 Pressed')
        if message == 'Agent6':
            pyautogui.press('6')
            await websocket.send('Key 6 Pressed')
        if message == 'Agent7':
            pyautogui.press('7')
            await websocket.send('Key 7 Pressed')
        if message == 'Agent8':
            pyautogui.press('8')
            await websocket.send('Key 8 Pressed')
        if message == 'Agent9':
            pyautogui.press('9')
            await websocket.send('Key 9 Pressed')
        if message == 'Agent10':
            pyautogui.press('0')
            await websocket.send('Key 0 Pressed')
        if message == 'Molly':
            pyautogui.press('f')
            await websocket.send('Key F Pressed')
        if message == 'Cam':
            pyautogui.press('=')
            await websocket.send('Key = Pressed')
        if message == 'Score':
            with pyautogui.hold('tab'):
                pyautogui.sleep(seconds=2)
        if message == 'switch-sides':
            #needs to implement
            await websocket.send('unimplemented')
        #else:
        #    await websocket.send(message)
        

async def main():
    async with websockets.serve(check, "0.0.0.0", 4274):
        await asyncio.Future()  # run forever

#checking for folder and creating one if it doesnt exists
if not os.path.exists('Agents'):
    print('creating Agents folder')
    os.makedirs('Agents')

s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.connect(('8.8.8.8', 1))  # connect() for UDP doesn't send packets
local_ip_address = s.getsockname()[0]
print('In case of any bugs file an issue in the github repository or contact @virusz4274 ')
print('Use the following details to connect using app')
print('IP ADDRESS :',local_ip_address)
print('PORT : 4274')

#start websocket 
asyncio.run(main())