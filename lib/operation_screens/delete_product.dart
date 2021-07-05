
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
              CollectionReference collection = FirebaseFirestore.instance.collection('Products');
              collection.snapshots().listen((event) async {
            for (var doc in event.docs)
            {
              final  name=doc.data()['name'];
              if(name==deleteProductName.text.toString().trim())
              {
                var docId=doc.id;
                await FirebaseFirestore.instance.collection('Products').doc(docId).delete().whenComplete(() {print('deleted');});
              }
            }});
            },
            child: Text("Delete",style: TextStyle(color: Colors.black)),
          )
        ],
      ),
    );
  }
}