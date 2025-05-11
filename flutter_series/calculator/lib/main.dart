import 'package:flutter/material.dart';

void main() {
  runApp( MainApp());
}

class MainApp extends StatefulWidget {
   MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  String inputvalue = "";
  String calcvalue = "";
  String operator = "";

  @override
  Widget build(BuildContext context) {
    

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Calculator"),
          backgroundColor: Colors.greenAccent,
        ),
        backgroundColor: Colors.black,
        body: ListView(
          children: [

            
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(10),
              child: Text(inputvalue,style: TextStyle(color: Colors.white,fontSize: 50),),
            ),

            Column(
              children: [
                Row(
                  children: [
                    calcbutton(context, "7", Colors.grey),
                    calcbutton(context, "8", Colors.grey),
                    calcbutton(context, "9", Colors.grey),
                    calcbutton(context, "/", Colors.orange),
                  ],
                ),
                 Row(
                  children: [
                    calcbutton(context, "4", Colors.grey),
                    calcbutton(context, "5", Colors.grey),
                    calcbutton(context, "6", Colors.grey),
                    calcbutton(context, "x", Colors.orange),
                  ],
                ),
                 Row(
                  children: [
                    calcbutton(context, "1", Colors.grey),
                    calcbutton(context, "2", Colors.grey),
                    calcbutton(context, "3", Colors.grey),
                    calcbutton(context, "-", Colors.orange),
                  ],
                ),
                 Row(
                  children: [
                    calcbutton(context, "0", Colors.grey),
                    calcbutton(context, ".", Colors.grey),
                    calcbutton(context, "=", Colors.grey),
                    calcbutton(context, "+", Colors.orange),
                  ],
                ),
               
                   MaterialButton(
                    child: Text("Clear",style: TextStyle(color: Colors.white,fontSize: 25),),
                    onPressed: () {
                      setState(() {                    
                        inputvalue = "";
                      });
                    },
                  ),
                
              ],
              
            )
          ],
        ),
      ),
    );
  }
  Widget calcbutton(BuildContext context, String text, Color bgColor) {
  double size = MediaQuery.of(context).size.width / 8;
  double height = MediaQuery.of(context).size.height / 8;
  return InkWell(
    onTap: () {
  if (text == "x" || text == "/" || text == "-" || text == "+") {
    setState(() {
      calcvalue = inputvalue;
      inputvalue = "";
      operator = text;
    });
  } 
  else if (text == "=") {
    if (operator == "+") {
      setState(() {
        inputvalue = (double.parse(calcvalue) + double.parse(inputvalue)).toString();
      });
    } else if (operator == "-") {
      setState(() {
        inputvalue = (double.parse(calcvalue) - double.parse(inputvalue)).toString();
      });
    } else if (operator == "x") {
      setState(() {
        inputvalue = (double.parse(calcvalue) * double.parse(inputvalue)).toString();
      });
    } else if (operator == "/") {
      setState(() {
        inputvalue = (double.parse(calcvalue) / double.parse(inputvalue)).toString();
      });
    }
  } 
  else {
   
    setState(() {
      inputvalue += text;
    });
  }
}
  ,
  child: Container(
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(200)
    ),
    margin: EdgeInsets.all(10),
    height: height,
    width: size,
    alignment: Alignment.center,
    child: Text(text, style: TextStyle(color: Colors.white,fontSize: 30)),
  ),
);
}
}





