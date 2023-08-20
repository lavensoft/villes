import 'package:flutter/material.dart';

class InventorySlot extends StatelessWidget {
  const InventorySlot({ super.key, required this.image, required this.amount });

  final Image image;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 3
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            child: image,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              amount.toString(), 
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}