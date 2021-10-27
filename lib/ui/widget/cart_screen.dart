import 'package:api_project/models/product_response.dart';
import 'package:api_project/providers/my_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      //appBar: AppBar(backgroundColor: Colors.white,elevation: 0,),
      body: Consumer<HomeProvider>(
        builder: (context, provider, x) {
          List<ProductResponse> carts = provider.cartProducts;
          return carts == null
              ? Center(
                  child: Text(
                    'No Products added to Cart',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                )
              : ListView.builder(
                  itemCount: carts.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 5, top: 5),
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height * 0.20,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 130,
                                child: CachedNetworkImage(
                                  imageUrl: carts[index].image,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 10),
                                child: Container(
                                  width: 170,
                                  height:
                                      MediaQuery.of(context).size.height * 0.20,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Spacer(),
                                      Text(
                                        carts[index].title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Spacer(),
                                      Text("\$" + carts[index].price.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green)),
                                      Spacer(),
                                      Text('Quantity: ' +
                                          carts[index].quantity.toString()),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                              IconButton(
                                  iconSize: 30,
                                  onPressed: () {
                                    provider.deleteCartProduct(carts[index].id);
                                  },
                                  icon: Icon(
                                    Icons.remove_shopping_cart,
                                    color: Colors.red,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  });
        },
      ),
    );
  }
}
