import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        fontFamily: 'Quicksand',
      ),
      home: MyCalculator(),
    );
  }
}

class MyCalculator extends StatefulWidget {
  @override
  _MyCalculatorState createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  String eq = "0";
  String res = "";
  String expression = "";
  double eqFontSize = 40.0;
  double resFontSize = 30.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        eq = "0";
        res = "";
        eqFontSize = 38.0;
        resFontSize = 48.0;
      } else if (buttonText == "⌫") {
        eqFontSize = 48.0;
        resFontSize = 38.0;
        eq = eq.substring(0, eq.length - 1);
        if (eq == "") {
          eq = "0";
        }
      } else if (buttonText == "=") {
        eqFontSize = 38.0;
        resFontSize = 48.0;

        expression = eq;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          res = '${exp.evaluate(EvaluationType.REAL, cm)}'+":)";
        } catch (e) {
          res = "Invalid :(";
        }
      } else {
        eqFontSize = 48.0;
        resFontSize = 38.0;
        if (eq == "0") {
          eq = buttonText;
        } else {
          eq = eq + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.lightGreenAccent,
                  width: 1,
                  style: BorderStyle.solid)),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.black),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              eq,
              style: TextStyle(fontSize: eqFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              res,
              style: TextStyle(fontSize: resFontSize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("AC", 1, Colors.pink[300]),
                      buildButton("⌫", 1, Colors.lightGreen),
                      buildButton("÷", 1, Colors.lightGreen),
                    ]),
                    TableRow(children: [
                      buildButton("7", 1, Colors.orange[400]),
                      buildButton("8", 1, Colors.orange[400]),
                      buildButton("9", 1, Colors.orange[400]),
                    ]),
                    TableRow(children: [
                      buildButton("4", 1, Colors.orange[400]),
                      buildButton("5", 1, Colors.orange[400]),
                      buildButton("6", 1, Colors.orange[400]),
                    ]),
                    TableRow(children: [
                      buildButton("1", 1, Colors.orange[400]),
                      buildButton("2", 1, Colors.orange[400]),
                      buildButton("3", 1, Colors.orange[400]),
                    ]),
                    TableRow(children: [
                      buildButton(".", 1, Colors.orange[400]),
                      buildButton("0", 1, Colors.orange[400]),
                      buildButton("00", 1, Colors.orange[400]),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("×", 1, Colors.lightGreen),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Colors.lightGreen),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Colors.lightGreen),
                    ]),
                    TableRow(children: [
                      buildButton("=", 2, Colors.pink[300]),
                    ]),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
