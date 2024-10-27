// ignore_for_file: file_names

import 'package:city_folio/Constants/Styles.dart';
import 'package:city_folio/Constants/assets_location.dart';
import 'package:city_folio/Constants/color.dart';
import 'package:city_folio/Utils/pill.dart';
import 'package:city_folio/Utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisplayCard extends StatelessWidget {
  const DisplayCard({
    super.key,
    required this.companyName,
    required this.location,
    required this.role,
    required this.salary,
    required this.color,
  });

  final String companyName;
  final String role;
  final String salary;
  final String location;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: contentPadding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          20,
        ),
        color: color,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    role.tr,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: pureWhite,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    companyName.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: pureWhite,
                    ),
                  ),
                ],
              ),
              // BOOKMARKS

            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Pill(StaticText.it),
              Pill(StaticText.fullTime),
              Pill(StaticText.junior),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                salary.tr,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: pureWhite,
                ),
              ),
              Text(
                location.tr,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: pureWhite,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
