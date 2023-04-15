import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restart_app/restart_app.dart';
import 'package:url_launcher/url_launcher.dart';

var serverAddress = '';

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
      title: 'Valorant Observer Dashboard',
      theme: ThemeData(
          primarySwatch: Colors.blue, scaffoldBackgroundColor: Colors.black),
      initialRoute: '/',
      routes: {
        '/': (context) => const ConnectionPage(),
        '/dashboard': (context) => const Dashboard(),
        '/settings': (context) => const SettingsPage()
      },
    );
  }
}

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({Key? key}) : super(key: key);

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  final serverAddressController = TextEditingController();
  final serverPortController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    serverAddressController.dispose();
    serverPortController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
                controller: serverAddressController,
                decoration: InputDecoration(
                    hintText: 'Server Address',
                    filled: true,
                    fillColor: Colors.grey[800]),
                keyboardType: TextInputType.number),
            TextField(
                controller: serverPortController,
                decoration: InputDecoration(
                  hintText: 'Server Port',
                  filled: true,
                  fillColor: Colors.grey[800],
                ),
                keyboardType: TextInputType.number),
            TextButton(
                onPressed: () {
                  serverAddress =
                      'http://${serverAddressController.text}${serverPortController.text}';
                  Navigator.popAndPushNamed(context, '/dashboard');
                },
                child: const Text('Connect'))
          ],
        ),
      ),
    );
  }
}

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var defenders;
  var attackers;
  var agent1Image = 'assets/agents/Astra_icon.webp';
  var agent2Image = 'assets/agents/Astra_icon.webp';
  var agent3Image = 'assets/agents/Astra_icon.webp';
  var agent4Image = 'assets/agents/Astra_icon.webp';
  var agent5Image = 'assets/agents/Astra_icon.webp';
  var agent6Image = 'assets/agents/Astra_icon.webp';
  var agent7Image = 'assets/agents/Astra_icon.webp';
  var agent8Image = 'assets/agents/Astra_icon.webp';
  var agent9Image = 'assets/agents/Astra_icon.webp';
  var agent10Image = 'assets/agents/Astra_icon.webp';
  String _data = '';

  Future<void> fetchAgents() async {
    final agentsUrl = Uri.parse('http://10.0.0.158:8000/agents');
    try {
      final response = await http.get(agentsUrl);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          defenders = data['defenders'];
          attackers = data['attackers'];
          assignAgentImage();
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        _data = 'Error: $e';
      });
    }
  }

  void assignAgentImage() {
    String agentImage = 'assets/agents/';
    agent1Image = '$agentImage${defenders['1']}_icon.webp';
    agent2Image = '$agentImage${defenders['2']}_icon.webp';
    agent3Image = '$agentImage${defenders['3']}_icon.webp';
    agent4Image = '$agentImage${defenders['4']}_icon.webp';
    agent5Image = '$agentImage${defenders['5']}_icon.webp';
    agent6Image = '$agentImage${attackers['1']}_icon.webp';
    agent7Image = '$agentImage${attackers['2']}_icon.webp';
    agent8Image = '$agentImage${attackers['3']}_icon.webp';
    agent9Image = '$agentImage${attackers['4']}_icon.webp';
    agent10Image = '$agentImage${attackers['5']}_icon.webp';
  }

  Future<void> switchAgents(String agent) async {
    final agentControlUrl = Uri.parse('http://10.0.0.158:8000/control/$agent');
    try {
      final response = await http.get(agentControlUrl);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      _data = 'Error: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    const scaleAgent = 1.2;
    const scaleIcon = 2.0;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () async {
                  await switchAgents('Agent1');
                },
                child: Image.asset(
                  agent1Image,
                  scale: scaleAgent,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await switchAgents('Agent2');
                },
                child: Image.asset(
                  agent2Image,
                  scale: scaleAgent,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await switchAgents('Agent7');
                },
                child: Image.asset(
                  agent7Image,
                  scale: scaleAgent,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await switchAgents('Agent6');
                },
                child: Image.asset(
                  agent6Image,
                  scale: scaleAgent,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () async {
                  await switchAgents('Agent3');
                },
                child: Image.asset(
                  agent3Image,
                  scale: scaleAgent,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await switchAgents('Agent4');
                },
                child: Image.asset(
                  agent4Image,
                  scale: scaleAgent,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await switchAgents('Agent9');
                },
                child: Image.asset(
                  agent9Image,
                  scale: scaleAgent,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await switchAgents('Agent8');
                },
                child: Image.asset(
                  agent8Image,
                  scale: scaleAgent,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () async {
                  await switchAgents('Agent5');
                },
                child: Image.asset(
                  agent5Image,
                  scale: scaleAgent,
                ),
              ),
              GestureDetector(
                onTap: () {
                  //channel.sink.add('Molly');
                },
                child: Image.asset(
                  'assets/icons/incendiary.png',
                  scale: scaleIcon,
                  color: Colors.red,
                ),
              ),
              GestureDetector(
                onTap: () {
                  //channel.sink.add('Cam');
                },
                child: Image.asset(
                  'assets/icons/camera.png',
                  scale: scaleIcon,
                  color: Colors.red,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await switchAgents('Agent10');
                },
                child: Image.asset(
                  agent10Image,
                  scale: scaleAgent,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  fetchAgents();
                  Future.delayed(const Duration(seconds: 2));
                  Navigator.pushNamed(context, '/settings');
                },
                child: Image.asset(
                  'assets/icons/settings_refresh.png',
                  scale: scaleIcon,
                  color: Colors.red,
                ),
              ),
              GestureDetector(
                onTap: () {
                  //channel.sink.add('Score');
                },
                child: Image.asset(
                  'assets/icons/score.png',
                  scale: scaleIcon,
                  color: Colors.red,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  'assets/icons/broken.png',
                  scale: scaleIcon,
                  color: Colors.red,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Image.asset(
                  'assets/icons/broken.png',
                  scale: scaleIcon,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    String _data = '';

    Future<void> initserver() async {
      final initUrl = Uri.parse('http://10.0.0.158:8000/init');
      try {
        final response = await http.get(initUrl);

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            _data = data['message'];
          });
        } else {
          throw Exception('Failed to load data');
        }
      } catch (e) {
        setState(() {
          _data = 'Error: $e';
        });
      }
    }

    const scaleIcon = 2.0;
    return Scaffold(
        body: Container(
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.red,
                      size: 90,
                    )),
                GestureDetector(
                  onTap: () async {
                    await initserver();
                    Future.delayed(const Duration(seconds: 2));
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    'assets/icons/refresh.png',
                    scale: scaleIcon,
                    color: Colors.red,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Restart.restartApp();
                  },
                  child: Image.asset(
                    'assets/icons/reboot.jpg',
                    scale: scaleIcon,
                    colorBlendMode: BlendMode.overlay,
                    color: Colors.red,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final Uri url = Uri.parse(
                        'https://github.com/virusz4274/valorant_observer');
                    if (!await launchUrl(url)) {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Image.asset(
                    'assets/icons/download.png',
                    scale: scaleIcon,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Text(
            'Developed by virusz4274, Powered by COARDE',
            style: TextStyle(fontSize: 12, color: Colors.white),
          ),
        ));
  }
}
