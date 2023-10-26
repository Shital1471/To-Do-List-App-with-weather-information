import 'package:flutter/material.dart';

class TempScreen extends StatefulWidget {
  Map<String, dynamic> temps;
  TempScreen({super.key,required this.temps});

  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                      image: AssetImage('Images/temperature.png'),
                      fit: BoxFit.cover)),
            ),
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: "Temp-F ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextSpan(
                text: "  ${widget.temps['temp_f'].toString()}\n",
                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Color(0xffC1ECE4)),
              ),
              TextSpan(
                  text: "Temp-C ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextSpan(
                text: "  ${widget.temps['temp_c'].toString()}",
                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Color(0xffC1ECE4)),
              )
            ])),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                
                  borderRadius: BorderRadius.circular(30),
                  
                  ),
                   child: Image.network(
                  'http:${widget.temps['condition']['icon']}',
                  fit: BoxFit.cover,
                ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              widget.temps['condition']['text'],
              style: TextStyle(
                color: Color(0xffFF9EAA),
                fontSize: 25,
                fontWeight: FontWeight.bold
                
              ),
            )
          ],
        )
      ]),
    );
  }
}
