import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/ProductProvider.dart';
import 'package:shop_app/screens/Welcome/welcome_screen.dart';
import 'package:shop_app/screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool login = (prefs.getBool(kIsLoggedIn) ?? false);
  runApp(MyApp(
    login: login,
  ));
}

class MyApp extends StatelessWidget {
  final bool login;

  const MyApp({Key key, @required this.login}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          accentColor: kTextColor,
        ),
        home: WelcomeScreen(),
      ),
    );
  }
}
