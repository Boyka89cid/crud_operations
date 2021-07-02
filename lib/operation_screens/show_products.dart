import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowProducts extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Products'),
        centerTitle: true
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Products').orderBy('timestamp',descending: true).snapshots(),
        builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
          {
            if(snapshot.hasData)
              {
                /*ListView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemBuilder: (BuildContext context, int index) =>
                      Text(snapshot.data!.documents[index]['content']),
                  itemCount: snapshot.data!.documents.length,
                );*/
                final services=snapshot.data!.docs;
                List<Widget> servicesWidgets=[];
                for(var x in services)
                  {
                    //final  name=x.data()!['name'];
                    final price=x.id;
                    print(price);
                  }
                //final values=builtListTile(name,price,context);
                //servicesWidgets.add(values);
              }
            return ListView(
              children: [
                Text("sas")
              ]
            );
          }
      ),
    );
  }
  builtListTile(name, price, BuildContext context)
  {
    return ListTile(
      title: Text(name, style: TextStyle(fontSize: 20.0)),
      subtitle: Text(price, style: TextStyle(fontSize: 12.0)),
    );
  }
  void readData() async
  {
    DocumentSnapshot ds=await FirebaseFirestore.instance.collection('Products').doc().get();
    print(ds.data());
  }
}