import 'package:clean/core/AppTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CongratulationsModal extends StatefulWidget {
  CongratulationsModal();

  static show(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        barrierColor: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return Material(color: Colors.transparent, child: CongratulationsModal());
        });
  }

  @override
  _CongratulationsModalState createState() => _CongratulationsModalState();
}

class _CongratulationsModalState extends State<CongratulationsModal> {

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 1500)).then((value) {
      if(mounted){
        Navigator.pop(context);
      }
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 48),
        Image.asset('assets/images/illustration_congrats.png', height: 259,),
        SizedBox(height: 11),
        Text(
          'Skvělá práce!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 7),
        Text(
          'Jen tak dál :)',
          style: TextStyle(
            fontSize: 13,
            height: 1.53,
            color: kColorTextPrimary,
            fontFamily: kFontFamilyRegular,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 48),
      ],
    );
  }
}
