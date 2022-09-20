import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserDetailsWithoutModel extends StatefulWidget {
  const UserDetailsWithoutModel({Key? key}) : super(key: key);

  @override
  State<UserDetailsWithoutModel> createState() =>
      _UserDetailsWithoutModelState();
}

class _UserDetailsWithoutModelState extends State<UserDetailsWithoutModel> {
  var data;

  Future<void> getUserData() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: FutureBuilder(
              future: getUserData(),
              builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (ctx, index){
                return Text(data[index]['name']);
              });
            }
          }))
        ],
      ),
    );
  }
}
