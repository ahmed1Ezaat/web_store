import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:yt_ecommerce_admin_panel/app.dart';
import 'package:yt_ecommerce_admin_panel/data/repositorise/authentication_repository.dart';
import 'package:yt_ecommerce_admin_panel/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  setPathUrlStrategy();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  
     

  runApp(const App());
}
