import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:get_storage/get_storage.dart';
import '../constants/strings.dart';
import '../configs/app_routes.dart';
import '../constants/colors.dart';
void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  await Future<void>.delayed(const Duration(seconds: 3));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  MyAppState createState() => MyAppState();
}
class MyAppState extends State<MyApp>{
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppStrings.name,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "AppFont",
          primarySwatch: AppColors.primary,
          appBarTheme: AppBarTheme(
            elevation: 0.0,
            backgroundColor: AppColors.mainColor,
          )
      ),
      initialRoute: RouteName.init,
      getPages: appRoutes,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      locale: const Locale('fr', 'FR'),
      supportedLocales: const [Locale('fr', 'FR')],
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, string , int port)=> true;
  }
}












