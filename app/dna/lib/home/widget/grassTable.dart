import 'package:flutter/material.dart';

grassTable<Widget>(List list, BuildContext context) {
  return Center(
    child: Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        ...List.generate(
            5,
            (propsIndex) => TableRow(
                  children: List.generate(
                    7,
                    (index) => TextButton(
                      onPressed: () {},
                      onLongPress: () {
                        SnackBar(
                          content: Text('안녕잔디'),
                          duration: Duration(seconds: 2),
                        );
                        print('안녕잔디');
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
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

// void showOverlay(BuildContext context, Offset position){
//   // OverlayEntry를 사용하여 메시지 창을 표시
//   overlayEntry = OverlayEntry(
//     builder: (context) => Positioned(
//       top: position.dy - 50, // 메시지 창을 터치한 좌표 위로 위치 조정
//       left: position.dx - 50,
//       child: Material(
//         color: Colors.transparent,
//         child: Container(
//           padding: EdgeInsets.all(8.0),
//           decoration: BoxDecoration(
//             color: Colors.black,
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           child: Text(
//             '메시지 창',
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//     ),
//   );
//
//   // Overlay에 추가
//   Overlay.of(context)?.insert(overlayEntry!);
//
//   // 2초 후에 Overlay 제거
//   Future.delayed(Duration(seconds: 2), () {
//     overlayEntry?.remove();
//   });
// }