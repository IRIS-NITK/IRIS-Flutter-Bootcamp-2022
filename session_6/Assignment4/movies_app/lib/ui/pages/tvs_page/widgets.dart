/*
    This File handles the Widgets of the TVs page
*/

import 'package:flutter/material.dart';
import 'api.dart';



// AppBar Widget ======================================

AppBar appBar = AppBar(
  title: Text('Top 250 Movies'),
  centerTitle: true,
);

// ====================================================



FutureBuilder popularTVs = FutureBuilder(
        future: getTop250TVs(),
        initialData: List.empty(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.connectionState == ConnectionState.done && snapshot.hasError){
            return Text(snapshot.error.toString());
          }
          else if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          else{
            return ListView.builder(

              
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var popularTVs = snapshot.data;
                return Card(
                  child: ListTile(
                    leading: Image.network(popularTVs[index]["image"]),
                    title: Text("${index+1}.  ${popularTVs[index]["title"]}"),
                    tileColor: Colors.blue.shade100,
                  )
                );
              },
            );
          }
        },
      );

// ====================================================



  Widget tvs = Padding(
      padding: EdgeInsets.all(8),
      child: popularTVs
    );