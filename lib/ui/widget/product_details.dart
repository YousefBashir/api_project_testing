import 'package:api_project/providers/my_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, x) {
      return Scaffold(
        appBar: AppBar(backgroundColor: Colors.white,
        elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
                flex: 2,
                child: CachedNetworkImage(
                  imageUrl: provider.selectedProduct.image,
                )),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.selectedProduct.title,
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Details',
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(provider.selectedProduct.description),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Price"),
                              Text(
                                provider.selectedProduct.price.toString(),
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          RaisedButton(
                            color:Colors.green[500],
                            onPressed: () {},
                            child: Text(
                              'ADD',
                              style: TextStyle(color: Colors.green[50],fontSize: 18,fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),

                    ],
                  )),
            ),
          ],
        ),
      );
    });
  }
}
