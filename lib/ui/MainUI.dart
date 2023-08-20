import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:ville/widgets/inventory/PlayerInventory.dart';
import 'package:ville/widgets/main.dart';

class MainUI extends StatefulWidget {
  const MainUI({super.key});

  @override
  State<MainUI> createState() => _MainUIState();
}

class _MainUIState extends State<MainUI> {
  bool inventoryVisible = false;

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
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: PlayerInventory(
              visible: inventoryVisible,
              onClose: () {
                setState(() {
                  inventoryVisible = false;
                });
              },
            ),
          ),
        ),

        //====== [HUB] ======
        Positioned(
          left: 32,
          bottom: 106,
          child: EnergyBar(),
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
              onPressed: () {
                setState(() {
                  inventoryVisible = true;
                });
              },
            ),
          ),
        )
      ],
    );
  }
}
