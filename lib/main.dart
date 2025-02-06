import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/class/routs_name.dart';
import 'package:evently/core/static/themes/dark.dart';
import 'package:evently/core/static/themes/light.dart';
import 'package:evently/firebase_options.dart';
import 'package:evently/provider/provider.dart';
import 'package:evently/provider/user_provider.dart';
import 'package:evently/rout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: EasyLocalization(
          supportedLocales: [Locale('en'), Locale('ar')],
          path: 'assets/translations',
          fallbackLocale: Locale('en'),
          child: MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    var userProvier = Provider.of<UserProvider>(context);
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      darkTheme: themeDark,
      debugShowCheckedModeBanner: false,
      themeMode: provider.themeMode,
      theme: themeLight,
      initialRoute: provider.isLogIn ? AppRouts.home : AppRouts.theme,
      routes: route,
    );
  }
}
