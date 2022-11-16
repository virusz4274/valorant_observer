import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restart_app/restart_app.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

var serverip = 'nodata';
var wsserverport = 'nodata';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.black,
        ),
        initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => const ConnectionPage(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/dashboard': (context) => const DashboardPage(),
          '/temporary': (context) => const TemporaryPage(),
        });
  }
}

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({Key? key}) : super(key: key);

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  final server_address_controller = TextEditingController();
  final server_port_controller = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    server_address_controller.dispose();
    server_port_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
                controller: server_address_controller,
                decoration: InputDecoration(
                    hintText: 'Server Address',
                    filled: true,
                    fillColor: Colors.grey[800]),
                keyboardType: TextInputType.number),
            TextField(
                controller: server_port_controller,
                decoration: InputDecoration(
                  hintText: 'Server Port',
                  filled: true,
                  fillColor: Colors.grey[800],
                ),
                keyboardType: TextInputType.number),
            TextButton(
                onPressed: () {
                  serverip = server_address_controller.text;
                  wsserverport = server_port_controller.text;
                  print('$serverip:$wsserverport');
                  final channel = WebSocketChannel.connect(
                    Uri.parse('ws://$serverip:$wsserverport'),
                  );
                  channel.sink.add('init');
                  channel.sink.close();
                  sleep(const Duration(seconds: 2));
                  //Navigator.push(
                  //  context,
                  //  MaterialPageRoute(
                  //      builder: (context) => const DashboardPage()),
                  // );
                  Navigator.popAndPushNamed(context, '/dashboard');
                },
                child: Text('Connect'))
          ],
        ),
      ),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    const scale_agent = 0.6;
    const scale_icon = 2.0;
    final server_address = '$serverip' + ':' + '8000';
    final ws_address = '$serverip' + ':' + '$wsserverport';
    final channel = WebSocketChannel.connect(
      Uri.parse('ws://10.0.0.231:4274'),
    );
    imageCache.clear();
    imageCache.clearLiveImages();
    return Scaffold(
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  channel.sink.add('Agent1');
                },
                child: Image.network(
                  'http://$server_address/Agents/agent1.png',
                  scale: scale_agent,
                ),
              ),
              GestureDetector(
                onTap: () {
                  channel.sink.add('Agent2');
                },
                child: Image.network(
                  'http://$server_address/Agents/agent2.png',
                  scale: scale_agent,
                ),
              ),
              GestureDetector(
                onTap: () {
                  channel.sink.add('Agent7');
                },
                child: Image.network(
                  'http://$server_address/Agents/agent7.png',
                  scale: scale_agent,
                ),
              ),
              GestureDetector(
                onTap: () {
                  channel.sink.add('Agent6');
                },
                child: Image.network(
                  'http://$server_address/Agents/agent6.png',
                  scale: scale_agent,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  channel.sink.add('Agent3');
                },
                child: Image.network(
                  'http://$server_address/Agents/agent3.png',
                  scale: scale_agent,
                ),
              ),
              GestureDetector(
                onTap: () {
                  channel.sink.add('Agent4');
                },
                child: Image.network(
                  'http://$server_address/Agents/agent4.png',
                  scale: scale_agent,
                ),
              ),
              GestureDetector(
                onTap: () {
                  channel.sink.add('Agent9');
                },
                child: Image.network(
                  'http://$server_address/Agents/agent9.png',
                  scale: scale_agent,
                ),
              ),
              GestureDetector(
                onTap: () {
                  channel.sink.add('Agent8');
                },
                child: Image.network(
                  'http://$server_address/Agents/agent8.png',
                  scale: scale_agent,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  channel.sink.add('Agent5');
                },
                child: Image.network(
                  'http://$server_address/Agents/agent5.png',
                  scale: scale_agent,
                ),
              ),
              GestureDetector(
                onTap: () {
                  channel.sink.add('Molly');
                },
                child: Image.asset(
                  'assets/icons/incendiary.png',
                  scale: scale_icon,
                  color: Colors.red,
                ),
              ),
              GestureDetector(
                onTap: () {
                  channel.sink.add('Cam');
                },
                child: Image.asset(
                  'assets/icons/camera.png',
                  scale: scale_icon,
                  color: Colors.red,
                ),
              ),
              GestureDetector(
                onTap: () {
                  channel.sink.add('Agent10');
                },
                child: Image.network(
                  'http://$server_address/Agents/agent10.png',
                  scale: scale_agent,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.popAndPushNamed(context, '/temporary');
                },
                child: Image.asset(
                  'assets/icons/settings_refresh.png',
                  scale: scale_icon,
                  color: Colors.red,
                ),
              ),
              GestureDetector(
                onTap: () {
                  channel.sink.add('Score');
                },
                child: Image.asset(
                  'assets/icons/score.png',
                  scale: scale_icon,
                  color: Colors.red,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Image.network(
                  'http://$server_address/Agents/agent1.png',
                  scale: scale_agent,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Image.network(
                  'http://$server_address/Agents/agent1.png',
                  scale: scale_agent,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
            width: 500,
            child: StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                return Text(
                  snapshot.hasData
                      ? 'Response from server : ${snapshot.data}'
                      : '',
                  style: TextStyle(fontSize: 8, color: Colors.white),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class TemporaryPage extends StatelessWidget {
  const TemporaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const scale_icon = 2.0;
    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                sleep(Duration(seconds: 2));
                Navigator.popAndPushNamed(context, '/dashboard');
              },
              child: Image.asset(
                'assets/icons/refresh.png',
                scale: scale_icon,
                color: Colors.red,
              ),
            ),
            GestureDetector(
              onTap: () {
                Restart.restartApp();
              },
              child: Image.asset(
                'assets/icons/score.png',
                scale: scale_icon,
                color: Colors.red,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/icons/download.png',
                scale: scale_icon,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
