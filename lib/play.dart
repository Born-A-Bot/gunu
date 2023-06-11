// ignore_for_file: use_key_in_widget_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'main.dart';
import 'package:provider/provider.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

//use this page to start the game with a 'play' button
//which also generates a random number

//the user is attempting to guessCount

void main() {
  runApp(MyApp());
}

// use main for InheritedWidget and main build - move play game and new game classes/methods to separate pages

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      title: 'GuNu Reboot',
      theme: ThemeData(
       // primarySwatch: Colors.blue,
      ),
      home: MyGamePage(),
    );
  }
}

//  class  InputTextController extends StatelessWidget {
// //validate user input with try catch
// //enhance performance - dispose of contents
//  }

class MyGamePage extends StatefulWidget {
  MyGamePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyGamePage> createState() => MyGamePageState();
}

class MyGamePageState extends State<MyGamePage> {
  MyGamePageState({
    this.guessCount = 0,
    this.userInput = '',
  });

  int guessCount;
  String userInput;
  final myController = TextEditingController();

  // late ConfettiController controllerTopCenter;

  void _printLatestTextValue() {
    print('Updated Random Number $myController');
  }

  @override
  void initState() {
    final myController = TextEditingController();
    // controllerTopCenter =
    // ConfettiController(duration: const Duration(seconds: 3));
    userInput = myController.text;
    myController.addListener(_printLatestTextValue);
    super.initState();
  }

  @override
  void dispose() {
    myController.dispose();
    //controllerTopCenter.dispose();
    super.dispose();
  }

  void clearText() {
    myController.clear();
  }

// track of number of guesses 
  guessCounter() {
    guessCount;

  
    if (guessCount == 2) {
      print('You\'re guess count is $guessCount');
      displayMaximumGuesses(context);
    }
    guessCount++;
    print('current guess count: $guessCount');
  }

  updateInput() {
    setState(() {
      userInput = myController.text;
      print('updateInput_output: $userInput');
    });
  }

//compare user input to generated number
  checkAnswer() {

    var textController = myController.text;
    var genNum = context.read<GenerateNumber>().getRandom;

    print("CheckAnswer: $textController");
    print('Current Number: $genNum');

    // ignore: unrelated_type_equality_checks
    if (textController == genNum.toString()) {
      return displayDialogCorrect(context); // && displayConfetti();
      print("Yay, you guessed it!");
    } else {
      // ignore: unrelated_type_equality_checks
      if (textController != genNum.toString()) {
        return displayDialogIncorrect(context);

        print("Sorry, try again");
      }
    }
  }
//notify user if answer is correct
  displayDialogCorrect(BuildContext context) {
    var textController = myController.text;

    String userInput = MyGamePageState().userInput;
    print(textController);

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('YAY!', 
             textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30, 
              fontWeight: FontWeight.bold, 
              color: Colors.green,
            )),
            backgroundColor: Colors.white,
            content:  Text.rich(
              TextSpan(
                //text: '$textController is correct'),
                children: <TextSpan>[
                  
                  TextSpan(text:'$textController is correct!', style: TextStyle(color: Colors.green, fontSize: 25, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic,),),
                   TextSpan(text:' \n'),
                   TextSpan(text:'you guessed it!!!', style: TextStyle(color:Colors.grey[600], fontSize: 20, fontWeight: FontWeight.bold),),
                ]),
                textAlign: TextAlign.center),
            actions: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white, 
                )),
                  child: Text("Play Again",
                      style: TextStyle(
                        
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.bold, 
                      )),
                  onPressed: () => [
                        Navigator.pop(context),
                        MaterialPageRoute(builder: (_) => MyGamePage()),
                      ]),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states)=>Colors.white),
                ),
                child: Text("End Game!", 
                style: TextStyle(
                  color: Colors.green, 
                  fontSize: 16, 
                  fontWeight: FontWeight.bold, 
                )),
                onPressed: () => Navigator.pushNamed(context, '/'),
              ),
            ],
          );
        });
  }

