import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NewUserScreen extends StatelessWidget {
  NewUserScreen({Key? key}) : super(key: key);

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  Future<void> addUser() async {
    String name = _nameController.text;
    int age = int.parse(_ageController.text);
    var url = Uri.parse(
        "https://crudcrud.com/api/1d2767fae2224742aeca4fcdf5b73364/users");
    var body = jsonEncode({"name": name, "age": age});
    final response = await http.post(url,
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: body);
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New User"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: "Enter your name"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _ageController,
              decoration: const InputDecoration(hintText: "Enter your age"),
            ),
            const SizedBox(
              height: 10,
            ),
            OutlinedButton(
              onPressed: () async {
                await addUser();
                Navigator.pop(context);
              },
              child: const Text("Add User"),
            ),
          ],
        ),
      ),
    );
  }
}
