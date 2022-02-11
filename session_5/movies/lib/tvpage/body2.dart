import 'package:flutter/material.dart';
import 'categories.dart';
import 'tvpage.dart';
import 'package:movies/constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const CategoryList(),
        TVPage(topic: Constant.Mcategories[0]),
      ],
    );
  }
}
