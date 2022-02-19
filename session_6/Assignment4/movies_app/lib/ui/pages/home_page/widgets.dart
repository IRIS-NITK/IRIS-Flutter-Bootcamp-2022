/*
    This File handles the Widgets of the home page
*/

import 'package:flutter/material.dart';
import 'api.dart';



// AppBar Widget ======================================

AppBar appBar = AppBar(
  title: Text('IMDb Movies App'),
);

// ====================================================









// Future Popular Movies Widget ==============================

FutureBuilder popularMovies = FutureBuilder(
        future: getPopularMovies(),
        initialData: List.empty(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.connectionState == ConnectionState.done && snapshot.hasError){
            return Text(snapshot.error.toString());
          }
          else if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          else{
            return Container(
              height: 180,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                
                itemCount: snapshot.data!.length,
                separatorBuilder: (context, index) => SizedBox(width: 12,),
                itemBuilder: (context, index) {
                  var popularMovies = snapshot.data;
                  return InkWell(
                    onTap: () {},
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: popularMovies[index].image,
                    )
                  );
                },
              ),
            );
          }
        },
      );

// ====================================================


// Future Popular TVs Widget ==============================

FutureBuilder popularTvs = FutureBuilder(
        future: getPopularTvs(),
        initialData: List.empty(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.connectionState == ConnectionState.done && snapshot.hasError){
            return Text(snapshot.error.toString());
          }
          else if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          else{
            // ignore: sized_box_for_whitespace
            return Container(
              height: 180,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                
                itemCount: snapshot.data!.length,
                separatorBuilder: (context, index) => SizedBox(width: 12,),
                itemBuilder: (context, index) {
                  var popularTvs = snapshot.data;
                  return Builder(
                    builder: (context) {
                      return InkWell(
                        onTap: () {},
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: popularTvs[index].image,
                        ),
                      );
                    }
                  );
                },
              ),
            );
          }
        },
      );

// ====================================================



// Future Top 10 Movies Widget ==============================

FutureBuilder top10Movies = FutureBuilder(
        future: getTop10Movies(),
        initialData: List.empty(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.connectionState == ConnectionState.done && snapshot.hasError){
            return Text(snapshot.error.toString());
          }
          else if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          else{
            return Container(
              height: 180,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                
                itemCount: snapshot.data!.length,
                separatorBuilder: (context, index) => SizedBox(width: 12,),
                itemBuilder: (context, index) {
                  var top10Movies = snapshot.data;
                  return InkWell(
                    onTap: (){},
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: top10Movies[index].image,
                    
                    ),
                  );
                },
              ),
            );
          }
        },
      );

// ====================================================

// Popular Movies Widget ==============================

  var popularMoviesBuilder = Center(
  
    child: SingleChildScrollView(
  
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Popular Movies',style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                popularMovies,
              ],
            ),

            SizedBox(height: 5,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Popular TV Shows',style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                popularTvs,
              ],
            ),

            SizedBox(height: 5,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Top 10 Movies',style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
                top10Movies,
              ],
            ),
            
          ],
        ),
      ),
    )
  );

// ====================================================



  Widget home = Padding(
      padding: EdgeInsets.all(8),
      child: popularMoviesBuilder,
    );


