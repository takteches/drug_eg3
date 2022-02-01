import 'dart:io';
import 'package:drug_eg2/drug.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';

import 'adhelper.dart';
import 'cosmetics.dart';
import 'drugs.dart';

class magic extends StatefulWidget {
  const magic({Key? key}) : super(key: key);


  @override
  _magicState createState() => _magicState();
}


class _magicState extends State<magic> {
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  String text = '';
   PickedFile? _image;
  final picker = ImagePicker();
  List<String> _extract_list1=['1','2','3'];
  List<String> _extract_list=[];
  final textDetector = GoogleMlKit.vision.textDetector();


  @override
  void initState() {
    // TODO: Initialize _bannerAd
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

  void dispose() {
    _bannerAd.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Text Recognition",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Courgette",
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
          elevation: 0.0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
        backgroundColor: Colors.cyan[50],
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 20,),
              if (_image == null) Container(
                height: 200,
                color: Colors.grey[300],
                child: Icon(
                  Icons.image,
                  size: 200,
                ),
              ) else Container(
                height: 300,
                  child: _image != null
                      ? Image.file(
                    File(_image!.path),
                    fit: BoxFit.fitWidth,
                  )
                      : Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonTheme(
                    minWidth: 10.0,
                    height: 10.0,
                    buttonColor: Colors.teal,
                    child: OutlinedButton.icon(
                      icon: Icon(Icons.image),
                      label: Text(
                        "1-upload image ",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onPressed: getImage,
                      style: OutlinedButton.styleFrom(
                        shape: StadiumBorder(),
                      ),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 10.0,
                    height: 10.0,
                    buttonColor: Colors.teal,
                    child: OutlinedButton.icon(
                      icon: Icon(Icons.animation),
                      label: Text(
                        "2-read data ",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onPressed:  () async {
                        print("done1");
                        final inputImage = InputImage.fromFile(File(_image!.path));
                        print("done2");
                        final RecognisedText recognisedText = await textDetector.processImage(inputImage);
                        String text = recognisedText.text;
                        for (TextBlock block in recognisedText.blocks) {
                          for (TextLine line in block.lines) {
                            // Same getters as TextBlock
                            for (TextElement element in line.elements) {
                              final Rect rect = block.rect;
                              final List<Offset> cornerPoints = block.cornerPoints;
                              final String text = block.text;
                              final List<String> languages = block.recognizedLanguages;
                              // Same getters as TextBlock
                            }
                          }
                        }
                        setState(() {
                          String text1 = text.replaceAll("  ", " ").trim();
                          final List<String> _extract_list = text1.split(" ");
                          _extract_list1=_extract_list;


                        });
                        print(_extract_list);
                      },
                      style: OutlinedButton.styleFrom(
                        shape: StadiumBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              Text("click to copy to clipboard"),
              Container(
                height: 200,
                width: 300,
                color: Colors.white60,
                child: ListView.builder(
                    itemCount: _extract_list1.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration( //                    <-- BoxDecoration
                          border: Border(bottom: BorderSide()),
                        ),
                        child: ListTile(
                          title: Text("${_extract_list1[index]}"),
                          onTap: () {
                            setState(() {
                              Clipboard.setData(new ClipboardData(text: "${_extract_list1[index]}")).then((_){
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(content: Text('Copied to your clipboard !')));
                              });
                            });

                          },
                        ),
                      );

                    }),
              ),
              if (_isBannerAdReady)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: _bannerAd.size.width.toDouble(),
                    height: _bannerAd.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd),
                  ),
                ),
            ],
          ),
        )


    );

  }
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
      } else {
        print('No image selected');
      }
    });
  }
}
