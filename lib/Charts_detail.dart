import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Make sure to import the material library for the context

class ChartDetails {
  static double getMeasure(
      charts.SeriesDatum<dynamic> selectedDatum, String chartType) {
    if (chartType == 'Population'.tr) {
      return selectedDatum
          .datum.men; // or any other measure logic for the population
    } else if (chartType == 'CrimeRate'.tr) {
      return selectedDatum
          .datum.majorCrimes; // or any other measure logic for the crime rate
    } else {
      return 0.0;
    }
  }

  static void handleSelection(
      charts.SelectionModel model, String chartType, BuildContext context) {
    if (model.hasDatumSelection) {
      final selectedDatum = model.selectedDatum[0];
      final year = selectedDatum.datum.year;
      final measure = getMeasure(selectedDatum, chartType);

      // You can customize this part based on your needs
      if (kDebugMode) {
        print('Selected Year: $year.tr, Measure: $measure'.tr);
      }

      // Show a message based on the chart type
      String message = (chartType == 'Population'.tr)
          ? 'Population for $year: $measure'.tr
          : 'Crime Rate for $year: $measure'.tr;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'.tr),
            ),
          ],
        ),
      );
    }
  }
}