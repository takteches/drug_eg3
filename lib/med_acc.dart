import 'package:flutter/material.dart';

class med_acc extends StatelessWidget {
  const med_acc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Accessories",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Courgette",
            fontSize: 30,
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
        child: Image.asset("assets/construction.png"),
      ),

    );
  }
}
