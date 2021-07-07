import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class TakingPictureScreen extends StatefulWidget
{
  CameraDescription firstCamera;
  TakingPictureScreen(CameraDescription firstCamera){this.firstCamera=firstCamera;}

  //TakingPictureScreen({Key key,  this.firstCamera}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TakingPictureScreenState();
}
class TakingPictureScreenState extends State<TakingPictureScreen>
{
  CameraController _controller;
  Future<void> _initializeControllerFuture;
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Take A Picture'),
        centerTitle: true
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
                      body: Center(
                        child: Container(
                          color: Colors.blue,
                          child: TextButton(
                            onPressed: () async
                            {
                              try
                              {
                                //final  ImagePicker picker=ImagePicker(); //Setting Image Picker
                                //final PickedFile pickedImage=await picker.getImage(source: ImageSource.camera); //Getting Image form Camera and storing as file
                                //final finalImageFile=File(pickedImage.path); //Getting the file as finalImageFile

                                //final filePicker=FilePicker.platform;
                                //final finalFile=await filePicker.pickFiles(type:FileType.image);
                                //final File x=Image.file(File(finalImagePath));

                                final Reference _firebaseStorageInstance=FirebaseStorage.instance.ref().child('imagesByUser/$finalImagePath');
                                _firebaseStorageInstance.putFile(File(finalImagePath)).whenComplete( () { print('uploaded'); });

                                //await _firebaseStorageInstance.putFile(f).whenComplete(() {print('Uploaded');});
                              }catch(e){print(e);}
                            },
                            child: Text('Add to Storage',style: TextStyle(color: Colors.black))
                          )
                        ),
                      )
                    );
                  }
                ));
              }catch(e){print(e);}
        }
        ),

    );
  }
}