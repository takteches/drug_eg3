
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class help extends StatefulWidget {
  const help({Key? key}) : super(key: key);

  @override
  _helpState createState() => _helpState();
}

class _helpState extends State<help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: new Center(
        child: new ListView(
          children: [
            Image.asset('assets/project/1.gif',
              fit: BoxFit.cover,),
            SizedBox(height: 20,),
            Image.asset('assets/project/4.gif',
              fit: BoxFit.cover,),
            SizedBox(height: 20,),
            Image.asset('assets/project/2.gif',
              fit: BoxFit.cover,),
            SizedBox(height: 20,),
            Image.asset('assets/project/3.gif',
              fit: BoxFit.cover,),
            SizedBox(height: 20,),
            Image.asset('assets/project/5.gif',
              fit: BoxFit.cover,),
            SizedBox(height: 20,),
            Image.asset('assets/project/6.gif',
              fit: BoxFit.cover,),
            SizedBox(height: 20,),
          ],

        ),
      ),
    );
  }
}
