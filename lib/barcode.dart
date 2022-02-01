import 'dart:io';
import 'package:drug_eg2/web.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'adhelper.dart';


class barecode extends StatefulWidget {
  const barecode({Key? key}) : super(key: key);


  @override
  _barecodeState createState() => _barecodeState();
}


class _barecodeState extends State<barecode> {
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  PickedFile? _image;
  final picker = ImagePicker();
  final barcodeScanner = GoogleMlKit.vision.barcodeScanner();

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
            "Imported Drugs",
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
                    minWidth: 20.0,
                    height: 40.0,
                    buttonColor: Colors.teal,
                    child: OutlinedButton.icon(
                      icon: Icon(Icons.image),
                      label: Text(
                        "1-scan code ",
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
                        "2-get info",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onPressed:  () async {
                        print("done1");
                        final inputImage = InputImage.fromFile(File(_image!.path));
                        print("done2");
                        final List<Barcode> barcodes = await barcodeScanner.processImage(inputImage);

                        setState(() {
                          for (Barcode barcode in barcodes) {
                            final BarcodeType type = barcode.type;
                            final Rect? boundingBox = barcode.value.boundingBox;
                            final String? displayValue = barcode.value
                                .displayValue;
                            final String? rawValue = barcode.value.rawValue;
                            print(displayValue );
                            String url="https://www.barcodelookup.com/${displayValue}";
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => WebPage(url),
                                ));

                          }
                        });

                      },
                      style: OutlinedButton.styleFrom(
                        shape: StadiumBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              Text("scan product's code to get information"),
              Container(
                  height: 200,
                  child: Image.asset("assets/BarcodeScan.jpg")
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
        ));

  }
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
      } else {
        print('No image selected');
      }
    });
  }
}

