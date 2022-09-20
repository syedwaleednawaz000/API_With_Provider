import 'dart:convert';

import 'package:api_with_provider/model/PostModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<PostModel> postList = [];

  Future<List<PostModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      postList.clear();
      for (Map i in data) {
        postList.add(PostModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getPostApi(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text("Error");
                    } else {
                      return ListView.builder(
                          itemCount: postList.length,
                          itemBuilder: (ctx, index) {
                            return Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("title: ${postList[index].title}"),
                                  Text("Description: ${postList[index].body}"),
                                  Divider(color: Colors.black,),
                                ],
                              ),
                            );
                          });
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
