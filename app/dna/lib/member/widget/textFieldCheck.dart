import 'package:flutter/material.dart';
import 'package:get/get.dart';

class textFieldCheck extends StatefulWidget {
  textFieldCheck({Key? key, required this.Con, required this.idpw, this.checkFt, required this.checkIcon}) : super(key: key);

  final TextEditingController Con;
  final String idpw;
  final Function()? checkFt;
  final bool checkIcon;

  @override
  State<textFieldCheck> createState() => _textFieldCheckState();
}

class _textFieldCheckState extends State<textFieldCheck> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        padding: EdgeInsets.only(left: 50, right: 50),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: TextField(
          style: TextStyle(fontSize: 20),
          controller: widget.Con,
          decoration: InputDecoration(
            hintText: widget.idpw,
            border: InputBorder.none,
          ),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Image.asset(
              widget.checkIcon ? 'image/checkTrue.png' : 'image/checkFalse.png',
              width: 25,
            ),
          ),
          widget.checkFt == null
              ? SizedBox()
              : TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            child: Container(
              height: 52,
              child: Center(
                  child: Text(
                    ' 중복확인 ',
                    style: TextStyle(color: Colors.white),
                  )),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
                color: Color(0xff2e2288),
              ),
            ),
            onPressed: widget.checkFt,
          )
        ],
      ),
    ]);
  }
}