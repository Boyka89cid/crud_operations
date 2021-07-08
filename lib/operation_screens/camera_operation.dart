import 'dart:io';

import 'package:camera/camera.dart';
import 'package:crud_operations/main.dart';
import 'package:crud_operations/operation_screens/displaying_images.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'display_images.dart';

class TakingPictureScreen extends StatefulWidget
{
  CameraDescription firstCamera;
  TakingPictureScreen(CameraDescription firstCamera)
  {
    this.firstCamera=firstCamera;
  }

  //TakingPictureScreen({Key key,  this.firstCamera}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TakingPictureScreenState();
}
class TakingPictureScreenState extends State<TakingPictureScreen>
{
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  List<String> downloadedPath=[];
  List<String> imagesNames=['firstName','secondName','thirdName','forthName','fifthName'];
  int counter=0; int counter2=0;
  @override
  void initState()
  {
    super.initState();
    _controller=CameraController(widget.firstCamera, ResolutionPreset.medium); // creating a CameraController.
    _initializeControllerFuture=_controller.initialize(); //// Next, initialize the controller. This returns a Future ?
  }
  void dispose()
  {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context)
  {

    //nameOfPhotos.add('firstOne');
    return Scaffold(
      appBar: AppBar(
        title: Text('Take A Picture'),
        centerTitle: true,
      ),
      body: FutureBuilder<void>(
      future: _initializeControllerFuture,
        builder: (context, snapshot)
        {
          if (snapshot.connectionState == ConnectionState.done)  // If the Future is complete, display the preview.
            return CameraPreview(_controller);
           else                 // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
        }
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async
        {
          try                    // Take the Picture in a try / catch block. If anything goes wrong,// catch the error.
              {
                await _initializeControllerFuture; // Ensure that the camera is initialized.
                final image = await _controller.takePicture();  // Attempt to take a picture and get the file `image` where it was saved.
                final String finalImagePath=image.path;  //getting image path as a String.
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context)
                  {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text('Add to Database'),
                        centerTitle: true
                      ),
                      body: Column(
                        children: [
                          Center(
                            child: Container(
                              color: Colors.blue,
                              child: TextButton(
                                onPressed: () async
                                {
                                  try
                                  {
                                    final String finalPathForImageByAnUser=Home.pathToImages;
                                    final Reference _firebaseStorageInstance=FirebaseStorage.instance.ref().child('imagesBy$finalPathForImageByAnUser/${imagesNames[counter]}');
                                    await _firebaseStorageInstance.putFile(File(finalImagePath)).whenComplete( () {
                                      print('uploaded');
                                      counter++;
                                    });
                                  }catch(e){print(e);}
                                },
                                child: Text('Add to Storage',style: TextStyle(color: Colors.black))
                              )
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 10.0),
                              color: Colors.blue,
                              child: TextButton(
                                child: Text('Show Images', style: TextStyle(color: Colors.black),),
                                onPressed: () async
                                {
                                  //await FirebaseStorage.instance.ref().child('imagesByUser').listAll();
                                      final String finalPathForImageByAnUser=Home.pathToImages;
                                      String _reference=await FirebaseStorage.instance.ref().child("imagesBy$finalPathForImageByAnUser/${imagesNames[counter2]}").getDownloadURL();
                                      var imageId = await ImageDownloader.downloadImage(_reference).whenComplete(()
                                      {
                                        print('downloaded');
                                        counter2++;
                                      });
                                      String path = await ImageDownloader.findPath(imageId);
                                      //await addImagePath(path);
                                  await Navigator.push(context, MaterialPageRoute(builder: (context)=>DisplayImages(path)));
                                },
                              ),
                            ),
                          )
                        ],
                      )
                    );
                  }
                ));
              }catch(e){print(e);}
        },
        ),


    );
  }
  /*Future addImagePath(String p) async
  {
    await ImageDownloader.findPath(p).whenComplete(()
    {
      downloadedPath.add(p);
      counter--;
    });
  }*/
}