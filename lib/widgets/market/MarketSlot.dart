import 'package:flutter/material.dart';

class MarketSlot extends StatelessWidget {
  const MarketSlot({ super.key, required this.imageSrc, required this.amount, this.price, this.onTap });

  final String imageSrc;
  final int amount;
  final int? price;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Container(
        width: 96,
        height: 96,
        padding: const EdgeInsets.only(bottom: 6),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black12,
              width: 3,
            )
          )
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    child: Align(
                      child: Container(
                        margin: const EdgeInsets.only(top: 27),
                        width: 35,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(24)
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Align(
                      child: Container(
                        width: 42,
                        height: 42,
                        child: Image.network(imageSrc),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "x${amount.toString()}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600
                        )
                      ),
                    )
                  )
                ],
              ),
            ),
            const SizedBox(height: 6),
            price != null ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  // child: Image.asset("images/ui/emerald.png"),
                ),
                const SizedBox(width: 6),
                Text(
                  price.toString(), 
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600
                  )
                )
              ],
            ) : Container(),
          ],
        ),
      ),
    );
  }
}