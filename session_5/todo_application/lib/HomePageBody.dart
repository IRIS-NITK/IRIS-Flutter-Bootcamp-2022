//KARKALA SRINIVASA VENKATARAMANA
//OM JAI DURGE MAA

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_application/HomePageSkeleton.dart';
import 'package:todo_application/models/lists.dart';
import 'package:todo_application/widgets/widgetGetter.dart';

class ViewOfHomePage extends StatefulWidget {
  const ViewOfHomePage({Key? key}) : super(key: key);

  @override
  _ViewOfHomePageState createState() => _ViewOfHomePageState();
}

class _ViewOfHomePageState extends State<ViewOfHomePage> {
  var wg = WidgetGetter();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column( 
          crossAxisAlignment: CrossAxisAlignment.start,
          //shrinkWrap: true,
          //physics: ScrollPhysics(),
          children: [
            Container(
              child: Text(
                "Today's Tasks",
                style: TextStyle(fontSize: 60),
              ),
            ),
            
              //height: 250,
              Container(
                margin: EdgeInsets.only(left: 30,right: 30),
                height: 250,
                width: 400,
                child: ValueListenableBuilder(
                  valueListenable: listsBox.listenable(),
                  builder: (context, Box<Lists> listsBox, _) {
                    if (listsBox.values.isEmpty)
                      return Center(
                        child: Text(
                          "No Tasks For Today!",
                          style: TextStyle(fontSize: 30,),
                          textAlign: TextAlign.center,
                        ),
                      );
                    return ListView.builder(
                        shrinkWrap: true,
                        //physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: listsBox.length,
                        itemBuilder: (context, index) {
                          Lists? lists = listsBox.getAt(index);
                          var nmList = lists?.title;
                          var descList = lists?.desc;
                          DateTime? liD = lists?.listDate;
                          if (int.parse((liD?.difference(DateTime.now()).inDays)
                                  .toString()) ==
                              0) {
                            return wg.generateListCard(
                              context,
                              lists,
                              index,
                              liD,
                            );
                          } else
                            return Container();
                        });
                  },
                ),
              ),
            
            Divider(),
            Container(
              child: Text(
                "All Tasks",
                style: TextStyle(fontSize: 60.0),
              ),
            ),
            
              //height: 300,
              Container(
                height: 380,
                child: ValueListenableBuilder(
                  valueListenable: listsBox.listenable(),
                  builder: (context, Box<Lists> listsBox, _) {
                    if (listsBox.values.isEmpty)
                      return Center(
                        child: Text(
                          "No Tasks Found!",
                          style: TextStyle(fontSize: 30),
                        ),
                      );
                    return ListView.builder(
                        //shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: listsBox.length,
                        itemBuilder: (context, index) {
                          Lists? lists = listsBox.getAt(index);
                          var nmList = lists?.title;
                          var descList = lists?.desc;
                          DateTime? liD = lists?.listDate;
                          return wg.generateListCard(
                            context,
                            lists,
                            index,
                            liD,
                          );
                        });
                  },
                ),
              ),
            
          ],
        ),
      ),
    );
  }
}
