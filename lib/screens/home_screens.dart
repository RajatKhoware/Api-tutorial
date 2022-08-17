import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/PostsModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Doing this bcus we dont have a name of array !!
  List<PostsModel> postList = [];
  Future<List<PostsModel>> getPostApi() async {
    // Getting the response by the help of http.get from the link of json
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    // Decoding the data we got form http.get in the form of json.
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      postList.clear();
      // Mapping the jsoncode
      for (Map i in data) {
        // form mapping creating an object.
        postList.add(PostsModel.fromJson(i));
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
        title: const Text("Learn API"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "Title :-",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(postList[index].title.toString()),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              "Discription :-",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(postList[index].body.toString()),
                            const SizedBox(
                              height: 15,
                            ),
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
