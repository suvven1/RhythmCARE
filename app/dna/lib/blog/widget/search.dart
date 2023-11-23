import 'package:dna/widget/sizeBox.dart';
import 'package:flutter/material.dart';

class search extends StatefulWidget {
  const search({Key? key, required this.searchCon, required this.searchButtonAction});
  final TextEditingController searchCon;
  final searchButtonAction;

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all()),
                child: TextField(
                  controller: widget.searchCon,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Image.asset(
                        'image/search_icon.png',
                        width: 38,
                        height: 38,
                      ),
                    ),
                  ),
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: widget.searchButtonAction,
              child: Text(
                '검색',
                style: TextStyle(
                  fontSize: 23,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff2e2288),
                minimumSize: Size(90, 48),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
              ),
            )
          ],
        ),
        SizeBoxH30,
        Container(width: double.infinity, decoration: BoxDecoration(border: Border(top: BorderSide(width: 5, color: Color(0xff2e2288)))),),
        SizeBoxH20,
      ],
    );
  }
}
