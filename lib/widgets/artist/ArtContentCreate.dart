import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ville/api/main.dart';
import 'package:ville/api/shyft/ShyftNFT.dart';

class ArtContentCreate extends StatefulWidget {
  const ArtContentCreate({ super.key, required this.onClose, this.onCreate });

  final Function onClose;
  final Function? onCreate;

  @override
  State<ArtContentCreate> createState() => _ArtContentCreateState();
}

class _ArtContentCreateState extends State<ArtContentCreate> {
  String? thumbSrc;
  String? spriteSrc;
  List<int>? thumbBytes;
  List<int>? spriteBytes;

  var nameController = TextEditingController();
  var supplyController = TextEditingController();
  var descController = TextEditingController();
  var widthController = TextEditingController();
  var heightController = TextEditingController();
  var symbolController = TextEditingController();

  Future<XFile?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    return image;
  }

  void handleSubmit() async {
    await Shyft.nft.create(
      name: nameController.text, 
      maxSupply: int.parse(supplyController.text), 
      desc: descController.text, 
      width: int.parse(widthController.text), 
      height: int.parse(heightController.text), 
      symbol: nameController.text, 
      thumbBytes: thumbBytes!, 
      spriteBytes: spriteBytes!
    );

    widget.onClose();

    //Clear fields
    nameController.text = "";
    supplyController.text = "";
    descController.text = "";
    widthController.text = "";
    heightController.text = "";

    setState(() {
      thumbBytes = null;
      spriteBytes = null;
      thumbSrc = null;
      spriteSrc = null;
    });
  
    widget.onCreate!();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      width: 540,
      height: 450,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 128,
                height: 128,
                color: Colors.black,
                child: GestureDetector(
                  onTap: () async {
                    XFile? image = await pickImage();

                    if(image != null) {
                      var fileBytes = await image.readAsBytes();

                      setState(() {
                        thumbSrc = image.path;
                        thumbBytes = fileBytes;
                      });
                    }
                  },
                  child: thumbSrc != null ?
                    Image.asset(thumbSrc!)
                    : null,
                ),
              ),
              const SizedBox(height: 12),
              const Text("Thumbnail"),
              const SizedBox(height: 24),
              Container(
                width: 128,
                height: 128,
                color: Colors.black,
                child: GestureDetector(
                  onTap: () async {
                    XFile? image = await pickImage();

                    if(image != null) {
                      var fileBytes = await image.readAsBytes();

                      setState(() {
                        spriteSrc = image.path;
                        spriteBytes = fileBytes;
                      });
                    }
                  },
                  child: spriteSrc != null ?
                    Image.asset(spriteSrc!)
                    : null,
                ),
              ),
              const SizedBox(height: 12),
              const Text("Sprite"),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: "Name"
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: symbolController,
                    decoration: const InputDecoration(
                      hintText: "Symbol"
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: supplyController,
                    decoration: const InputDecoration(
                      hintText: "Max supply"
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: descController,
                    decoration: const InputDecoration(
                      hintText: "Description"
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: widthController,
                    decoration: const InputDecoration(
                      hintText: "Width px"
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: heightController,
                    decoration: const InputDecoration(
                      hintText: "Height px"
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => widget.onClose(), 
                        child: const Text("Cancel")
                      ), 
                      ElevatedButton(
                        onPressed: () => handleSubmit(), 
                        child: const Text("Submit")
                      )
                    ],
                  ),
                )
              ],
            )
          )
        ],
      ),
    );  
  }
}