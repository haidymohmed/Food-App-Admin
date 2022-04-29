import 'package:flutter/cupertino.dart';

class Setting{
  // ignore: prefer_typing_uninitialized_variables
  late String title ;
  late IconData data;
  late var action;
  Setting({
    required this.title,
    required this.data,
    required this.action
});
}