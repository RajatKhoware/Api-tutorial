import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../widgets/reuseable_row.dart';

class ExampleFour extends StatefulWidget {
  const ExampleFour({Key? key}) : super(key: key);

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}

class _ExampleFourState extends State<ExampleFour> {
  // If we dont want to create a model we use this type of function to implement API's.
  // ignore: prefer_typing_uninitialized_variables
  var data;
  Future<void> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
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
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReuseableRow(
                                title: "Name      ",
                                value: data[index]['name'].toString()),
                            ReuseableRow(
                                title: "Username  ",
                                value: data[index]['username'].toString()),
                            ReuseableRow(
                                title: "Address    ",
                                value: data[index]['address']['street']
                                    .toString()),
                            ReuseableRow(
                                title: "Gep Lat    ",
                                value: data[index]['address']['geo']['lat']
                                    .toString()),
                            ReuseableRow(
                                title: "Geo Lag    ",
                                value: data[index]['address']['geo']['lng']
                                    .toString()),
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


