import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies/bloc/movie_bloc.dart';
import "package:movies/constants.dart";

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeCubit, bool>(
        listener: (context, value) {},
        builder: (context, dark) {
          return Container(
            decoration:
                BoxDecoration(color: (dark) ? Colors.black : Colors.white),
            alignment: Alignment.center,
            height: 100,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Constant.Tcategories.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 20),
                      child:
                          BlocBuilder<TVCubit, int>(builder: (context, value) {
                        return GestureDetector(
                          onTap: () {
                            context.read<TVCubit>().update(index);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                Constant.Tcategories[index],
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                  color: (dark)
                                      ? (index == value
                                          ? Colors.white
                                          : Colors.white.withOpacity(0.5))
                                      : (index == value
                                          ? Colors.black
                                          : Colors.black.withOpacity(0.5)),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                width: 40,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: (dark)
                                      ? (index == value
                                          ? Colors.deepOrange
                                          : Colors.transparent)
                                      : (index == value
                                          ? Colors.purple[600]
                                          : Colors.transparent),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          ),
                        );
                      }));
                }),
          );
        });
  }
}
