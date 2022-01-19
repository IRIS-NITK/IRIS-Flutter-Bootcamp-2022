import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:numbers_app/theme.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(ChangeNotifierProvider(
    child: const MyApp(),
    create: (BuildContext context) => ThemeProvider(isDarkMode: true),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeProvider.getTheme,
        home: const MyHomePage(),
      );
      },
    );
  }
}



class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var _request = false;
  var _text = 'Something';
  var _valid = true;

  final _number = TextEditingController();

  String dropDownValue = "/";

  void getInfo() async {

    _valid = _number.text.isEmpty ? false : true ;



    if(_valid){

      var url = Uri.parse("http://numbersapi.com/${_number.text}/${dropDownValue == "/"?'':dropDownValue}");
      final response = await http.get(url);
      final body = response.body.toString();


      setState(() {
        _text = body;
        _request = true;
        
      });
    }
    else{
      var url = Uri.parse("http://numbersapi.com/random/${dropDownValue == "/"?'':dropDownValue}");
      final response = await http.get(url);
      final body = response.body.toString();

      setState(() {
        _text = body;
        _request = true;
        
      });
    }
  }



  @override
  Widget build(BuildContext context) {
	
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Numbers!!", style: TextStyle(fontSize: 25),),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6_sharp),
            color: Colors.white,
            onPressed: (){
              ThemeProvider themeProvider = Provider.of<ThemeProvider>(context,listen: false);
              themeProvider.swapTheme();
            },
          ),
        ],
        backgroundColor: Colors.deepOrange,
        ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Mode:", style: TextStyle(fontSize: 20),),

                const SizedBox(width: 10,),

                DropdownButton<String>(
                  value: dropDownValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  style: const TextStyle(fontSize: 20, color: Colors.deepOrange),
                  onChanged: (String? newValue){
                    setState(() {
                      dropDownValue = newValue!;
                      
                    });
                  },
                  items: <String>["/","trivia","year","math"]
                  .map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value == "/" ? "all" : value),
                      );
                    }
                  ).toList(),
                ),
              ],
            ),

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

            TextField(
              controller: _number,
              decoration: InputDecoration(
                labelText: "Enter a number",
                labelStyle: const TextStyle(fontSize: 25,fontStyle: FontStyle.italic,color: Colors.deepOrange),
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.deepOrange)),
                errorText: _valid ? '' : "Showing random number",
                errorStyle: const TextStyle(fontSize: 25,fontStyle: FontStyle.italic,),
              ),

              style: const TextStyle(fontSize: 25,),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
      
            const SizedBox(
              height: 60,
            ),
      
            ElevatedButton(
              onPressed: getInfo,
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
              _request ? _text : '',
              style: const TextStyle(fontSize: 27,fontStyle: FontStyle.italic,fontFamily: "Oswald"),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ), 
    );
  }
}