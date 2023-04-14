#websocket dependencies
import asyncio
import websockets

#for virtual keypress
import pyautogui

#for finding local ip
import socket


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


s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
s.connect(('8.8.8.8', 1))  # connect() for UDP doesn't send packets
local_ip_address = s.getsockname()[0]
print(
    'In case of any bugs file an issue in the github repository or contact telegram @virusz4274 '
)
print('Use the following details to connect using app')
print('IP ADDRESS :', local_ip_address)
print('PORT : 4274')

#start websocket
asyncio.run(main())