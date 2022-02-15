import 'dart:core';

class SearchResult {
  String id;
  String resultType;
  String image;
  String title;
  String description;

  SearchResult(
      {this.id = "tt",
      this.resultType = "",
      this.image = "",
      this.title = "",
      this.description = ""});
}
