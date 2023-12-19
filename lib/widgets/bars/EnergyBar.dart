import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ville/config/Config.dart';

class EnergyBar extends StatelessWidget {
  const EnergyBar({ super.key, this.value = 0 });

  final int value;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Transform.scale(
        scale: 4.2,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: SpriteWidget.asset(
                path: "ui/ui.png",
                srcPosition: Vector2(256, 408),
                srcSize: Vector2(12, 56),
              ),
            ),
            Positioned(
              left: 3,
              bottom: 2,
              child: Container(
                width: 6,
                height: (value * 42) / Config.PLAYER_MAX_ENERGY, // 42 is 100%
                color: const Color.fromRGBO(24, 225, 68, .6),
              )
            )
          ],
        )
      ),
    );
  }
}