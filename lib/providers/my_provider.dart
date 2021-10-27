import 'package:api_project/data/api_helper.dart';
import 'package:api_project/data/db_helper.dart';
import 'package:api_project/models/product_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeProvider extends ChangeNotifier {
  Set<Marker> markers={};
  addMarkerToSet(Marker marker){
    this.markers.add(marker);
    notifyListeners();
  }

  List<String> allCategories;
  List<ProductResponse> allProducts;
  List<ProductResponse> categoryProducts;
  ProductResponse selectedProduct;
  List<ProductResponse> cartProducts;
  List<ProductResponse> favoriteProducts;
  String selectedCategory = '';

  /// get All categories from api ///
  getAllCategories() async {
    List<dynamic> categories = await ApiHelper.apiHelper.getAllCategories();
    allCategories = categories.map((e) => e.toString()).toList();
    notifyListeners();
    getCategoryProducts(allCategories.first);
  }

  /// get all products for one category ///
  getCategoryProducts(String category) async {
    categoryProducts = null;
    this.selectedCategory = category;
    notifyListeners();
    List<dynamic> products =
        await ApiHelper.apiHelper.getCategoryProducts(category);
    categoryProducts =
        products.map((e) => ProductResponse.fromJson(e)).toList();
    notifyListeners();
  }

  /// get all products in api ///

  getAllProducts() async {
    List<dynamic> products = await ApiHelper.apiHelper.getAllProducts();
    allProducts = products.map((e) => ProductResponse.fromJson(e)).toList();
    notifyListeners();
  }

  /// get a specific product during id ///
  getSpecificProduct(int id) async {
    selectedProduct = null;
    notifyListeners();
    dynamic response = await ApiHelper.apiHelper.getSpecificProduct(id);
    selectedProduct = ProductResponse.fromJson(response);
    notifyListeners();
  }

  /// get all product in favorite list ///
  getFavoriteProducts() async {
    List<ProductResponse> products = await DbHelper.dbHelper.getAllFavourite();
    this.favoriteProducts = products;
    notifyListeners();
  }

  /// get all product that added into cart ///
  getCartProducts() async {
    List<ProductResponse> products = await DbHelper.dbHelper.getAllCart();
    this.cartProducts = products;
    cartProducts.forEach((element) {
      print(element.quantity);
    });
    notifyListeners();
  }

  /// Get the total price for all products in cart ///
  double getTotalPrice() {
    double sum = 0.0;
    cartProducts == null
        ? sum = 0.0
        : cartProducts.forEach((element) {
            sum += (element.quantity * element.price);
            print("sum is the price of $sum ");
          });

    return sum ?? 0.0;
  }

  /// add product to favorite ///
  addToFavorite(ProductResponse productResponse) async {
    bool productInFavourite = favoriteProducts == null
        ? false
        : favoriteProducts.any((x) {
            return x.id == productResponse.id;
          });

    if (productInFavourite) {
      deleteFavoriteProduct(productResponse.id);
    } else {
      await DbHelper.dbHelper.addProductToFavourite(productResponse);
    }

    getFavoriteProducts();
  }

  /// Add product to cart ///
  addToCart(ProductResponse productResponse) async {
    bool productInCart = cartProducts == null
        ? false
        : cartProducts.any((x) {
            return x.id == productResponse.id;
          });

    if (productInCart) {
      productResponse.quantity = cartProducts
          .where((element) => element.id == productResponse.id)
          .first
          .quantity;
      await DbHelper.dbHelper.updateProductQuantity(productResponse);
    } else {
      await DbHelper.dbHelper.addProductToCart(productResponse);
    }

    getCartProducts();
  }

  /// delete a product from database depending on id ///
  deleteFavoriteProduct(int id) async {
    await DbHelper.dbHelper.deleteProductFromFavourite(id);
    getFavoriteProducts();
  }

  /// delete product from cart list depending on id ///
  deleteCartProduct(int id) async {
    await DbHelper.dbHelper.deleteProductFromCart(id);
    getCartProducts();
  }

  addOrRemoveFromFavourite(int id) async {
    await ApiHelper.apiHelper.addOrRemoveFromFavourite(id);
  }

  /// Update the products list that added in cart ///

  updateProductInCart(ProductResponse productResponse) async {
    await DbHelper.dbHelper.updateProductQuantity(productResponse);
    getCartProducts();
  }

  getFavourite() async {
    await ApiHelper.apiHelper.getFavourite();
  }
}
