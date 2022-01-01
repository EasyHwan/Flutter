import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreatePage extends StatefulWidget {
  final User user;
  CreatePage(this.user);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final textEditingController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  File? _image;

  @override
  void dispose() {
    // TODO: implement dispose
    textEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _bulidAppBar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {_getImage();},
        child:Icon(Icons.add_a_photo)
      ),
    );
  }

 AppBar _bulidAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      actions: <Widget>[
        IconButton(
            color: Colors.black,
            onPressed: () {
              final firebaseStorageref = FirebaseStorage.instance.
              ref().
              child('post').
              child('${DateTime
                  .now()
                  .millisecondsSinceEpoch}.png');
              final task = firebaseStorageref.putFile(
                _image!,SettableMetadata(contentType: 'image/png'));
              task.whenComplete(() => null).then((value) {
                var downloadURL = value.ref.getDownloadURL();
                downloadURL.then((uri) {
                var doc = FirebaseFirestore.instance.collection('post').doc();
                doc.set({
                  'id':doc.id,
                  'photoURL':uri.toString(),
                  'contents':textEditingController.text,
                  'email': widget.user.email,
                  'displayName':widget.user.displayName,
                  'userPhotoURL':widget.user.photoURL
                }).then((value) {
                  Navigator.pop(context);
                });
                });
              });
            },
            icon: Icon(Icons.send)),
      ],
    );
 }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          if(_image == null) Text('no Image')
          else
            Image.file(_image!),
          TextField(
            decoration: InputDecoration(hintText: '내용을 입력하세요'),
            controller:textEditingController,
          )
        ],
      ),
    );
  }

  Future<void> _getImage() async {
   XFile? image = await _picker.pickImage(source: ImageSource.gallery);

   setState(() {
     _image=File(image!.path);
   });
  }
}
