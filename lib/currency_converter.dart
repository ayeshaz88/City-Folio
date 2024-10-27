import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Widgets/HomeScreenWidgets/Header.dart';
import 'Widgets/custom_widget.dart';

class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final _amountController = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  String _result = '';
  List<String> _currencies = ['USD', 'EUR', 'GBP', 'INR'];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCurrencies();
  }

  Future<void> _fetchCurrencies() async {
    final apiKey = 'b9b3ae2e58264ad8cba2d1d1';
    final url =
        Uri.parse('https://v6.exchangerate-api.com/v6/$apiKey/latest/USD');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final Map<String, dynamic> rates = jsonResponse['conversion_rates'];
      setState(() {
        _currencies = rates.keys.toList();
        _isLoading = false;
      });
    } else {
      setState(() {
        _result = 'Error fetching currencies';
        _isLoading = false;
      });
    }
  }

  Future<void> _convertCurrency() async {
    final amount = double.tryParse(_amountController.text);
    if (amount == null) {
      setState(() {
        _result = 'Invalid amount';
      });
      return;
    }

    final apiKey = 'b9b3ae2e58264ad8cba2d1d1'; // Replace with your API key
    final url = Uri.parse(
        'https://v6.exchangerate-api.com/v6/$apiKey/latest/$_fromCurrency');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final rate = jsonResponse['conversion_rates'][_toCurrency];
      final result = amount * rate;

      setState(() {
        _result = '$amount $_fromCurrency = $result $_toCurrency';
      });
    } else {
      setState(() {
        _result = 'Error fetching exchange rate';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Currency Converter'.tr,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff312dA4),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _amountController,
                    decoration: InputDecoration(
                      labelText: 'Enter Amount'.tr,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.currency_exchange),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      DropdownButton<String>(
                        value: _fromCurrency,
                        onChanged: (String? newValue) {
                          setState(() {
                            _fromCurrency = newValue!;
                          });
                        },
                        items: _currencies
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Color(0xff312dA4),
                      ),
                      DropdownButton<String>(
                        value: _toCurrency,
                        onChanged: (String? newValue) {
                          setState(() {
                            _toCurrency = newValue!;
                          });
                        },
                        items: _currencies
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Center(
                    child: CustomElevatedButton(
                      message: 'Convert'.tr,
                      function: _convertCurrency,
                      color: Color(0xff312dA4),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      _result.tr,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
