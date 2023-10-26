import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_list/APIS/apis.dart';
import 'package:to_do_list/Screen/addnote.dart';

class ListDisplay extends StatefulWidget {
  late var list;
  late int n;
  ListDisplay({super.key, required this.list, required this.n});

  @override
  State<ListDisplay> createState() => _ListDisplayState();
}

class _ListDisplayState extends State<ListDisplay> {
  bool isUpadated = false;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.n,
        itemBuilder: (context, index) {
          log("list title :${widget.list[index].Title}");
          return Slidable(
            key: Key('$widget.list'),
            endActionPane: ActionPane(motion: ScrollMotion(), children: [
              SlidableAction(
                onPressed: (context) {
                  setState(() {
                    isUpadated = !isUpadated;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => AddNote(
                                isUpdate: isUpadated,
                                text: widget.list[index].Title,
                                desc: widget.list[index].description,
                                Id: widget.list[index].Id,
                              )));
                },
                backgroundColor: Colors.greenAccent,
                icon: Icons.edit,
              ),
              SlidableAction(
                onPressed: (context) {
                  APIs.deleteToDo(widget.list[index].Id).then((value) {
                    final message = SnackBar(
                      content: Text('Successfully Deleted'),
                      backgroundColor: Colors.grey,
                      duration: Duration(seconds: 1),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(message);
                  });
                },
                backgroundColor: Colors.redAccent,
                icon: Icons.delete,
              ),
            ]),
            child: Card(
              elevation: 4,
              child: Container(
                margin: EdgeInsets.all(4),
                padding: EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    
                    Expanded(
                      child: Text.rich(TextSpan(children: [
                        TextSpan(
                            text: "${widget.list[index].Title}\n",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        TextSpan(
                            text: widget.list[index].description,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ))
                      ])),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
    ;
  }
}
