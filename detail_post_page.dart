import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPostPage extends StatelessWidget {
  final dynamic doc;
  DetailPostPage(this.doc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text('둘러보기'),
      ),
      body: _buildBody(),
    );
  }

 Widget _buildBody() {
    return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child:Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(doc['userPhotoURL']),
                      ),
                      Padding(padding: EdgeInsets.only(left:8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(doc['email'],
                          style: TextStyle(fontWeight: FontWeight.bold),),
                          Text(doc['displayName'])
                        ],
                      ),),
                    ],
                  )
              ),
              Hero(tag: doc['photoURL'],
              child: Image.network(doc['photoURL'])),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(doc['contents']),
              )
            ],
          ),
        ),);
 }
}
