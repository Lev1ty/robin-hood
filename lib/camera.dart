import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }
/*
  Future Use_Azure() async {

    final String url = "https://canadacentral.api.cognitive.microsoft.com/vision/v2.0/ocr";
    final String key = "68d2c9111c95476798620f32134362bc";
    List words;
    List line_infos;
    List word_metadata;
    List word_info;


    var res = await http
        .post(url, headers: {'Ocp-Apim-Subscription-Key': key}, body: {'language': 'unk', 'detectOrientation': 'true'});
    setState(() {
      var resBody = json.decode(res.body);
      words = resBody["regions"];
    });
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Proof of Purchase'),
      ),
      body: new Center(
        child: _image == null
            ? Text('Please take a photo of your reciept')
            : enableUpload(),
      ),
      floatingActionButton: Column(
        children: <Widget>[
          FloatingActionButton(
            onPressed: getImage,
            tooltip: 'Take Photo',
            child: Icon(Icons.photo_camera),
          ),
        ],

      ),
    );
  }
  Widget enableUpload() {
    return Container(
      child: Column (
        children: <Widget>[
          Image.file(_image, height: 300.0, width: 300.0),
          RaisedButton(
            elevation: 7.0,
            child: Text('Upload'),
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: () async{
              final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('reciept.jpg');
              final StorageUploadTask task = firebaseStorageRef.putFile(_image);
              var downUrl = await (await task.onComplete).ref.getDownloadURL();
              var url = downUrl.toString();
              print(url);
            },
          )
        ],
      )
    );
  }
}

