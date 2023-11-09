class Movie {
  late String id, title, image, rating, ratingCount, year, rank, cast;
  Movie(
      {required this.id,
      required this.title,
      required this.image,
      required this.rating,
      required this.ratingCount,
      required this.year,
      this.cast = "",
      this.rank = "no"});
}
