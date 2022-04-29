import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

getChangeTextField({required String? title , onValidate , onSave , contraller = null}){
  return Column(
    children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10.sp),
        child: TextFormField(
          onSaved: onSave,
          controller: contraller,
          validator: onValidate,
          decoration: InputDecoration(
            hintText: title,
            hintStyle: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400
            ),
            border: const OutlineInputBorder(
                borderSide: BorderSide.none
            ),
          ),
        ),
      ),
      Divider()
    ],
  );
}