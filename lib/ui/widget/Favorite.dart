import 'package:api_project/models/product_response.dart';
import 'package:api_project/providers/my_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(backgroundColor:Colors.white,elevation: 0,),
      body: Consumer<HomeProvider>(builder: (context, provider, x) {
        List<ProductResponse> favorites = provider.favoriteProducts;
        return favorites == null
            ? Center(
                child: Text(
                  "No Favorite Products",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              )
            : ListView.builder(
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.22,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 160,
                          child: CachedNetworkImage(
                            imageUrl: favorites[index].image,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                          child: Container(
                            width: 170,
                            height: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Spacer(),
                                Text(
                                  favorites[index].title,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Spacer(),
                                Text("\$" + favorites[index].price.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green)),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                            iconSize: 40,
                            onPressed: () {
                              provider
                                  .deleteFavoriteProduct(favorites[index].id);
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )),
                      ],
                    ),
                  );
                });
      }),
    );
  }
}
