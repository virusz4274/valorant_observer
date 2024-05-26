import 'package:flutter/material.dart';
import 'package:valo_overlay/agents.dart';

// Your Custom Widgets

class HealthBar extends StatelessWidget {
  final double width;
  final double height;
  final double currentValue;
  final double maxValue = 100;

  const HealthBar({
    super.key,
    required this.width,
    required this.height,
    required this.currentValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          //border: Border.all(color: Colors.grey, width: 2),
          color: Colors.black.withOpacity(0.5)
          //borderRadius: BorderRadius.circular(5),
          ),
      child: _buildInnerBar(),
    );
  }

  Widget _buildInnerBar() {
    double fillPercentage = (currentValue / maxValue).clamp(0.0, 1.0);

    return Row(
      children: [
        Container(
          width: width * fillPercentage,
          height: height,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 206, 18, 43),
            //borderRadius: BorderRadius.circular(5),
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }
}

class PlayerCard extends StatelessWidget {
  final ValorantAgent agent; // Receive the agent

  const PlayerCard({super.key, required this.agent}); // Constructor change

  Widget _buildAgentIcon() {
    return Positioned(
      height: 60,
      width: 60,
      child: agent.agentIcon,
    );
  }

  Widget _buildAbilityIcon(Image iconImage, double leftOffset) {
    return Positioned(
      width: 30,
      height: 30,
      left: leftOffset,
      child: iconImage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          // Player Card Background
          height: 90,
          width: 312,
          child: Container(color: Colors.blue.withOpacity(1)),
        ),

        // Agent Icon
        _buildAgentIcon(),

        // Ability Icons Section
        Positioned(
          left: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildAbilityIcon(agent.abilityCIcon, 0.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.circle_rounded, size: 10, color: Colors.white),
                  Icon(Icons.circle_rounded, size: 10, color: Colors.white),
                ],
              ),
            ],
          ),
        ),

        // Other Abilities
        _buildAbilityIcon(agent.abilityQIcon, 120.0),
        _buildAbilityIcon(agent.abilityEIcon, 180.0),

        // Health Bar
        const Positioned(
          top: 54,
          child: HealthBar(width: 312, height: 6, currentValue: 50),
        ),

        // Player Name
        Positioned(
          top: 65,
          child: Container(
            height: 15,
            width: 100,
            padding: const EdgeInsets.only(left: 5),
            child: const Text(
              'VIRUSZ4274',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
