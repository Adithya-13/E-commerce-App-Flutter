import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/Screens/Login/components/background.dart';
import 'package:shop_app/Screens/Signup/signup_screen.dart';
import 'package:shop_app/components/already_have_an_account_acheck.dart';
import 'package:shop_app/components/rounded_button.dart';
import 'package:shop_app/components/rounded_input_field.dart';
import 'package:shop_app/components/rounded_password_field.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/SignIn.dart';
import 'package:shop_app/network/SignInData.dart';
import 'package:shop_app/screens/home/home_screen.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String email, password;

  Future<SignIn> _signIn;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return (_signIn == null)
        ? Background(
            child: ModalProgressHUD(
              inAsyncCall: false,
              child: buildSingleChildScrollView(size, context),
            ),
          )
        : buildFutureBuilder(size);
  }

  FutureBuilder<SignIn> buildFutureBuilder(Size size) {
    return FutureBuilder<SignIn>(
      future: _signIn,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Fluttertoast.showToast(
              msg: "Sign Up Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          saveData(true, snapshot.data.token);
          return HomeScreen();
        } else if (snapshot.hasError) {
          return throw Exception(snapshot.error);
        }

        return ModalProgressHUD(
          inAsyncCall: true,
          child: buildSingleChildScrollView(size, context),
        );
      },
    );
  }

  Future<void> saveData(bool isLoggedIn, String token) async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(kIsLoggedIn, isLoggedIn);
    prefs.setString(kToken, token);
  }

  SingleChildScrollView buildSingleChildScrollView(
      Size size, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "LOGIN",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: size.height * 0.03),
          SvgPicture.asset(
            "assets/icons/login.svg",
            height: size.height * 0.35,
          ),
          SizedBox(height: size.height * 0.03),
          RoundedInputField(
            hintText: "Your Email",
            onChanged: (value) {
              email = value;
            },
          ),
          RoundedPasswordField(
            onChanged: (value) {
              password = value;
            },
          ),
          RoundedButton(
            text: "LOGIN",
            press: () {
              setState(() {
                if (email == null || password == null) {
                  Fluttertoast.showToast(
                      msg: "Field Cannot be null!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 3,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                  print("Null");
                } else {
                  _signIn = createSignIn(email, password);
                }
              });
            },
          ),
          SizedBox(height: size.height * 0.03),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
