//토스트 메세지를 웹에서 간편하게 사용할 수 있는 코드
//No-Context 와 Flutter Toast 라이브러리 이용!
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toast_message(String text){
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}