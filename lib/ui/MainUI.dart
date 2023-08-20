import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ville/widgets/inventory/PlayerInventory.dart';

class MainUI extends StatefulWidget {
  const MainUI({super.key});

  @override
  State<MainUI> createState() => _MainUIState();
}

class _MainUIState extends State<MainUI> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //====== [MODAL] ======
        //INVENTORY MODAL
        const Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: PlayerInventory(),
          ),
        ),

        //====== [ACTION BUTTONS] ======
        //INVENTORY BUTTON
        Positioned(
          bottom: 18,
          right: 18,
          child: Container(
            width: 96,
            height: 96,
            child: ElevatedButton(
              child: Transform.scale(
                scale: 3.6,
                child: SpriteWidget.asset(
                  path: "ui/ui.png",
                  srcPosition: Vector2(128, 410),
                  srcSize: Vector2(8, 16),
                ),
              ),
              onPressed: () {},
            ),
          ),
        )
      ],
    );
  }
}
