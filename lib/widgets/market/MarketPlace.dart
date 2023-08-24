import 'package:flutter/material.dart';
import 'package:ville/widgets/market/MarketSlot.dart';

class MarketPlace extends StatefulWidget {
  const MarketPlace({ super.key });

  @override
  State<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //* [MARKET]
        Container(
          height: 600,
          child: Column(
            children: [
              //* [LISTING PLACE]
              Container(
                width: 600,
                height: 118,
                color: Colors.white,
                padding: const EdgeInsets.all(15),
                child: GridView.count(
                  crossAxisCount: 6,
                  crossAxisSpacing: 12,
                  children: [
                    MarketSlot(),
                    MarketSlot(),
                    MarketSlot(),
                    MarketSlot(),
                    MarketSlot(),
                    MarketSlot()
                  ],
                ),
              ),
              //* [MARKETPLACE]
              Container(
                width: 600,
                height: 360,
                margin: const EdgeInsets.only(top: 24),
                padding: const EdgeInsets.all(15),
                color: Colors.white,
                child: GridView.count(
                  crossAxisCount: 5,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    MarketSlot(),
                    MarketSlot(),
                    MarketSlot(),
                    MarketSlot(),
                    MarketSlot(),
                    MarketSlot(),
                    MarketSlot(),
                    MarketSlot(),
                    MarketSlot(),
                    MarketSlot(),
                    MarketSlot(),
                    MarketSlot()
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        //* [LIST CONFIG]
        Container(
          height: 600,
          child: Column(
            children: [
              //* [LISTING PLACE]
              Container(
                width: 420,
                height: 179,
                color: Colors.white,
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 96,
                      height: 96,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 12),
                    Column(
                      children: [
                        Container(
                          width: 240,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Supply",
                              hintStyle: TextStyle(
                                fontSize: 14
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        Container(
                          width: 240,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Price",
                              hintStyle: TextStyle(
                                fontSize: 14
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {

                          },
                          child: Text("List on market")
                        )
                      ],
                    )
                  ],
                )
              ),
              //* [MARKETPLACE]
              Container(
                width: 420,
                height: 299,
                margin: const EdgeInsets.only(top: 24),
                padding: const EdgeInsets.all(15),
                color: Colors.white,
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    MarketSlot(),
                    MarketSlot(),
                    MarketSlot(),
                    MarketSlot(),
                    MarketSlot(),
                    MarketSlot(),
                    MarketSlot(),
                    MarketSlot(),
                    MarketSlot(),
                    MarketSlot(),
                    MarketSlot(),
                    MarketSlot()
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}