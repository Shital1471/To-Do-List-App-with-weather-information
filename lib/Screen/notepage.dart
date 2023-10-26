import 'package:flutter/material.dart';
import 'package:to_do_list/Screen/notecard.dart';
import 'package:to_do_list/Screen/seepage.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  bool seepage = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Your Notes",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  seepage = !seepage;
                });
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => SeePage()));
              },
              child: Text(
                "See All",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        NoteCard(
        
        ),
      ]),
    );
  }
}
