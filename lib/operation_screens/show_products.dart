import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowProducts extends StatelessWidget
{
  final List<Widget> servicesWidgets=[];
  final position=0;
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Products'),
        centerTitle: true
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Products').snapshots(),
        builder:(BuildContext context,snapshot)
          {
            if(snapshot.hasData)
              {
                final List<DocumentSnapshot> services=snapshot.data.docs;
                for(var x in services)
                  {
                    final  name=x.data()['name'];
                    final price=x.data()['price'].toString();
                    print(price);
                    final values=builtListTile(name,price,context);
                    servicesWidgets.add(values);
                  }
              }
            return ListView.builder(
              itemCount: servicesWidgets.length,
              itemBuilder: (context,position)
              {
                return servicesWidgets.elementAt(position);
              },
            );
          }//children: servicesWidgets,
      ),
    );
  }
  builtListTile(name, price, BuildContext context)
  {
    return ListTile(
      title: Text(name, style: TextStyle(fontSize: 20.0)),
      subtitle: Text(price, style: TextStyle(fontSize: 12.0)),
      onTap: (){});
  }
}