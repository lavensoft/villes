import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:ville/api/main.dart';
import 'package:ville/api/store/UserStore.dart';
import 'package:ville/config/Config.dart';
import 'package:ville/models/main.dart';
import 'package:ville/widgets/artist/ArtContentCreate.dart';
import 'package:ville/widgets/inventory/PlayerInventory.dart';
import 'package:ville/widgets/main.dart';

class MainUI extends StatefulWidget {
  const MainUI({ super.key, this.onSpawnBuildObject, this.player, this.onNFTCreate });

  final Function? onSpawnBuildObject;
  final MPlayer? player;
  final Function? onNFTCreate;

  @override
  State<MainUI> createState() => _MainUIState();
}

class _MainUIState extends State<MainUI> {
  bool inventoryVisible = false;
  bool marketVisible = false;
  bool artCreateVisible = false;
  var stakeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PieCanvas(
      child: Stack(
        children: [
          //====== [MODAL] ======
          //INVENTORY MODAL
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: inventoryVisible ? PlayerInventory(
                onClose: () {
                  setState(() {
                    inventoryVisible = false;
                  });
                },
                onSpawnBuildObject: (item) {
                  widget.onSpawnBuildObject!(item);
                },
              ) : null,
            ),
          ),

          //MARKET MODAL
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: marketVisible ? MarketPlace(
                onClose: () {
                  setState(() {
                    marketVisible = false;
                  });
                },
              ) : null,
            ),
          ),

          //NFT CREATE MODAL
          Positioned.fill(
            child:Align(
              child: artCreateVisible ? ArtContentCreate(
                onCreate: () => widget.onNFTCreate!(),
                onClose: () {
                  setState(() {
                    artCreateVisible = false;
                  });
                },
              ) : null,
            )
          ),

          //====== [HUD] ======
          Positioned(
            left: 32,
            bottom: 106,
            child: EnergyBar(
              value: widget.player?.stats?.energy ?? 0
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
                onPressed: () {
                  setState(() {
                    inventoryVisible = true;
                  });
                },
              ),
            ),
          ),

          //Shop button
          Positioned(
            bottom: 18,
            right: 124,
            child: Container(
              width: 63,
              height: 63,
              child: ElevatedButton(
                child: Transform.scale(
                  scale: 2.4,
                  child: SpriteWidget.asset(
                    path: "ui/ui.png",
                    srcPosition: Vector2(128, 320),
                    srcSize: Vector2(16, 15),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    marketVisible = true;
                  });
                },
              ),
            ),
          ),

          //Art create button
          Positioned(
            bottom: 90,
            right: 105,
            child: Container(
              width: 63,
              height: 63,
              child: ElevatedButton(
                child: Transform.scale(
                  scale: 2.4,
                  child: SpriteWidget.asset(
                    path: "ui/ui.png",
                    srcPosition: Vector2(128, 320),
                    srcSize: Vector2(16, 15),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    artCreateVisible = true;
                  });
                },
              ),
            ),
          ),

          //Art create button
          Positioned(
            bottom: 124,
            right: 36,
            child: Container(
              width: 63,
              height: 63,
              child: ElevatedButton(
                child: Transform.scale(
                  scale: 2.4,
                  child: SpriteWidget.asset(
                    path: "ui/ui.png",
                    srcPosition: Vector2(128, 320),
                    srcSize: Vector2(16, 15),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context, 
                    builder: (context) {
                      return AlertDialog( 
                        title: const Text('Stake your coin'), 
                        content: TextField( 
                          onChanged: (value) { }, 
                          controller: stakeController, 
                          decoration: const InputDecoration(hintText: "Amount"), 
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Shyft.token.stake(int.parse(stakeController.text));

                              Navigator.pop(context);
                            },
                            child: const Text("Ok"),
                          )
                        ],
                      );
                    }
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
