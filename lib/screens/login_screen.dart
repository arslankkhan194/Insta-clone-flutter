import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagramclone/responsive/mobile_screen_layout.dart';
import 'package:instagramclone/responsive/responsive_layout_screen.dart';
import 'package:instagramclone/responsive/web_screen_layout.dart';
import 'package:instagramclone/screens/signup_screen.dart';
import 'package:instagramclone/utils/Utils.dart';
import 'package:instagramclone/utils/colors.dart';

import '../resources/auth_methods.dart';
import '../text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == "sucess") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
        return const ResponsiveLayout(
            webScreenLayout: WebScreenLayout(),
            mobileScreenLayout: MobileScreenLayout());
      }));
      showSnackBar(res, context);
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignup() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignupScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(), flex: 2),
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 64,
              ),
              SizedBox(
                height: 64,
                child: TextFieldInput(
                  hintText: "Enter your email",
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _emailController,
                ),
              ),
              SizedBox(
                height: 64,
                child: TextFieldInput(
                  hintText: "Enter your password",
                  textInputType: TextInputType.text,
                  textEditingController: _passwordController,
                  isPass: true,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: loginUser,
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : Container(
                        child: const Text('Login'),
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: const ShapeDecoration(
                            color: blueColor,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)))),
                      ),
              ),
              SizedBox(
                height: 12,
              ),
              Flexible(child: Container(), flex: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text('Don\'t you have an account?'),
                    //style: TextStyle(fontWeight: FontWeight.bold),

                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: navigateToSignup,
                    child: Container(
                      child: const Text(
                        'Sign up',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
