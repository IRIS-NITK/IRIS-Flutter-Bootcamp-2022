import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'drawer.dart';
import 'info_page.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final mycontroller = TextEditingController();

  var finres = " ";
 
  void getfacts() async {
    String x = mycontroller.text;
    var url = Uri.parse("http://numbersapi.com/$x");

   
    final response = await http.get(url);

    finres = response.body;
   
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Number Trivia",
            style: TextStyle(
              fontWeight: FontWeight.bold
            )),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 680,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/bg2.jpg"), fit: BoxFit.fill)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: "Enter The No.", labelText: "The No. "),
                    controller: mycontroller,
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120.0),
                child: OutlinedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.lightGreen)),
                    onPressed: getfacts,
                    child: Center(
                        child: const Text(
                      "Get Facts",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.white),
                    ))),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Center(
                  child: Text(
                finres,
                style: TextStyle(fontSize: 20),
              )),
            ],
          ),
        ),
      ),
      floatingActionButton: Infopage(),
      drawer: DrawerPage(),
    );
  }
}
