import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:to_do_list/APIS/apis.dart';

class AddNote extends StatefulWidget {
  final bool isUpdate;
  final String text;
  final String desc;
  final String Id;
  AddNote({
    super.key,
    required this.isUpdate,
    this.text = "",
    this.desc = "",
    this.Id = "",
  });

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController _titlcontroller = TextEditingController();
  TextEditingController _editingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      _titlcontroller.text = widget.text;
      _editingController.text = widget.desc;
    }
  }

  String? _isValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color:Color(0xFFC1ECE4),
      child: AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.isUpdate ? "Update Note" : 'Add Note',
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _titlcontroller,
                  maxLines: 1,
                  decoration: InputDecoration(
                      labelText: "Title",
                      hintText: "Title...",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20))),
                  validator: _isValidate,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _editingController,
                  maxLines: null,
                  maxLength: 50,
                  decoration: InputDecoration(
                      labelText: "Description",
                      hintText: "Description....",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(20))),
                  validator: _isValidate,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancle",
                          style:
                              TextStyle(fontSize: 20, color: Colors.blueAccent),
                        )),
                    TextButton(
                        onPressed: () {
                          widget.isUpdate
                              ? APIs.updateToDO(widget.Id, _titlcontroller.text,
                                      _editingController.text)
                                  .then((value) {
                                  final message = SnackBar(
                                    content:
                                        Text('Your note has been updated..'),
                                    backgroundColor: Colors.grey,
                                    duration: Duration(seconds: 1),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(message);
                                  Navigator.pop(context);
                                })
                              : APIs.createToDo(_titlcontroller.text,
                                      _editingController.text)
                                  .then((value) {
                                  setState(() {
                                    _titlcontroller.clear();
                                    _editingController.clear();
                                  });
                                  final message = SnackBar(
                                    content:
                                        Text('Your note have been saved...'),
                                    backgroundColor: Colors.grey,
                                    duration: Duration(seconds: 1),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(message);
                                  Navigator.pop(context);
                                });
                        },
                        child: Text(
                          widget.isUpdate ? "Update" : "Add",
                          style:
                              TextStyle(fontSize: 20, color: Colors.blueAccent),
                        ))
                  ],
                )
              ]),
        ),
      ),
    );
  }
}
