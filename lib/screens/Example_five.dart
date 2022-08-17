import 'dart:convert';

import 'package:api_tutorial/Models/products_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExFive extends StatefulWidget {
  const ExFive({Key? key}) : super(key: key);

  @override
  State<ExFive> createState() => _ExFiveState();
}

class _ExFiveState extends State<ExFive> {
  Future<ProductsModel> getProductsApi() async {
    final res = await http.get(
        Uri.parse("https://webhook.site/568b40b7-a987-46c6-aa67-6026e847d19b"));
    var data = jsonDecode(res.body.toString());
    if (res.statusCode == 200) {
      return ProductsModel.fromJson(data);
    } else {
      return ProductsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Learn API's"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<ProductsModel>(
              future: getProductsApi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * .3,
                            width: MediaQuery.of(context).size.width * 1,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                                itemCount:
                                    snapshot.data!.data![index].products![index].images!.length,
                                itemBuilder: (context, position) {
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        .25,
                                    width:
                                        MediaQuery.of(context).size.width * .5,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(image: NetworkImage(snapshot.data!.data![index].products![index].images![position].url.toString()))
                                    ),
                                  );
                                }),
                          )
                        ],
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
