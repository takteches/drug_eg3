import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'adhelper.dart';


class upgrader extends StatefulWidget {

  const upgrader({Key? key}) : super(key: key);

  @override
  State<upgrader> createState() => _upgraderState();
}

class _upgraderState extends State<upgrader> {
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
    Upgrader().clearSavedSettings();
    final appcastURL =
        'https://raw.githubusercontent.com/takteches/drugcenter/master/file.xml';
    final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);
    return Scaffold(
      appBar:  AppBar(
        title: const Text(
          "Update",
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
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (_isBannerAdReady)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: _bannerAd.size.width.toDouble(),
                height: _bannerAd.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd),
              ),
            ),
          SizedBox(height: 10,),

          UpgradeAlert(
            appcastConfig: cfg,
            debugLogging: true,
            child: Center(child: Text('Version up to date...', style: TextStyle(
              fontSize: 20,
            ),)),
          ),
          Text("لمتابعة التحديثات "),
          Text("facebook.com/egydrugindex"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Text("Rate App"),
              IconButton(
                icon: Image.asset('assets/google_play.png'),
                onPressed: () =>  StoreRedirect.redirect(androidAppId: "com.devtawf.drug_eg",
                          iOSAppId: ""),
              ),
            ],
          ),


        ],
      ),


    );
  }
}
