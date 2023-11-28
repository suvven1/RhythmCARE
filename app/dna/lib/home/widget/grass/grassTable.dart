import 'package:dna/home/homePage.dart';
import 'package:flutter/material.dart';

grassTable<Widget>(List<int> walkNumList, List<Color> list, BuildContext context) {
  OverlayEntry? overlayEntry;
  return Center(
    child: Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        ...List.generate(
            5,
            (propsIndex) => TableRow(
                  children: List.generate(
                    7,
                    (index) => GestureDetector(
                      onLongPressDown: (details) {
                        Offset touchPositon = details.globalPosition;
                        showOverlay(context, touchPositon, overlayEntry, walkNumList[index + propsIndex * 7]);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.105,
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: list[index + propsIndex * 7],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ))
      ],
    ),
  );
}

void showOverlay(BuildContext context, Offset position, OverlayEntry? overlayEntry, int walkNum){
  // OverlayEntry를 사용하여 메시지 창을 표시
  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: position.dy - 70, // 메시지 창을 터치한 좌표 위로 위치 조정
      left: position.dx - 50,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 100,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.white),
          ),
          child: Center(
            child: Text(
              '$walkNum',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ),
      ),
    ),
  );

  // Overlay에 추가
  Overlay.of(context).insert(overlayEntry!);

  // 2초 후에 Overlay 제거
  Future.delayed(Duration(seconds: 1), () {
    overlayEntry?.remove();
    print(overlayEntry);
  });
}