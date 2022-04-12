import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Export File Sample'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              const urlPDF = 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf';
              final url= Uri.parse(urlPDF);
              final response = await http.get(url);
              final fileName = response.request.toString().split('/').last;
              final bytes = response.bodyBytes;

              final temp = await getTemporaryDirectory();
              final path = '${temp.path}/$fileName';
              File(path).writeAsBytesSync(bytes);
              Share.shareFiles([path],text: 'test for baptist');
            },
            child: Text('Export File'),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              minimumSize: Size(200, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // <-- Radius
              ),
            ),
          ),
        ),
      ),
    );
  }
}
