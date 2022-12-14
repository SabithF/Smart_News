import 'colorConst.dart';
import 'sizeConst.dart';
import 'package:flutter/material.dart';

const kTextInputDecoration = InputDecoration(
  labelStyle: TextStyle(
    color: ColorConst.lightGrey,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: ColorConst.lightGrey, width: 1.5),
    borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_10)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: ColorConst.lightGrey, width: 1.5),
    borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_10)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1.5),
    borderRadius: BorderRadius.all(
      Radius.circular(Sizes.dimen_10),
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1.5),
    borderRadius: BorderRadius.all(
      Radius.circular(Sizes.dimen_10),
    ),
  ),
);