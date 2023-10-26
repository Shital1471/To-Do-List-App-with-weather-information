import 'package:flutter/material.dart';
import 'package:to_do_list/APIS/apis.dart';
import 'package:to_do_list/Screen/addnote.dart';
import 'package:to_do_list/Screen/listdisplay.dart';
import 'package:to_do_list/model/todomodel.dart';

class SeePage extends StatefulWidget {
  const SeePage({super.key});

  @override
  State<SeePage> createState() => _SeePageState();
}

class _SeePageState extends State<SeePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFC1ECE4),
      appBar: AppBar(
        backgroundColor: Color(0xFFFF9EAA),
        centerTitle: true,
        title: Text("All Notes"),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => AddNote(isUpdate: false,)));
            }, 
            icon:Icon(Icons.add)
            ),
        ],
      ),
      body: StreamBuilder(
          stream: APIs.firestore.collection('Todo').snapshots(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return Center(child: CircularProgressIndicator());
              case ConnectionState.active:
              case ConnectionState.done:
                var list = [];
                final data = snapshot.data?.docs;
                list = data!.map((e) => ToDo.fromJson(e.data())).toList();
                var revers = list.reversed.toList();
                if (revers.isNotEmpty) {
                  return ListDisplay(
                    list: revers,
                    n: list.length,
                  );
                } else {
                  return Center(
                      child: Text(
                    "Create a Notes📝",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ));
                }
            }
          }),
    );
  }
}
