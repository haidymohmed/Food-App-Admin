import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class UserButton extends StatefulWidget {
  final Function method ;
  final Color color ;
  final String title ;

  const UserButton({required this.title ,required this.color ,required this.method});

  @override
  _UserButtonState createState() => _UserButtonState();
}

class _UserButtonState extends State<UserButton> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 5.sp,
        horizontal: 15.sp
      ),
      height: 45.sp,
      width: width*0.9,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: widget.color,
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color : widget.color == Colors.transparent ?  Colors.white : widget.color , width: 2) ,
                borderRadius: BorderRadius.circular(10),
              )
          ),
          onPressed: (){
            widget.method();
          },
          child: Text(
            widget.title,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600
            ),
          )
      ),
    );
  }
}
