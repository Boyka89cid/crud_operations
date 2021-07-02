import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    final TextEditingController productName=TextEditingController();
    final TextEditingController productPrice=TextEditingController();
    return Scaffold(
      appBar: AppBar(
          title: Text('Add Product'),
          centerTitle: true
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 25.0),
            padding: EdgeInsets.only(left: 30.0,right: 30.0),
            child: TextField(
              controller: productName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Product Name ",
                labelText: "Name"
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 25.0,bottom: 25.0),
            padding: EdgeInsets.only(left: 30.0,right: 30.0),
            child: TextField(
              controller: productPrice,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Product Price",
                  labelText:"Price"
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () async
              {
                await FirebaseFirestore.instance.collection('Products').add(
                    {
                      'name':productName.text,
                      'price':int.parse(productPrice.text.toString())
                    }).whenComplete((){
                      productName.clear();
                      productPrice.clear();
                    });
              },
              child: Text("Add", style: TextStyle(color: Colors.black))
          )
        ],
      ),
    );
  }

}