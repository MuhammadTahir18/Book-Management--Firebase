import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Update extends StatefulWidget {
  final String name;
  final String image;
  final String auther;
  final String id;
  const Update({super.key, required this.name, required this.image, required this.auther, required this.id});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  // TextEditingController namecontroller=TextEditingController();
  // TextEditingController authercontroller=TextEditingController();
  // TextEditingController imagecontroller=TextEditingController();
  // TextEditingController pricecontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 100),
        child: Column(
          children: [
           TextField(
             decoration: InputDecoration(
               hintText: "bookimage",
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(5)
               )
             ),
           ),
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(
                  hintText: "BookName",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)
                  )
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(
                  hintText: "BookAuther",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)
                  )
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(
                  hintText: "BookPrice",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)
                  )
              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: (){

              },
              child: Container(
               height:50,
                color: Colors.pink,
                width:double.infinity,
                child: Center(child: Text("Update",style: TextStyle(color: Colors.white),)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
