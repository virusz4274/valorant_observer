import 'package:flutter/material.dart';
import 'package:valo_overlay/agents.dart';
import 'package:valo_overlay/elements.dart';

void main() {
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ValorantAgent clove = ValorantAgent(
      name: 'Clove',
      agentIcon: Image.asset('Game_Assets/agents/Clove/Clove_icon.png'),
      ultimateName: 'NOT DEAD YET',
      ultimateIcon: Image.asset(
        'Game_Assets/agents/Clove/Not_Dead_Yet.png',
        height: 20,
        width: 20,
      ),
      ultimatePoints: 7,
      abilityCName: 'PICK-ME-UP',
      abilityCIcon: Image.asset(
        'Game_Assets/agents/Clove/Pick-me-up.png',
        height: 40,
        width: 40,
      ),
      abilityCMaxCharges: 1,
      abilityQName: 'MEDDLE',
      abilityQIcon: Image.asset('Game_Assets/agents/Clove/Meddle.png'),
      abilityQMaxCharges: 1,
      abilityEName: 'RUSE',
      abilityEIcon: Image.asset('Game_Assets/agents/Clove/Ruse.png'),
      abilityEMaxCharges: 2);

  PlayerCard player1 = PlayerCard(
      agent: ValorantAgent(
          name: 'Clove',
          agentIcon: Image.asset('Game_Assets/agents/Clove/Clove_icon.png'),
          ultimateName: 'NOT DEAD YET',
          ultimateIcon: Image.asset(
            'Game_Assets/agents/Clove/Not_Dead_Yet.png',
            height: 20,
            width: 20,
          ),
          ultimatePoints: 7,
          abilityCName: 'PICK-ME-UP',
          abilityCIcon: Image.asset(
            'Game_Assets/agents/Clove/Pick-me-up.png',
            height: 40,
            width: 40,
          ),
          abilityCMaxCharges: 1,
          abilityQName: 'MEDDLE',
          abilityQIcon: Image.asset('Game_Assets/agents/Clove/Meddle.png'),
          abilityQMaxCharges: 1,
          abilityEName: 'RUSE',
          abilityEIcon: Image.asset('Game_Assets/agents/Clove/Ruse.png'),
          abilityEMaxCharges: 2));
  int _counter = 0;
  void _setagent() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        body: Column(
          children: [
            Expanded(child: Container()),
            Expanded(
                child: Container(
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //player1,
                            Container(
                              color: Colors.green,
                              height: 90,
                              width: 312,
                              child: player1,
                            ),
                          ],
                        ),
                      )),
                  Flexible(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              color: Colors.red,
                              height: 90,
                              width: 312,
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
