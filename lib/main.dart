import 'package:crud_operations/authentication/auth.dart';
import 'package:crud_operations/operation_screens/add_product.dart';
import 'package:crud_operations/operation_screens/delete_product.dart';
import 'package:crud_operations/operation_screens/show_products.dart';
import 'package:crud_operations/operation_screens/update_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void > main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      home: UpdateProduct(),
    )
  );
}

class Home extends StatelessWidget
{
  final AuthService _authService=AuthService();
  final emailID=TextEditingController();
  final password=TextEditingController();
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        centerTitle: true
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 25.0),
            padding: EdgeInsets.only(left: 30.0,right: 30.0),
              child: TextField(
                controller: emailID,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Your Mail Here",
                ),
              ),
            ),
          Container(
            margin: EdgeInsets.only(top: 25.0,bottom: 25.0),
            padding: EdgeInsets.only(left: 30.0,right: 30.0),
              child: TextField(
                controller: password,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your Password Here"
                ),
              ),
            ),
          ElevatedButton(
            onPressed: () async
            {
              dynamic result=await _authService.signInWithEmailPassword(emailID.text.toString().trim(),password.text.toString().trim());
              if(result!=null)
                print(result);
              else
                print("Not logged In");
            },
            child: Text("Login", style: TextStyle(color: Colors.black))
          )
        ],
      ),
    );
  }

}