import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class NewScreenT extends StatefulWidget {
  final String fact;
  final String numberText;
  final int choice;
  final bool random;

  const NewScreenT(
      {Key? key,
      required this.fact,
      required this.numberText,
      required this.choice,
      required this.random})
      : super(key: key);

  @override
  State<NewScreenT> createState() => _NewScreenState();
}

class _NewScreenState extends State<NewScreenT> {
  late String factString;

  Future<String> getFact(String numberInput, int choice) async {
    String type = "h";
    Uri url;
    // bool randomFlag = false;

    // String type = "h";

    if (choice == 1) {
      type = "trivia";
    } else {
      if (choice == 2) {
        type = "math";
      } else {
        if (choice == 3) {
          type = "date";
        } else {
          if (choice == 4) {
            type = "year";
          } else {
            type = "Random";
          }
        }
      }
    }

    // else{
    //   url = Uri.parse("http://numbersapi.com/" + numberInput + "/"+ type);
    // }

    if (widget.random) {
      url = Uri.parse("http://numbersapi.com/random/" + numberInput);
    } else {
      url = Uri.parse("http://numbersapi.com/" + numberInput + "/" + type);
    }

    final response = await http.get(url);

    setState(() {
      factString = response.body;
    });

    // print(url);
    // print(response.body);

    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fun Fact"),
        backgroundColor: Colors.indigoAccent.shade100,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text(
                      widget.random != 5
                          ? "Here's a fun fact about the number ${widget.numberText}"
                          : "Here's a random fun fact ",
                      style: GoogleFonts.lobster(fontSize: 20)),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: Text(widget.fact,
                    // textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: GoogleFonts.vollkorn(fontSize: 23)),
              ),
              const SizedBox(
                height: 40,
              ),
              widget.choice != 3
                  ? Column(
                      children: [
                        !widget.random
                            ? const Text("Wanna know a different fact")
                            : const Text("Wanna know a different random fact"),
                        const Text("Choose one of the following"),
                      ],
                    )
                  : Row(),
              const SizedBox(
                height: 15,
              ),
              widget.choice != 3
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        widget.choice == 1
                            ? const Text('')
                            : OutlinedButton(
                                onPressed: () async {
                                  String fact2 = await getFact(
                                      widget.random
                                          ? "trivia"
                                          : widget.numberText,
                                      1);

                                  setState(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewScreenT(
                                                fact: fact2,
                                                choice: 1,
                                                numberText: widget.numberText,
                                                random: widget.random,
                                              )),
                                    );
                                  });
                                },
                                child: const Text("Trivia")),
                        const SizedBox(
                          width: 10,
                        ),
                        widget.choice == 2
                            ? const Text('')
                            : OutlinedButton(
                                onPressed: () async {
                                  String fact2 = await getFact(
                                      widget.random
                                          ? "math"
                                          : widget.numberText,
                                      2);

                                  setState(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewScreenT(
                                                fact: fact2,
                                                choice: 2,
                                                numberText: widget.numberText,
                                                random: widget.random,
                                              )),
                                    );
                                  });
                                },
                                child: const Text("Math")),
                        const SizedBox(
                          width: 10,
                        ),
                        // widget.random
                        //     ? const Text('')
                        //     : OutlinedButton(
                        //         onPressed: () async {
                        //           String fact2 = await getFact(widget.random==true?"date" : widget.numberText, 3);

                        //           setState(() {
                        //             Navigator.push(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (context) => NewScreenT(
                        //                         fact: fact2,
                        //                         choice: 3,
                        //                         numberText: widget.numberText,
                        //                         random: widget.random,
                        //                       )),
                        //             );
                        //           });
                        //         },
                        //         child: const Text("Date")),
                        // const SizedBox(
                        //   width: 10,
                        // ),
                        widget.choice == 4
                            ? const Text('')
                            : OutlinedButton(
                                onPressed: () async {
                                  String fact2 = await getFact(
                                      widget.random
                                          ? "year"
                                          : widget.numberText,
                                      4);

                                  setState(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewScreenT(
                                                fact: fact2,
                                                choice: 4,
                                                numberText: widget.numberText,
                                                random: widget.random,
                                              )),
                                    );
                                  });
                                },
                                child: const Text("Year")),
                      ],
                    )
                  : Row(),
            ],
          ),
        ),
      ),
    );
  }
}
