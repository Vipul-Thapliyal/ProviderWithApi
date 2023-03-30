import 'package:flutter/material.dart';
import 'package:mvvm_tech_brothers/res/color.dart';

// RoundButton which can be used in various places according to situation
class RoundButton extends StatelessWidget {
  final String title; // Title of button
  final bool loading; // To show loading
  final VoidCallback onPress; // Function which will get executed on tap of the button

  const RoundButton(
    {
      Key? key,
      required this.title,
      this.loading = false,
      required this.onPress,
    }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: loading ?
          CircularProgressIndicator(
            color: Colors.white,
          )
          :
          Text(
            title,
            style: TextStyle(
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
