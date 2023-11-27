import 'package:flutter/material.dart';

class postListNum extends StatefulWidget {
  const postListNum({Key? key, required this.viewListNum, required this.viewFt, required this.viewListCount}) : super(key: key);
  final int viewListNum;
  final Function viewFt;
  final int viewListCount;

  @override
  State<postListNum> createState() => _postListNumState();
}

class _postListNumState extends State<postListNum> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            widget.viewListCount+1,
            (index) => TextButton(
              onPressed: (){
                setState(() {
                  widget.viewFt(index);
                });
              },
              style: TextButton.styleFrom(
                maximumSize: Size(64, 36),
                padding: EdgeInsets.zero,
                foregroundColor: widget.viewListNum == index ? Color(0xff2e2288) : Colors.grey[300],
              ),
              child: Text(
                    '${index + 1}',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),
                  ),
            )),
      ),
    );
  }
}
