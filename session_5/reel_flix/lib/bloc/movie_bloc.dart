import 'package:flutter_bloc/flutter_bloc.dart';

class MovieCubit extends Cubit<int> {
  MovieCubit() : super(0);
  void update(int k) => emit(k);
}

class SearchCubit extends Cubit<String> {
  SearchCubit() : super("");
  void update(String s) => emit(s);
}

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false);
  void update(bool k) => emit(k);
}

class PageCubit extends Cubit<int> {
  PageCubit() : super(0);
  void update(int k) => emit(k);
}

class TVCubit extends Cubit<int> {
  TVCubit() : super(0);
  void update(int l) => emit(l);
}
