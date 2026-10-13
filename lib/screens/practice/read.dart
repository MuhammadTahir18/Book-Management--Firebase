import 'package:book_management_app/screens/practice/update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReadData extends StatefulWidget {
  const ReadData({super.key});

  @override
  State<ReadData> createState() => _ReadDataState();
}

class _ReadDataState extends State<ReadData> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("books").snapshots(),
          builder: (context,snapshot){
            final data=snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
                itemBuilder: (context,index){
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:NetworkImage(data[index]["bookimage"]),
                  ),
                  title: Text(data[index]['bookName']),
                  subtitle:Text(data[index]['bookAuther']),
                  trailing: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>Update(
                          name: data[index]['bookName'],
                          image: data[index]["bookimage"],
                          auther: data[index]['bookAuther'],
                          id: data[index].id,
                        )));
                      },
                      child: Icon(Icons.edit)),
                );
                }
            );
          }
      ),
    );
  }
}
