import 'package:drug_eg2/barcode.dart';
import 'package:drug_eg2/calculate.dart';
import 'package:drug_eg2/med_acc.dart';
import 'package:drug_eg2/update.dart';
import 'adhelper.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'cosmetics.dart';
import 'drugs.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/splash2.png',
                fit: BoxFit.contain,
                height: 32,
              ),
              Container(
                  padding: const EdgeInsets.all(8.0), child: Text(
                "Egy Drug Index",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Courgette",
                  fontSize: 22,
                ),
              ),)
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => upgrader()),
                );
              },
              icon: Icon(Icons.update),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => drugs()),
                          ),
                          child: const CircleAvatar(
                            backgroundImage: ExactAssetImage('assets/drugi.jpg'),
                            radius: 55,
                          ),
                        ),
                        Text(
                          "Drugs",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 40 ),
                        InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => calculate()),
                          ),
                          child: const CircleAvatar(
                            backgroundImage: ExactAssetImage('assets/cal.png'),
                            radius: 55,
                          ),
                        ),
                        Text(
                          "Rx.calc",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )

                      ],
                    ),
                    SizedBox(width: 80),
                    Column(
                      children: [
                        InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  cosmetics()),
                          ),
                          child: const CircleAvatar(
                            backgroundImage: ExactAssetImage('assets/cosmeticsi.jpg'),
                            radius: 55,
                          ),
                        ),
                        Text(
                          "Cosmetics",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 40 ),
                        InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  barecode()),
                          ),
                          child: const CircleAvatar(
                            backgroundImage: ExactAssetImage('assets/barcode.jpg'),
                            radius: 55,
                          ),
                        ),
                        Text(
                          "Made in",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 50,),

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

          ),
        ));
  }
}
