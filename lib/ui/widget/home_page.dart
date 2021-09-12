import 'package:api_project/providers/my_provider.dart';
import 'package:api_project/ui/widget/Favorite.dart';
import 'package:api_project/ui/widget/cart_screen.dart';
import 'package:api_project/ui/widget/my_bottmNavigationBar.dart';
import 'package:api_project/ui/widget/product_details.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, x) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white54,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(20),
              child: CarouselSlider(
                  items: provider.allProducts
                      .map((e) => CachedNetworkImage(imageUrl: e.image))
                      .toList(),
                  options: CarouselOptions(
                    height: 400,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    scrollDirection: Axis.horizontal,
                  )),
            ),
            SizedBox(
              height: 7,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text(
                'Categories',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: Colors.blue[600]),
              ),
            ),

            Container(
              height: 70,
              child: provider.allCategories == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: provider.allCategories
                            .map((e) => GestureDetector(
                                  onTap: () {
                                    provider.getCategoryProducts(e);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 2),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    decoration: BoxDecoration(
                                        color: provider.selectedCategory == e
                                            ? Colors.orangeAccent[100]
                                            : Colors.blue[50],
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Text(
                                      e[0].toUpperCase() + e.substring(1),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.blue[600]),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
            ),
            Container(
                child: provider.categoryProducts == null
                    ? Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            itemCount: provider.categoryProducts.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  provider.getSpecificProduct(
                                      provider.categoryProducts[index].id);
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                    return ProductDetails();
                                  }));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                          flex: 2,
                                          child: CachedNetworkImage(
                                            imageUrl: provider
                                                .categoryProducts[index].image,
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(provider
                                          .categoryProducts[index].title),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "\$${provider.categoryProducts[index].price.toString()}",
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 17),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )),


          ],
        ),
      );
    });
  }
}


