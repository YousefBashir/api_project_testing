import 'package:api_project/data/db_helper.dart';
import 'package:api_project/providers/my_provider.dart';
import 'package:api_project/ui/widget/home_page.dart';
import 'package:api_project/ui/widget/my_map.dart';
import 'package:api_project/ui/widget/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/sp_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DbHelper.dbHelper.initDatabase();
  SpHelper.spHelper.initSharedPrefrences();
  runApp(ChangeNotifierProvider<HomeProvider>(
      create: (context) => HomeProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyMap(),
      )));
}
