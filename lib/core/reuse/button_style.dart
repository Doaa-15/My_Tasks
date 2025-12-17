import 'package:add_tasks/core/theme/color.dart';
import 'package:flutter/material.dart';
class  ButtonStyles {
  static  ButtonStyle icon_button_style = ElevatedButton.styleFrom(
  
   backgroundColor: AppColor.primarycolor,
   shape: RoundedRectangleBorder(
    
    borderRadius: BorderRadiusGeometry.circular(10),
    ),

  );

    static   ButtonStyle  text_button_style = ElevatedButton.styleFrom(
   backgroundColor: AppColor.primarycolor,
   shape: RoundedRectangleBorder(
    borderRadius: BorderRadiusGeometry.circular(10),
    ),
   textStyle:const TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color:AppColor.secondcolor),

  );
}
