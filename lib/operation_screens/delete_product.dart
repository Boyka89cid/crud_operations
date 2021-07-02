import 'dart:convert';
import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_operations/operation_screens/show_products.dart';
import 'package:flutter/material.dart';

class DeleteProduct extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    final TextEditingController deleteProductName=TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete Product"),
        centerTitle: true
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 25.0,bottom: 25.0),
            padding: EdgeInsets.only(left: 30.0,right: 30.0),
            child: TextField(
              controller: deleteProductName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Name of Product',
                labelText: 'Product Name'
              )
            ),
          ),
          ElevatedButton(
            onPressed: () async
            {
              //FirebaseFirestore _db = FirebaseFirestore.instance;
              //stream : FirebaseFirestore.instance.collection('Products').snapshots().map((snapshot) => snapshot.docs.map((e) => Entry.));
              //Query<Map<String,dynamic>> documentReference=FirebaseFirestore.instance.collection('Products').where('name',isEqualTo: deleteProductName.text.toString().trim());
              //documentReference.get()
              //Query<Map<String,dynamic>> a= FirebaseFirestore.instance.collection('Products').where('name',isEqualTo: deleteProductName.text.toString().trim());
              //var s=await FirebaseFirestore.instance.collection('Products').where('name',isEqualTo: deleteProductName.text.toString().trim()).get();
              //print(s);
              //await FirebaseFirestore.instance.collection('Products')
              //String id=FirebaseFirestore.instance.collection('Products').id;
              //Map<String, dynamic> user = jsonDecode(a);
              //print(a);
              //DocumentReference document=FirebaseFirestore.instance.collection('Products').doc();
              //DocumentSnapshot docSnap=await document.get();
              //var docID=docSnap.reference.id;
              //print(docID.toString());
             //await FirebaseFirestore.instance.collection('Products').where('name',isEqualTo: deleteProductName.text.toString().trim()).get();
              /*StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('Products').snapshots().map((event) => e),
                builder: (context,snapshot),
              );*/
            },
            child: Text("Delete",style: TextStyle(color: Colors.black)),
          )
        ],
      ),
    );
  }
}