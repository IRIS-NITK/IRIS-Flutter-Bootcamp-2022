import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_app/ui/pages/movie_page/widgets.dart';
import 'package:movies_app/ui/pages/home_page/widgets.dart';
import 'package:movies_app/ui/pages/tvs_page/widgets.dart';


class NavbarCubit extends Cubit<List> {

  List widgetList = [home,Top250.movie,tvs];
  List pageTitleList = ["IMDb Movies App","Movies","TV Shows"];

  NavbarCubit() : super([0,home,"IMDb Movies App",""]);

  void navPage(int index){
    var searchText = state[3];
    List list = [index,widgetList[index],pageTitleList[index],searchText];
    emit(list);
  }
  void search(String searchText){
    List list = state;
    list[3] = searchText;
    emit(list);
  }
}
