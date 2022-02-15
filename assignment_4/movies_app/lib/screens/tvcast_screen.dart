import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movies_app/movie_models/movie.dart';

class TVShowCastScreen extends StatefulWidget {
  const TVShowCastScreen({Key? key, required this.showCast}) : super(key: key);

  final ShowCast showCast;

  @override
  _TVShowCastScreenState createState() => _TVShowCastScreenState();
}

class _TVShowCastScreenState extends State<TVShowCastScreen> {

  List<bool> expansionPanels = [false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.showCast.show.title.toString()),
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
                          widget.showCast.show.image,
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
                  "IMDb rating : ${widget.showCast.show.rating}",
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
                        itemCount: widget.showCast.actorsList.length <= 6 ? widget.showCast.actorsList.length : 6,
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
                                            widget.showCast.actorsList[i].image,
                                            fit: BoxFit.cover
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    ListTile(
                                        title: Text(
                                          widget.showCast.actorsList[i].name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                          ),
                                        ),
                                        subtitle: Text(
                                          "(${widget.showCast.actorsList[i].asCharater})",
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
                ExpansionPanelList(
                  children: [
                    ExpansionPanel(
                        headerBuilder: (context, isopen){
                          return const Text(
                            " Directors",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                          );
                        },
                        body: directorWidget(directorlist: widget.showCast.directorsList),
                      canTapOnHeader: true,
                      isExpanded: expansionPanels[0]
                    ),
                    ExpansionPanel(
                        headerBuilder: (context, isopen){
                          return const Text(
                            " Writers",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
                          );
                        },
                        body: writerWidget(writerlist: widget.showCast.writersList),
                        canTapOnHeader: true,
                        isExpanded: expansionPanels[1]
                    ),
                  ],
                  expansionCallback: (i, isExpanded){
                    setState(() {
                      expansionPanels[i] = !expansionPanels[i];
                    });
                  },
                ),
                /*Row(
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
                        "${widget.showCast.directorsList[0].name}",
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
                        "${widget.showCast.writersList[0].name}",
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 20
                        )
                    ),
                  ],
                ),
                const SizedBox(
                    height: 20
                ),*/
                otherShowCastWidget(actorList: widget.showCast.actorsList)
              ]
          ),
        )
    );
  }
}

class otherShowCastWidget extends StatefulWidget {
  otherShowCastWidget({Key? key, required this.actorList}) : super(key: key) {
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
  _otherShowCastWidgetState createState() => _otherShowCastWidgetState();
}

class _otherShowCastWidgetState extends State<otherShowCastWidget> {
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
      return const Text("");
    }
  }
}

class directorWidget extends StatefulWidget {
  directorWidget({Key? key, required this.directorlist}) : super(key: key){
    fillString();
  }

  void fillString()
  {
    for(Director x in directorlist){
      directorString += "  ${x.name}  ${x.description}\n" ;
    }
  }

  final List<Director> directorlist;
  String directorString = "";

  @override
  _directorWidgetState createState() => _directorWidgetState();
}

class _directorWidgetState extends State<directorWidget> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            child: Text(
              widget.directorString,
              style: const TextStyle(
                fontSize: 19,
                color: Colors.grey
            ),
            ),
          ),
        )
    );
  }
}

class writerWidget extends StatefulWidget {
  writerWidget({Key? key, required this.writerlist}) : super(key: key){
    fillString();
  }

  final List<Writer> writerlist;
  String writerString = "";

  void fillString()
  {
    for(Writer x in writerlist){
      writerString += "  ${x.name}  ${x.description}\n" ;
    }
  }


  @override
  _writerWidgetState createState() => _writerWidgetState();
}

class _writerWidgetState extends State<writerWidget> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Container(
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
                widget.writerString,
              style: const TextStyle(
                fontSize: 19,
                color: Colors.grey
              ),
            ),
          ),
        )
    );
  }
}



