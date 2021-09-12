import 'package:api_project/providers/my_provider.dart';
import 'package:api_project/ui/widget/home_page.dart';
import 'package:api_project/ui/widget/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<HomeProvider>(
    create: (context)=>HomeProvider(),
      child: MaterialApp(home: SplashScreen(),)));
}
