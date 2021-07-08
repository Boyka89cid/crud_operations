import 'dart:io';
import 'package:flutter/material.dart';

class DisplayImages extends StatelessWidget
{
  String filePaths;
  DisplayImages(String filePaths)
  {
    this.filePaths=filePaths;
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Images'),
        centerTitle: true,
      ),
      body: ListView.builder(padding: const EdgeInsets.all(10.0),
          //itemCount: imagesList.length,
          itemCount: 1,
          itemBuilder:(context,int index)
          {
            return Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 10.0, top: 0.0, right: 10.0,bottom: 0.0),
                    width: 200.0,
                    height: 200.0,
                    child: Image.file(File(filePaths))
                )
              ],
            );
          }),
    );
  }


}