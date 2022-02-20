import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movies_app/movie_models/movie.dart';

class CastScreen extends StatefulWidget {
  const CastScreen({Key? key, required this.movieCast}) : super(key: key);

  final MovieCast movieCast;

  @override
  _CastScreenState createState() => _CastScreenState();
}

class _CastScreenState extends State<CastScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movieCast.movie.title.toString()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (){
          SchedulerBinding.instance?.addPostFrameCallback((_) {
            Navigator.pop(context);
          });
          },
        ),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Image.network(
                    widget.movieCast.movie.image,
                    height: MediaQuery.of(context).size.width,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                    fit: BoxFit.fill
                  ),
                )
              ),
              const SizedBox(
                height: 30
              ),
              Text(
                  "IMDb rating : ${widget.movieCast.movie.rating}",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text(
                    " Actors",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  )
                ],
              ),
              Container(
                height: 200.0,
                child: ListView.separated(
                  padding: const EdgeInsets.all(15.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.movieCast.actorsList.length <= 6 ? widget.movieCast.actorsList.length : 6,
                    separatorBuilder: (context, _) => const SizedBox(width: 20),
                    itemBuilder: (context, i){
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                          width: 110,
                          child: Column(
                            children: [
                               AspectRatio(
                                 aspectRatio: 4 / 3,
                                 child: ClipRRect(
                                   borderRadius: BorderRadius.circular(20.0),
                                   child: Image.network(
                                       widget.movieCast.actorsList[i].image,
                                     fit: BoxFit.cover
                                   ),
                                 ),
                               ),
                              const SizedBox(
                                height: 4,
                              ),
                              ListTile(
                                  title: Text(
                                    widget.movieCast.actorsList[i].name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                    ),
                                  ),
                                  subtitle: Text(
                                      "(${widget.movieCast.actorsList[i].asCharater})",
                                    style: const TextStyle(
                                      fontSize: 12
                                    ),
                                  )
                              )
                          ]
                            ),
                        ),
                      );
                    }
              )
              ),
              const SizedBox(
                height: 10
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    " Directed by  ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                  const SizedBox(
                    width: 15
                  ),
                  Text(
                    "${widget.movieCast.directorsList[0].name}",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 22
                    )
                  )
                ],
              ),
              const SizedBox(
                height: 20
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    " Written by   ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                  ),
                  const SizedBox(
                      width: 15
                  ),
                  Text(
                      "${widget.movieCast.writersList[0].name}",
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 20
                      )
                  ),
                ],
              ),
              const SizedBox(
                  height: 20
              ),
              otherCastWidget(actorList: widget.movieCast.actorsList)
            ]
          ),
        )
    );
  }
}

class otherCastWidget extends StatefulWidget {
  otherCastWidget({Key? key, required this.actorList}) : super(key: key) {
    fillString();
  }

  void fillString() {
    for(int i = 6; i < ((actorList.length <= 12) ? actorList.length : 12); i++){
        otheractors += "${actorList[i].name},  ";
    }
    otheractors = otheractors.substring(0, otheractors.length - 3);
  }

  final List<Actor> actorList;
  String otheractors = "";

  @override
  _otherCastWidgetState createState() => _otherCastWidgetState();
}

class _otherCastWidgetState extends State<otherCastWidget> {
  @override
  Widget build(BuildContext context) {

    if(widget.actorList.length > 6) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
              " Other Actors",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              )
          ),
          const SizedBox(
              width: 15
          ),
          Flexible(
            child: Container(
              height: 100,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  widget.otheractors,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey
                  ),
                ),
              ),
            ),
          )
        ],
      );
    }
    else{
      return Text("");
    }
  }
}

