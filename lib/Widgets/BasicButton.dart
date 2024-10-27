// ignore_for_file: file_names

import 'package:city_folio/Constants/Styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class BasicButton extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  late double height, width;
  late String label;
  late VoidCallback onClick;
  BasicButton({
    super.key,
    required this.height,
    required this.label,
    required this.width,
    required this.onClick,
  });

  @override
  State<BasicButton> createState() => _BasicButtonState();
}

class _BasicButtonState extends State<BasicButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClick,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          color: const Color(0xFF5386E4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: Text(
          widget.label.tr,
          style: buttonText,
        )),
      ),
    );
  }
}
