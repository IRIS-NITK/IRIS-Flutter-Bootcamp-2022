class Movie{
  Movie(this.id, this.title, this.year, this.image, this.rating);

  final id;
  final title;
  final year;
  final image;
  final rating;

}

class TVShow{
  TVShow(this.id, this.title, this.year, this.image, this.rating, this.crew);

  final id;
  final title;
  final year;
  final image;
  final rating;
  final crew;

}

class MovieCast{
  MovieCast(this.actors, this.directors, this.writers, this.movie){
    for(Map<String, dynamic> x in actors){
      actorsList.add(Actor(x["image"], x["name"], x["asCharacter"]));
    }

    for(Map<String, dynamic> x in directors){
      directorsList.add(Director(x["name"], ""));
    }

    for(Map<String, dynamic> x in writers){
      writersList.add(Writer(x["name"], ""));
    }
  }

  final Movie movie;
  final actors;
  final directors;
  final writers;

  List<Actor> actorsList = [];
  List<Director> directorsList = [];
  List<Writer> writersList = [];


}

class ShowCast{
  ShowCast(this.actors, this.directors, this.writers, this.show){
    for(Map<String, dynamic> x in actors){
      actorsList.add(Actor(x["image"], x["name"], x["asCharacter"]));
    }

    for(Map<String, dynamic> x in directors){
      directorsList.add(Director(x["name"],  x["description"]));
    }

    for(Map<String, dynamic> x in writers){
      writersList.add(Writer(x["name"],  x["description"]));
    }
  }

  List<Actor> actorsList = [];
  List<Director> directorsList = [];
  List<Writer> writersList = [];

  final TVShow show;
  final actors;
  final directors;
  final writers;

}

class Actor{
  Actor(this.image, this.name, this.asCharater);

  final image;
  final name;
  final asCharater;

}

class Director{
  Director(this.name, this.description);

  final name;
  final description;
}

class Writer{
  Writer(this.name, this.description);

  final name;
  final description;
}