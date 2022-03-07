import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/transitionpage.dart';
import 'package:chatapp/signuppage.dart';


class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}



class _LogInPageState extends State<LogInPage> {

  //AccessToken? _accessToken;

  //login function
  static Future<User?> loginUsingEmailPassword({required String email, required String password, required BuildContext context}) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e){
      if (e.code == "user-not-found"){
        print("No User Found for that email");
      }
    }

    return user;
  }


  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Alec Baker's Chat App",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Login to Your Account",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 44.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 44.0,
                  ),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "User Email",
                      prefixIcon: Icon(Icons.mail, color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                      height: 26.0
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "User Password",
                      prefixIcon: Icon(Icons.lock, color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                      height: 12.0
                  ),
                  const SizedBox(
                      height: 12.0
                  ),
                  Container(
                    width: double.infinity,
                    child: RawMaterialButton(
                      fillColor: Colors.indigo,
                      elevation: 0.0,
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      onPressed: () async {
                        User? user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
                        print(user);
                        if (user != null){
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => TransitionPage())
                          );
                        } else {

                        }
                      },
                      child: const Text(
                          "Log In",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          )
                      ),
                    ),
                  ),
                  const SizedBox(
                      height: 12.0
                  ),
                  Container(
                    width: double.infinity,
                    child: RawMaterialButton(
                      fillColor: Colors.indigo,
                      elevation: 0.0,
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      onPressed: () async {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => SignUpPage())
                        );
                      },
                      child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          )
                      ),
                    ),
                  ),
                  const SizedBox(
                      height: 12.0
                  ),

                ]
            )
        )
    );
  }
}