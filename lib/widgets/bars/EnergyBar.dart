import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';

class EnergyBar extends StatefulWidget {
  const EnergyBar({ super.key });

  @override
  State<EnergyBar> createState() => _EnergyBar();
}

class _EnergyBar extends State<EnergyBar> {
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
                height: 42, // 42 is 100%
                color: const Color.fromRGBO(24, 225, 68, .6),
              )
            )
          ],
        )
      ),
    );
  }
}