import 'package:flutter/material.dart';
import 'package:pembelian_kalbe/screen/pembelian/pembelian_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pembelian Kalbe',
      home: PembelianListPage(),
    );
  }
}