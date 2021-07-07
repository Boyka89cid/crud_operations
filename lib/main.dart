import 'package:camera/camera.dart';
import 'package:crud_operations/authentication/auth.dart';
import 'package:crud_operations/operation_screens/add_product.dart';
import 'package:crud_operations/operation_screens/camera_operation.dart';
import 'package:crud_operations/operation_screens/delete_product.dart';
import 'package:crud_operations/operation_screens/show_products.dart';
import 'package:crud_operations/operation_screens/update_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';

Future<void > main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final cameras=await availableCameras();
  final firstCamera=cameras.first;
  runApp(
    MaterialApp(
      home: Home(firstCamera),
    )
  );
}

class Home extends StatelessWidget
{
  final AuthService authService=AuthService();
  final emailID=TextEditingController();
  final password=TextEditingController();
  CameraDescription firstCamera;

  Home(CameraDescription firstCamera) {this.firstCamera=firstCamera;}
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
                print(emailID.text);
                print(password.text);
                dynamic result=await authService.signInMailPassword(emailID.text.toString().trim(),password.text.toString().trim()).then((value) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TakingPictureScreen(firstCamera)));
                });
                if(result==null)
                  print('no');
                else
                  print(result);
                //Navigator.push(context, MaterialPageRoute(builder: (context) => TakingPictureScreen(firstCamera)));
              },
            child: Text("Login", style: TextStyle(color: Colors.black))
          )
        ],
      ),
    );
  }

}