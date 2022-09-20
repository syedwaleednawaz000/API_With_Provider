import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/photo_model.dart';

class PhotoView extends StatefulWidget {
  const PhotoView({Key? key}) : super(key: key);

  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  List<Photos> photoList = [];

  Future<List<Photos>> getPhoto() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    print(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photes =
        Photos(title: i['title'], url: i['url'], id: i['id']);
        photoList.add(photes);
      }
      return photoList;
    } else {
      return photoList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(child: FutureBuilder(
              future: getPhoto(),
              builder: (ctx,AsyncSnapshot<List<Photos>> snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                      itemCount: photoList.length,
                      itemBuilder: (ctx, index) {
                        return Container(
                          child: Text(photoList[index].title),
                        );
                      });
                }
                else {
                  return Text("Eror");
                }
              })),
        ],
      ),
    );
  }
}


