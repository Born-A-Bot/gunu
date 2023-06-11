
import 'package:flutter/material.dart';
import 'dart:math';
import 'play.dart';
import 'package:provider/provider.dart';


//the user is attempting to guess an auto-generated number  

//Keeps track of random number throughout the app
void main() {
  runApp(
      ChangeNotifierProvider(create: (_) => GenerateNumber(), child: MyApp()));
}

//Generates random number
class GenerateNumber extends ChangeNotifier {

  int _random = 0;

  int get getRandom => _random;

  void onChange() {
    _random = Random().nextInt(100);
    notifyListeners();
    print('onChange random is $_random');
  }
}

//Root build of the home page 
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false, 
      title: 'Guess The Number',
      theme: ThemeData(
       // primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      routes: {
        'gamePage': (BuildContext context) => MyGamePage(),
      },
    );
  }
}

//Main build of the home page 
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  GenerateNumber genNum = GenerateNumber();
  late int getRandom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0, 
          backgroundColor: Colors.green[800], //lightGreen[100],
   
        ),
        
        backgroundColor: Colors.green[800], //lightGreen[100],
        body: Container(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
               // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/guns_acro_full_green_white.png',
                      alignment: Alignment.center, ),//scale: 4),
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                            padding: EdgeInsets.only(left: 40, right: 40, top: 0, bottom: 0),
                 child:  ElevatedButton.icon(
                      icon: Icon(Icons.play_arrow, size: 36.0,),
                      label: Text('Play', style: TextStyle(color: Colors.white, fontSize: 20,
                      )),
                      style:  ButtonStyle(
                        
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.green),
                      ),
                     // child:  Text('Start'),
                      onPressed: () => [
                            context.read<GenerateNumber>().onChange(),
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => MyGamePage())),
                          ]),),
                ]),
          ],
        )
        ));
  }
}
