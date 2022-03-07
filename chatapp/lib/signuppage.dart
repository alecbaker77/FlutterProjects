import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/transitionpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {



  //sign up with email function
  static Future<User?> createUserWithEmailAndPassword({required String firstName, required String lastName, required String role, required String email, required String password, required BuildContext context}) async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;

      User? firestoreUser = FirebaseAuth.instance.currentUser;

      if (firestoreUser != null){
        DateTime currentPhoneDate = DateTime.now(); //DateTime
        Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp
        DateTime myDateTime = myTimeStamp.toDate();
        await FirebaseFirestore.instance.collection("chatappusers").doc(firestoreUser.uid).set({
          'uid': firestoreUser.uid,
          'userName': firstName + "." + lastName,
          'userEmail': email,
          'registrationDatetime':  myDateTime,
        });
      }
    } on FirebaseAuthException catch (e){
      print (e) ;
    }

    return user;
  }


  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _firstNameController = TextEditingController();
    TextEditingController _lastNameController = TextEditingController();
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Alec Baker Chat App",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Create an Account",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 44.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 44.0,
                  ),
                  TextField( // field for first name
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      hintText: "First Name",
                      prefixIcon: Icon(Icons.account_circle, color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                      height: 26.0
                  ),
                  TextField( // field for last name
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      hintText: "Last Name",
                      prefixIcon: Icon(Icons.account_circle, color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                      height: 26.0
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
                        User? user = await createUserWithEmailAndPassword(
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            role: 'customer',
                            context: context
                        );

                        if (user != null){
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => TransitionPage())
                          );
                        }
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
                ]
            )
        )
    );


  }
}