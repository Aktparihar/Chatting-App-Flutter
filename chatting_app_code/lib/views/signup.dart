import 'package:chatting_app_code/helper/helperFunction.dart';
import 'package:chatting_app_code/services/auth.dart';
import 'package:chatting_app_code/services/database.dart';
import 'package:chatting_app_code/widgets/widget.dart';
import 'package:flutter/material.dart';

import 'chatRoomScreen.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  AuthService authService = new AuthService();
  DataBaseMethods dataBaseMethods = new DataBaseMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController usernameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  signMeUp() {
    if (formKey.currentState.validate()) {
      Map<String, String> userInfoMap = {
        "name": usernameTextEditingController.text,
        "email": emailTextEditingController.text
      };

      HelperFunction.saveUserEmailSharedPreference(
          emailTextEditingController.text);
      HelperFunction.saveUserNameSharedPreference(
          usernameTextEditingController.text);

      setState(() {
        isLoading = true;
      });
      authService
          .signUpWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((val) {
        //print("${val}");

        dataBaseMethods.uploadUserInfo(userInfoMap);
        HelperFunction.saveUserLoggedInSharedPreference(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ChatRoom()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(context),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 50,
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (val) {
                                return val.isEmpty || val.length < 4
                                    ? "Please provide username"
                                    : null;
                              },
                              controller: usernameTextEditingController,
                              decoration: textInputFieldDecoration("Username"),
                              style: textStyle(),
                            ),
                            TextFormField(
                              validator: (val) {
                                return RegExp(
                                            "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")
                                        .hasMatch(val)
                                    ? null
                                    : "Please provide a valid email id";
                              },
                              controller: emailTextEditingController,
                              decoration: textInputFieldDecoration("email"),
                              style: textStyle(),
                            ),
                            TextFormField(
                              validator: (val) {
                                return val.length > 6
                                    ? null
                                    : "Please provide password 6+ characher";
                              },
                              obscureText: true,
                              controller: passwordTextEditingController,
                              style: textStyle(),
                              decoration: textInputFieldDecoration("password"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Text(
                            "Forgot Password?",
                            style: textStyle(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          signMeUp();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xff007EF4),
                                const Color(0xff2A75BC)
                              ],
                            ),
                          ),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.white,
                        ),
                        child: Text(
                          "Sign Up with Google",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: mediumTextStyle(),
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.toggle();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "Sign In Now",
                                style: mediumTextStyle(),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 45,
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
