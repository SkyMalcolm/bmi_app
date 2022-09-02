import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.

        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double? _bmi;
  String _message = "Please enter your height and weight";

  void calculateBMI() {
    final height = double.parse(_heightController.text);
    final weight = double.parse(_weightController.text);

    double bmiResult = weight / pow(height / 100, 2);

    setState(() {
      if (height == null || height <= 0 || weight == null || weight <= 0) {
        _message = "Your height and weight must be positive numbers";
      }
    });

    setState(() {
      _bmi = bmiResult;
      if (_bmi! <= 0) {
        _bmi = null;
      } else if (_bmi! < 18.5) {
        _message = "You are underweight";
      } else if (_bmi! < 25) {
        _message = 'You are normal';
      } else if (_bmi! < 30) {
        _message = 'You are overweight';
      } else if (_bmi! < 35) {
        _message = 'You are obese';
      } else {
        _message = 'You are extremely obese';
      }
    });
  }

  void clearUI() {
    _heightController.clear();
    _weightController.clear();

    setState(() {
      _message = "Please enter your height and weight";
      _bmi = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BMI Calculator"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _bmi == null ? "0.0" : "Your BMI is: ${_bmi!.toStringAsFixed(2)}",
            style: TextStyle(
                color: Colors.redAccent,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            _message,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 40),
          Platform.isAndroid
              ? TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: _heightController,
                  decoration: InputDecoration(
                    labelText: "Height (cm)",
                    icon: Icon(Icons.trending_up),
                  ),
                )
              : CupertinoTextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: _heightController,
                  prefix: Icon(Icons.trending_up),
                  placeholder: "Height",
                  style: TextStyle(height: 2)),
          SizedBox(height: 5),
          Platform.isAndroid
              ? TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: _weightController,
                  decoration: InputDecoration(
                    labelText: "Weight (kg)",
                    icon: Icon(Icons.line_weight),
                  ),
                )
              : CupertinoTextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: _weightController,
                  prefix: Icon(Icons.line_weight),
                  placeholder: "Weight",
                  style: TextStyle(height: 2)),
          SizedBox(
            height: 20,
          ),
          SizedBox(
              width: 150,
              height: 50,
              child: Platform.isAndroid
                  ? RaisedButton(
                      color: Colors.green,
                      child: Text(
                        "Calculate",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: calculateBMI)
                  : CupertinoButton(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                      color: CupertinoColors.activeBlue,
                      child: Text("Calculate"),
                      onPressed: calculateBMI)),
          SizedBox(height: 10),
          SizedBox(
              width: 150,
              height: 50,
              child: Platform.isAndroid
                  ? RaisedButton(
                      color: Colors.red,
                      child: Text(
                        "Reset",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: clearUI)
                  : CupertinoButton(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                      color: CupertinoColors.systemRed,
                      child: Text(
                        "Reset",
                      ),
                      onPressed: clearUI)),
        ],
      ),
    );
  }
}
