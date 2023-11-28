import 'package:dna/hospital/webViewPage.dart';
import 'package:dna/toastMessage/toast.dart';
import 'package:flutter/material.dart';

class hospitalPage extends StatefulWidget {
  const hospitalPage({super.key});

  @override
  State<hospitalPage> createState() => _hospitalPageState();
}

class _hospitalPageState extends State<hospitalPage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicator_hospital =
  GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshIndicator_hospital.currentState?.show();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicator_hospital,
      onRefresh: () async {
        setState(() {
          showToast("화면새로고침 완료");
        });
      },
      child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height*0.9,
            padding: EdgeInsets.only(
              top: 20,
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05),
            child: WebViewPage(),
      ),
    );
  }
}
