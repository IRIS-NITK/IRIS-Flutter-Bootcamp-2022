import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MyHomePage(title: 'Number Trivia'),
    );
  }
}

//Stateless widget MyHomePage
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent[100],
      appBar: AppBar(
        leading: const Icon(Icons.auto_awesome_outlined),
        title: Text(
          title,
          style: GoogleFonts.comfortaa(),
        ),
      ),
      body: const InputWidget(),
    );
  }
}

//Widget for taking number input and passing to an api call

class InputWidget extends StatefulWidget {
  const InputWidget({Key? key}) : super(key: key);

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget>
    with TickerProviderStateMixin {
  late final AnimationController _ancontroller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _ancontroller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    _ancontroller.dispose();
    super.dispose();
  }

  final TextEditingController _controller = TextEditingController();
  final String _apiUrl = 'http://numbersapi.com/';
  String _numberTrivia = '';
  bool isLoading = false;

  _handleSubmit(String value) {
    if (value.isEmpty) {
      return;
    }
    final Uri url = Uri.parse('$_apiUrl$value');
    setState(() {
      isLoading = true;
    });
    http.get(url).then((value) => setState(() {
          if (value.statusCode == 200) {
            _numberTrivia = value.body;
          } else {
            _numberTrivia = 'Something went wrong';
          }
          isLoading = false;
          _controller.clear();
          _ancontroller.forward(from: 0);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                  controller: _controller,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.megrim(
                    textStyle: Theme.of(context).textTheme.headline4,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Enter a number',
                      hintStyle: TextStyle(color: Colors.white70),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0.0, style: BorderStyle.none))),
                  onSubmitted: _handleSubmit),
              getCardWidget(),
            ],
          ),
        ),
      );
    });
  }

  getCardWidget() {
    if (isLoading) {
      //return spinkit FadingCube
      return Container(
        margin: const EdgeInsets.only(top: 20.0),
        padding: const EdgeInsets.all(16.0),
        child: const SpinKitFadingCube(
          color: Colors.white,
          size: 30.0,
        ),
      );
    } else if (_numberTrivia.isNotEmpty) {
      return SizeTransition(
        sizeFactor: _animation,
        axis: Axis.vertical,
        axisAlignment: -1.0,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.pinkAccent[100],
          elevation: 0.5,
          margin: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: const LinearGradient(
                colors: [
                  Colors.red,
                  Colors.pink,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      _numberTrivia,
                      style: GoogleFonts.sacramento(
                        fontSize: 28.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return Container();
  }
}
