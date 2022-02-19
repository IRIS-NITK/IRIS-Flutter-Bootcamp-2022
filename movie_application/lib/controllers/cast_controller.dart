
import 'dart:convert';

import 'package:get/get.dart';
import 'package:movie_application/controllers/list_disp_controller.dart';
import 'package:movie_application/models/cast_model.dart';
import 'package:http/http.dart' as http;

class CastController extends GetxController {
  final ListDispController listDispController = Get.find();
  var castList = RxList<CastModel>().obs;

  void setCastList({String id = ""}) async {
    String url = "https://imdb-api.com/en/API/FullCast/k_mrk8davb/${id}";
    var response = await http.get(Uri.parse(url));
    var mapResponse;
    var listCast;

    if (response.statusCode != 200) {
      throw Exception();
    } else {
      mapResponse = jsonDecode(response.body);
      listCast = mapResponse["actors"].toList();
    }

    castList.value.clear();
    for (int i = 0; i < listCast.length; i++) {
      CastModel castModel = CastModel(
        image: listCast[i]["image"],
        name: listCast[i]["name"],
        asChar: listCast[i]["asCharacter"],
      );
      castList.value.add(castModel);
    }
  }
}
