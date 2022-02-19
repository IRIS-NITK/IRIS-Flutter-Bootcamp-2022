
import 'package:flutter/material.dart';
import 'package:movie_application/controllers/list_disp_controller.dart';
import 'package:movie_application/widgets/widgets.dart';
import 'package:get/get.dart';

class TVShowsListDisp extends StatefulWidget {
  const TVShowsListDisp({Key? key}) : super(key: key);

  @override
  _TVShowsListDispState createState() => _TVShowsListDispState();
}

class _TVShowsListDispState extends State<TVShowsListDisp> {
  HomeScreenWidgets widgets = HomeScreenWidgets();
  final ListDispController listDispController1 = Get.find();

  @override
  void initState() {
    listDispController1.setTV();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20.0),
            child: const Text("Top 5 Picks",style: TextStyle(fontFamily: "Dongle", fontSize: 60.0)),
          ),
          Container(
              child: Obx(() => listDispController1.tvShowList.value.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                    height: 220,
                    width: 430,
                    child: PageView.builder(
                        controller: PageController(viewportFraction: 0.88),
                        itemCount: listDispController1.tvShowList.value.length -
                            listDispController1.tvShowList.value.length +
                            5,
                        itemBuilder: (context, index) {
                          return widgets.pageCard(index: index, movie: false);
                        }),
                  ))),
          Container(
            height: 30.0,
          ),Container(
                  margin: const EdgeInsets.only(left: 20.0),
                  child: const Text(
                    "All Time Hits",
                    style: TextStyle(
                      fontFamily: "Dongle",
                      fontSize: 60.0,
                    ),
                  ),
                ),
          Container(
              height: 350,
              child: Obx(() => listDispController1.tvShowList.value.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: listDispController1.tvShowList.value.length - 5,
                      itemBuilder: (context, index) {
                        return widgets.listCard(index: index + 5, movie: false);
                      }))),
        ],
      ),
    );
  }
}
