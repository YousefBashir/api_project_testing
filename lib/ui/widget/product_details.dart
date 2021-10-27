import 'package:api_project/providers/my_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, x) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          body: Consumer<HomeProvider>(
            builder: (context, provider, x) {
              return provider.selectedProduct == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: const Icon(Icons.favorite),
                              iconSize: 30,
                              onPressed: () {
                                provider
                                    .addToFavorite(provider.selectedProduct);
                              },
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: CachedNetworkImage(
                              imageUrl: provider.selectedProduct.image,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Expanded(
                              flex: 1,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      provider.selectedProduct.title,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      provider.selectedProduct.description,
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Price',
                                              style: TextStyle(fontSize: 17),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                                '\$${provider.selectedProduct.price.toString()}',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ],
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.orangeAccent,
                                                size: 40,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                '${provider.selectedProduct.rating.rate}',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                  '${provider.selectedProduct.rating.count} Reviews'),
                                              SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                        RaisedButton(
                                          onPressed: () {
                                            provider.addToCart(
                                                provider.selectedProduct);
                                          },
                                          color: Colors.green,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "ADD",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Icon(
                                                Icons.add_shopping_cart,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    );
            },
          ));
    });
  }
}
