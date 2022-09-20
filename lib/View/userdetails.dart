import 'dart:convert';

import 'package:api_with_provider/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserDetailsView extends StatefulWidget {
  const UserDetailsView({Key? key}) : super(key: key);

  @override
  State<UserDetailsView> createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsView> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUsersData() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("USer data"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getUsersData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: userList.length,
                          itemBuilder: (context, index) {
                            return Container(
                                height: 150,
                                child: Column(
                                  children: [
                                    Text(userList[index]
                                        .address!
                                        .city
                                        .toString()),
                                  ],
                                ));
                          });
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Icon(Icons.error),
                      );
                    } else if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    } else {
                      return Text("No internet");
                    }
                  }))
        ],
      ),
    );
  }
}
