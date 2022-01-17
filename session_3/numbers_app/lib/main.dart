import 'package:flutter/material.dart';

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
      // theme: ThemeData.from(colorScheme: ColorScheme.fromSwatch(
      //   primarySwatch: Colors.deepOrange,
      //   backgroundColor: Colors.white,
      // )),
      theme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _request = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Number Trivia", style: TextStyle(fontSize: 25),),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            const SizedBox(
              height: 70,
            ),

            const Text(
              "Tell me something about the number :",
              style: TextStyle(fontSize: 28),
              textAlign: TextAlign.center,
            ),

            const SizedBox(
              height: 30,
            ),

            const TextField(
              decoration: InputDecoration(
                labelText: "Enter a number",
                labelStyle: TextStyle(fontSize: 25,fontStyle: FontStyle.italic,color: Colors.deepOrange),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepOrange)),
                
                
              ),
              style: TextStyle(fontSize: 25,),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
      
            const SizedBox(
              height: 60,
            ),
      
            ElevatedButton(
              onPressed: (){},
              style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Enter",style: TextStyle(fontSize: 25,),),
              ),
            ),

            const SizedBox(
              height: 60,
            ),

            Text(
            _request  == true ? 'Something about the number' : '',
              style: const TextStyle(fontSize: 27),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ), 
    );
  }
}