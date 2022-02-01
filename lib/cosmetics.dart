import 'dart:async';
import 'package:drug_eg2/drug.dart';
import 'package:drug_eg2/web.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:flutter/services.dart' as rootBundle;
import 'package:google_mobile_ads/google_mobile_ads.dart';
import "package:scroll_app_bar/scroll_app_bar.dart";
import 'adhelper.dart';
import 'dialog.dart';
import 'drug help.dart';
import 'magic.dart';

class cosmetics extends StatefulWidget {
  @override
  State<cosmetics> createState() => _cosmeticsState();
}

class _cosmeticsState extends State<cosmetics> {
  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;

  List<drug> filter_drugs = [];
  final controller = ScrollController();
  var _controller = TextEditingController();
  int _radioVal = -1;
  num result = 0;

  @override
  void initState() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this._interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              magic();
            },
          );

          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }
  void dispose() {

    _interstitialAd?.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScrollAppBar(
        controller: controller,
        title: const Text(
          "Cosmetics",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Courgette",
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => help()),
              );
            },
            icon: Icon(Icons.help),
          ),
        ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_isInterstitialAdReady) {
            _interstitialAd?.show();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => magic()),);
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => magic()),);
          }
        },
        child: Icon(Icons.add_a_photo),
        backgroundColor: Colors.blueGrey,
      ),
      body: SafeArea(
        minimum: EdgeInsets.fromLTRB(0, 19, 0, 0),
        child: FutureBuilder(
          future: ReadJsonData(),
          builder: (context, data) {
            if (data.hasError) {
              return Center(child: Text("${data.error}"));
            } else if (data.hasData) {
              var drugs = data.data as List<drug>;

              String url="https://www.google.com/search?q=${_controller.text}&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjsoIva1MD0AhVhSvEDHblcBLMQ_AUoAXoECAIQAw&biw=1920&bih=904&dpr=1";
              return Column(children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Trade Names'),
                      Radio(
                        value: 0,
                        groupValue: _radioVal,
                        activeColor: Colors.blue,
                        onChanged: (int? value) {
                          if (value != null) {
                            setState(() {
                              _radioVal = value;
                            });
                          }
                        },
                      ),
                      Text('Active Ingredients'),
                      Radio(
                        value: 1,
                        groupValue: _radioVal,
                        activeColor: Colors.red,
                        onChanged: (int? value) {
                          if (value != null) {
                            setState(() {
                              _radioVal = value;
                            });
                          }
                        },
                      ),
                      Text('Use'),
                      Radio(
                        value: 2,
                        groupValue: _radioVal,
                        activeColor: Colors.greenAccent,
                        onChanged: (int? value) {
                          if (value != null) {
                            setState(() {
                              _radioVal = value;
                            });
                          }
                        },
                      ),
                      Text('Price'),
                      Radio(
                        value: 3,
                        groupValue: _radioVal,
                        activeColor: Colors.yellow,
                        onChanged: (int? value) {
                          if (value != null) {
                            setState(() {
                              _radioVal = value;
                            });
                          }
                        },
                      ),

                    ],
                  ),
                ),

                TextField(
                  controller: _controller,
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon:  Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(50)),
                    hintText: 'write any part',
                    contentPadding: EdgeInsets.all(15.0),
                    suffixIcon: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // added line
                      mainAxisSize: MainAxisSize.min, // added line
                      children: [
                        IconButton(
                          onPressed: _controller.clear,
                          icon: Icon(Icons.clear),
                        ),
                        IconButton(
                          icon: Image.asset('assets/google-logo.png'),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WebPage(url),
                              )),
                        ),
                      ],
                    ),
                  ),
                  onChanged: (string) {
                    setState(() {
                      print(_radioVal);
                      if (_radioVal == 0) {
                        filter_drugs = drugs
                            .where((u) => (u.names!
                                .toLowerCase()
                                .contains(string.toLowerCase())))
                            .toList();
                      } else if (_radioVal == 1) {
                        filter_drugs = drugs
                            .where((u) => (u.ing!
                                .toLowerCase()
                                .contains(string.toLowerCase())))
                            .toList();
                      } else if (_radioVal == 2) {
                        filter_drugs = drugs
                            .where((u) => (u.uses!
                                .toLowerCase()
                                .contains(string.toLowerCase())))
                            .toList();
                      } else if (_radioVal == 3) {
                        filter_drugs = drugs
                            .where((u) => (u.price!
                                .toLowerCase()
                                .contains(string.toLowerCase())))
                            .toList();
                      } else {
                        filter_drugs = drugs
                            .where((u) => (u.names!
                                    .toLowerCase()
                                    .contains(string.toLowerCase()) ||
                                u.ing!
                                    .toLowerCase()
                                    .contains(string.toLowerCase())))
                            .toList();
                      }
                    });
                  },
                ),
                Expanded(
                    child: ListView.builder(
                        controller: controller,
                        itemCount: filter_drugs.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => DialogUtils.showCustomDialog(
                              context,
                              title: (filter_drugs[index].names.toString()),
                              content: "use :  " +
                                  filter_drugs[index].uses.toString() +
                                  """
\n""" +
                                  "company : " +
                                  filter_drugs[index].company.toString(),
                              cancelBtnText: "back",
                              okBtnFunction: () => Navigator.pop(context),
                            ),
                            child: Card(
                              elevation: 3,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ButtonTheme(
                                          minWidth: 10.0,
                                          height: 10.0,
                                          buttonColor: Colors.teal,
                                          child: OutlinedButton(
                                            child: Text(
                                              "Alters",
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                filter_drugs = drugs
                                                    .where((u) => (u.ing!
                                                        .toLowerCase()
                                                        .contains(filter_drugs[
                                                                index]
                                                            .ing!
                                                            .toLowerCase())))
                                                    .toList();
                                              });
                                            },
                                            style: OutlinedButton.styleFrom(
                                              shape: StadiumBorder(),
                                            ),
                                          ),
                                        ),
                                        ButtonTheme(
                                          minWidth: 10.0,
                                          height: 10.0,
                                          buttonColor: Colors.teal,
                                          child: OutlinedButton(
                                            child: Text(
                                              "image",
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                String url="https://www.google.com/search?q=${filter_drugs[index].names}&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjsoIva1MD0AhVhSvEDHblcBLMQ_AUoAXoECAIQAw&biw=1920&bih=904&dpr=1";
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(builder: (context) => WebPage(url),
                                                    ));
                                              });
                                            },
                                            style: OutlinedButton.styleFrom(
                                              shape: StadiumBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                        child: Container(
                                      padding: EdgeInsets.only(bottom: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, right: 2),
                                            child: Text(
                                              filter_drugs[index]
                                                  .names
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, right: 2),
                                            child: Text(
                                              filter_drugs[index]
                                                  .ing
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.blueAccent,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 8, right: 8),
                                            child: Text(
                                                "Price:  " +
                                                    filter_drugs[index]
                                                        .price
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red)),
                                          ),
                                        ],
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          );
                        })),
              ]);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<drug>> ReadJsonData() async {
    final jsondata =
        await rootBundle.rootBundle.loadString('assets/file/drug.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((e) => drug.fromJson(e)).toList();
  }
}