//notify user if answer is not correct
  displayDialogIncorrect(BuildContext context) {
    var textController = myController.text;

    // var displayUserInput = MyGamePageState().updateInput();

    // print('displayUser $displayUserInput');

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("SORRY!",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  )),
              content: Text.rich(
                TextSpan(
                  children: <TextSpan> [
                    TextSpan(text: 'Nope, ', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),),
                    TextSpan(text: '$textController', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 25, ),),
                    TextSpan(text: ' is not the answer.', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20, ),),
                  ],
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.white,
                       // overlayColor: MaterialStateColor.resolveWith(states) => Colors.lightGreenAccent,
                      ),
                    ),
                    child: Text("Guess Again?",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                        )),
                      
                    onPressed: () => [
                          Navigator.pop(context),
                          MaterialPageRoute(builder: (_) => MyGamePage()),
                        ]),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                      (states) => Colors.white,
                    ),
                  ),
                  child: const Text("End Game!", style: TextStyle(
                    color: Colors.green, 
                  )),
                  onPressed: () => Navigator.pushNamed(context, '/'),
                ),
              ]);
        });
  }
//notify user maximum number of guesses has been reached
  displayMaximumGuesses(BuildContext context) {
    var genNum = context.read<GenerateNumber>().getRandom;
    var displayUserInput;

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('THAT\'S IT!', style: TextStyle(
                fontSize: 30, 
                color: Colors.green,
                fontWeight: FontWeight.bold)),

              content: Text.rich(
                TextSpan(
                  children: <TextSpan> [
                    TextSpan(text: 'You are out of guesses.', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20),),
                  //  TextSpan(text: 'Bummer', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20, ),),
                    TextSpan(text: 'Click the button to play again.', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20, ),),
                  ],
                ),
              ),
              
              // Text(
              //     "Sorry, you are out of guesses. The number is\n displayUserInput"), //future updates 1) display answer and 2) list guesses
              // backgroundColor: Colors.white,

              actions: <Widget>[
                ElevatedButton(
                    child: Text("New Game?"),
                    onPressed: () => [
                          Navigator.pop(context),
                          MaterialPageRoute(builder: (_) => MyGamePage()),
                        ]),
                ElevatedButton(
                  child: Text("End game!"),
                  onPressed: () => Navigator.pushNamed(context, '/'),
                ),
              ]);
        });
  }

//game page main build 
  @override
  Widget build(BuildContext context) {
    String userInput;

    return Scaffold(
      
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
          ), 
          elevation: 0,
          backgroundColor: Colors.green[800],//lightGreen[100],
          //title: const Text('Guess The Number'),
        ),
        backgroundColor: Colors.green[800],//lightGreen[100],
        // theme: Theme(data: data, child: child)
        body: Container(
          
          child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/guns_acro_full.png',
                          alignment: Alignment.center, ),//scale: 2),
                          Padding(
                            padding: EdgeInsets.only(left: 40, right: 40, top: 0, bottom: 0),
                          child: TextField(
                        onChanged: (value) {
                          var userInput = value;
                          print(userInput);
                        },
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.green,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 5,
                              color: Colors.green,
                            ),
                          ),
                          hintText: "Enter a number between 1 and 25",
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        autofocus: true,
                        showCursor: true,
                        textAlign: TextAlign.start,
                        controller: myController,
                        maxLength: 5,
                      ),),
                      ElevatedButton(
                         style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.green,
                            ),
                      ),
                          child: Text('Guess', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20,)),
                          onPressed: () => [
                                // Navigator.pop(context, userInput = myController.text),
                                guessCounter(),
                                checkAnswer(),
                                updateInput(),
                                myController.clear(),
                              ],
                              
                              ),
                    ]
                    ),
            
        )
                    );
  }
}
