import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'components/button.dart';

class Screen extends StatefulWidget {
  const Screen({Key? key}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  var userInput = '';
  var answer = '';
  final int maxLength = 10;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              userInput.toString(),
                              style:
                              const TextStyle(fontSize: 30, color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              answer.toString(),
                              style: const TextStyle(
                                  fontSize: 40,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Button(
                              title: 'AC',
                              color: const Color(0xffead5ff),
                              onPress: () {
                                userInput = '';
                                answer = '';
                                setState(() {});
                              },
                            ),
                            Button(
                                title: '+/-',
                                color: const Color(0xffc7e2fa),
                                onPress: () {
                                  var b=userInput;
                                  if(userInput.contains('–')){b=b.replaceAll('–','-');}
                                  double a=double.parse(b);
                                  a=a*(-1);
                                  answer=a.toString();
                                  if (answer.endsWith('.0')) {
                                    answer = answer.substring(0, answer.length - 2);
                                  }
                                  setState(() {});
                                }),
                            Button(
                              title: '%',
                              color: const Color(0xffc7e2fa),
                              onPress: () {
                                if (userInput.isNotEmpty) {
                                  double a = double.parse(userInput);
                                  a = a / 100;
                                  answer = a.toString();
                                  userInput = answer;
                                }
                                setState(() {});
                              },
                            ),
                            Button(
                              title: '÷',
                              color: const Color(0xffc7e2fa),
                              onPress: () {
                                userInput += '÷';
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Button(
                              title: '7',
                              onPress: () {
                                userInput += '7';
                                setState(() {});
                              },
                            ),
                            Button(
                              title: '8',
                              onPress: () {
                                userInput += '8';
                                setState(() {});
                              },
                            ),
                            Button(
                              title: '9',
                              onPress: () {
                                userInput += '9';
                                setState(() {});
                              },
                            ),
                            Button(
                              title: 'x',
                              color: const Color(0xffc7e2fa),
                              onPress: () {
                                userInput += 'x';
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Button(
                              title: '4',
                              onPress: () {
                                userInput += '4';
                                setState(() {});
                              },
                            ),
                            Button(
                              title: '5',
                              onPress: () {
                                userInput += '5';
                                setState(() {});
                              },
                            ),
                            Button(
                              title: '6',
                              onPress: () {
                                userInput += '6';
                                setState(() {});
                              },
                            ),
                            Button(
                              title: '–',
                              color: const Color(0xffc7e2fa),
                              onPress: () {
                                userInput += '–';
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Button(
                              title: '1',
                              onPress: () {
                                userInput += '1';
                                setState(() {});
                              },
                            ),
                            Button(
                              title: '2',
                              onPress: () {
                                userInput += '2';
                                setState(() {});
                              },
                            ),
                            Button(
                              title: '3',
                              onPress: () {
                                userInput += '3';
                                setState(() {});
                              },
                            ),
                            Button(
                              title: '+',
                              color: const Color(0xffc7e2fa),
                              onPress: () {
                                userInput += '+';
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Button(
                              title: '0',
                              onPress: () {
                                userInput += '0';
                                setState(() {});
                              },
                            ),
                            Button(
                              title: '.',
                              onPress: () {
                                if (userInput.isEmpty) {
                                  userInput += '0';
                                }
                                userInput += '.';
                                setState(() {});
                              },
                            ),
                            Button(
                              title: '⌫',
                              onPress: () {
                                userInput =
                                    userInput.substring(0, userInput.length - 1);
                                setState(() {});
                              },
                            ),
                            Button(
                              title: '=',
                              color: const Color(0xffc7e2fa),
                              onPress: () {
                                equalPress();
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void equalPress() {
    var input = userInput;
    if (input.contains('÷0')) {
      answer = "Can't Divide by Zero";
      userInput = '';
      return;
    }

    if (input.contains('x')) {
      input = userInput.replaceAll('x', '*');
    } else if (input.contains('–')) {
      input = userInput.replaceAll('–', '-');
    } else if (input.contains('÷')) {
      input = userInput.replaceAll('÷', '/');
    }
    Parser p = Parser();
    Expression expression = p.parse(input);
    ContextModel contextModel = ContextModel();
    double evaluate = expression.evaluate(EvaluationType.REAL, contextModel);
    String result = evaluate.toStringAsFixed(9);
    while (result.contains('.') &&
        (result.endsWith('0') || result.endsWith('.'))) {
      result = result.substring(0, result.length - 1);
    }
    if (result.length > maxLength) {
      result = result.substring(0, maxLength);
    }
    answer = result;
  }
}
