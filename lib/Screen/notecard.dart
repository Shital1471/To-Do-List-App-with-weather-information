import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:to_do_list/APIS/apis.dart';
import 'package:to_do_list/Screen/listdisplay.dart';
import 'package:to_do_list/model/todomodel.dart';

class NoteCard extends StatefulWidget {
  NoteCard({super.key});

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 350,
      child: StreamBuilder(
        stream: APIs.firestore.collection('Todo').snapshots(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              var list = [];
              final data = snapshot.data?.docs;

              list = data!.map((e) => ToDo.fromJson(e.data())).toList();
             var reverse = list.reversed.toList();

              if (reverse.isNotEmpty) {
                return ListDisplay(
                  list: reverse,
                  n: list.length <= 3? list.length : 3,
                );
              } else {
                return Center(
                    child: Text(
                  "Create a Notes📝",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ));
              }
          }
        },
      ),
    );
  }
}
