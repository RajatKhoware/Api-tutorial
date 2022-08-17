// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/User_model.dart';
import '../widgets/reuseable_row.dart';

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({Key? key}) : super(key: key);

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  // Doing this bcus we dont have a name of array !!
  List<UserModel> userlist = [];

  Future<List<UserModel>> getUserApi() async {
    // Getting the response by the help of http.get from the link of json
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    // Decoding the data we got form http.get in the form of json.
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      userlist.clear();
      // Mapping the jsoncode
      for (Map i in data) {
        // form mapping creating an object.
        userlist.add(UserModel.fromJson(i));
      }
      return userlist;
    } else {
      return userlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Learn API"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
              builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: userlist.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReuseableRow(title: "Name :-", value: snapshot.data![index].name.toString()),
                            ReuseableRow(title: "UserName :-", value: snapshot.data![index].username.toString()),
                            ReuseableRow(title: "Email :-", value: snapshot.data![index].email.toString()),
                            ReuseableRow(title: "Address :-", value: snapshot.data![index].address!.city.toString()),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
