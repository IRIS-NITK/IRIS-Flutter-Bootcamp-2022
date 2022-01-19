import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:networking_app/new_user_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Networking App',
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List users = [];

  void getUsers() async {
    var url = Uri.parse(
        "https://crudcrud.com/api/1d2767fae2224742aeca4fcdf5b73364/users");
    final response = await http.get(url);
    final body = jsonDecode(response.body);
    print(body);
    users = body;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Networking App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              users.isNotEmpty
                  ? Column(
                      children: users
                          .map(
                            (user) => Container(
                              margin:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Text(
                                  "Name: ${user["name"]}  Age: ${user["age"]}"),
                            ),
                          )
                          .toList(),
                    )
                  : const Text("No users"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      getUsers();
                    },
                    child: const Text("Get Users"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return NewUserScreen();
                        }),
                      );
                    },
                    child: const Text("New User"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
