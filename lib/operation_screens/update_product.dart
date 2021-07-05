
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_operations/operation_screens/show_products.dart';
import 'package:flutter/material.dart';

class UpdateProduct extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    final TextEditingController oldProductName=TextEditingController();
    final TextEditingController oldProductPrice=TextEditingController();
    final TextEditingController newProductName=TextEditingController();
    final TextEditingController newProductPrice=TextEditingController();
    return Scaffold(
      appBar: AppBar(
          title: Text("Update Product"),
          centerTitle: true
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 25.0,bottom: 25.0),
            padding: EdgeInsets.only(left: 30.0,right: 30.0),
            child: TextField(
                controller: oldProductName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Old Product Name',
                    labelText: 'Old Product Name'
                )
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 25.0,bottom: 25.0),
            padding: EdgeInsets.only(left: 30.0,right: 30.0),
            child: TextField(
                controller: oldProductPrice,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Old Product Price',
                    labelText: 'Old Product Price'
                )
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 25.0,bottom: 25.0),
            padding: EdgeInsets.only(left: 30.0,right: 30.0),
            child: TextField(
                controller: newProductName,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter New Product Name',
                    labelText: 'New Product Name'
                )
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 25.0,bottom: 25.0),
            padding: EdgeInsets.only(left: 30.0,right: 30.0),
            child: TextField(
                controller: newProductPrice,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter New Product Price',
                    labelText: 'Old Product Price'
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
                  if(name==oldProductName.text.toString().trim())
                  {
                    var oldDocId=doc.id;
                    Map<String,dynamic> newValues=
                    {
                      'name':newProductName.text.toString().trim(),
                      'price':int.tryParse(newProductPrice.text.toString().trim())
                    };
                    await FirebaseFirestore.instance.collection('Products').doc(oldDocId).update(newValues).whenComplete((){ print('updated');});
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