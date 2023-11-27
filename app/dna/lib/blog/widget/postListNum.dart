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

  late int selectedNumber;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedNumber = widget.viewListNum;
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
                  selectedNumber = index;
                });
              },
              style: TextButton.styleFrom(
                maximumSize: Size(64, 36),
                padding: EdgeInsets.zero,
                foregroundColor: selectedNumber == index ? Color(0xff2e2288) : Colors.grey[300],
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
