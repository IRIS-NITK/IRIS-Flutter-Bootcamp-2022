import 'dart:core';

class TVShowData {
  String id;
  int rank;
  String title;
  String fullTitle;
  int year;
  String image;
  List<String> crew;
  double imdbRating;
  int imdbRatingCount;

  TVShowData
  ({
    this.id = "", 
    this.rank = 0, 
    this.title = "", 
    this.fullTitle = "", 
    this.year = 0,
    this.image = "", 
    this.crew = const ["", ""], 
    this.imdbRating = 0.0, 
    this.imdbRatingCount = 0
    });
}

