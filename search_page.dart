import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instgram_clon/detail_post_page.dart';
import 'create_page.dart';

class SearchPage extends StatefulWidget {
  final User user;
  SearchPage(this.user);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CreatePage(widget.user)));
        },
        child: Icon(Icons.create),
      ),
    );
  }

 Widget _buildBody() {
    return StreamBuilder(
    stream: FirebaseFirestore.instance.collection('post').snapshots()
    ,builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
      if(!snapshot.hasData) {
        return Center(child:CircularProgressIndicator());
      }
      var items = snapshot.data?.docs ?? [ ];
      return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0
          ),
          itemCount: items.length,
          itemBuilder: (context,index){
            return _bulidListItem(context,items[index]);
          });
    }
    );
 }

  Widget _bulidListItem(context, doc){
    return Hero(
      tag: doc['photoURL'],
      child: Material(
        child:InkWell(
        onTap:(){
          Navigator.push(context,MaterialPageRoute(builder: (context){
            return DetailPostPage(doc);
          }));
        },
        child: Image.network(
        doc['photoURL'],
        fit: BoxFit.cover),
      ),
      ),
    );
  }


}
