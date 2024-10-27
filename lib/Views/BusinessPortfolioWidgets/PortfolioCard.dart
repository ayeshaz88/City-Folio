// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessCard extends StatelessWidget {
  final String pictureUrl;
  final String companyName;
  final String companyLogoUrl;
  final String pricing;
  final String address;

  const BusinessCard({
    Key? key,
    required this.pictureUrl,
    required this.companyName,
    required this.companyLogoUrl,
    required this.pricing,
    required this.address,
    required Map<String, dynamic> businessData,
    String,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8.0),
              topRight: Radius.circular(8.0),
            ),
            child: Image.network(
              pictureUrl,
              height: 100.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(companyLogoUrl),
                ),
                 SizedBox(width: 10.0),
                Text(
                  companyName.tr,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              pricing.tr,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              address.tr,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
