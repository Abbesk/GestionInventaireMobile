import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarCode extends StatefulWidget {
  const BarCode({Key? key}) : super(key: key);

  @override
  _BarCodeState createState() => _BarCodeState();
}

class _BarCodeState extends State<BarCode> {
  String _data = "";

  Future<String> _scan() async {
    return await FlutterBarcodeScanner.scanBarcode(
        "#000000", "Cancel", true, ScanMode.BARCODE)
        .then((value) => value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
        children: [
          TextButton(
            onPressed: () async {
              String result = await _scan();
              setState(() {
                _data = result;
              });
            },
            child: Text('Scan Barcode'),
          ),
          Text(_data),
        ],
      ),
    );
  }
}
