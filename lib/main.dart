import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'calculatrice_controller.dart';


void main() {
  runApp(MaterialApp(
    home: MyCalculatrice(),
    theme: ThemeData(
      scaffoldBackgroundColor: Color(0x804F4F73)
    ),
    debugShowCheckedModeBanner: false,
  ));
}

class MyCalculatrice extends StatefulWidget {
  const MyCalculatrice({super.key});

  @override
  State<MyCalculatrice> createState() => _MyCalculatriceState();
}

class _MyCalculatriceState extends State<MyCalculatrice> {
  Map<String, dynamic> myValue = {
    'C': 'C',
    'AC': 'AC',
    '%': '%',
    '÷': '÷',
    '7': '7',
    '8': '8',
    '9': '9',
    'X': 'X',
    '4': '4',
    '5': '5',
    '6': '6',
    '-': '-',
    '1': '1',
    '2': '2',
    '3': '3',
    '+': '+',
    '+/-': '(-',
    '0': '0',
    ',': '.',
    '=': '=',
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('MyCalculator',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      //   backgroundColor: Colors.green,
      //   actions: [Icon(Icons.more_vert)],
      // ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 25, right: 30),
            height: MediaQuery
                .of(context)
                .size
                .height / 2.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('$operation',
                        style: TextStyle(
                            fontSize: 30, color: Colors.white54
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    (lastVal == '=' && resultat != 0) ||
                        (number.length > 0 && (lastVal == '+' || lastVal == '-'
                            || lastVal == 'X' || lastVal == '÷')) ||
                        (number.length == 1 && lastVal != '%')
                        ? Text('') : resultat == null ? Text(
                      '0', style: TextStyle(
                        fontSize: 50, color: Colors.white
                    ),
                    ) : Text('$resultat',
                        style: TextStyle(
                            fontSize: 50, color: Colors.white
                        )),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView(
              padding: const EdgeInsets.only(left: 25, right: 25),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ),
              children: myValue.keys
                  .map((e) =>
                  Card(
                    color: e == '+' || e == '-' || e == 'X' || e == '-' ||
                        e == '÷' || e == '=' ?
                    Colors.orangeAccent : e == 'AC' || e == 'C' || e == '%'
                        ? Color(0x80B0A9B0)
                        :
                    Color(0x805E5E88),
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45)),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(45),
                        onTap: () {
                          calculatrice(myValue[e]);
                          setState(() {

                          });
                        },
                        child: e == 'C' || e == '%' ?
                        Center(
                          child: Text(e, style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20, color: Colors.white54)),
                        ) : e == 'AC' ?
                        const Center(child: Icon(Icons.backspace_outlined,
                          color: Colors.white54,)) :
                        Center(
                          child: Text(e, style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20, color: Colors.white),),
                        )
                    ),
                  ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
