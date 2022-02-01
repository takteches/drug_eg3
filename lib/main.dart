
import 'package:drug_eg2/magic.dart';
import 'package:drug_eg2/med_acc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'barcode.dart';
import 'cosmetics.dart';
import 'drugs.dart';
import 'home.dart';

void main() => runApp(MaterialApp(
      initialRoute : "/home",
      routes: {
        "/home" :(context) => const Home(),
        "/drugs" : (context) =>  drugs(),
        "/cosmetics" :(context) =>  cosmetics(),
        "/medical_acc" :(context) =>  med_acc(),
        "/magic" :(context) =>  magic(),
        "/barcode" :(context) =>  barecode(),

      },

      debugShowCheckedModeBanner: false,

    ));

