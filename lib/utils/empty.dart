

import 'package:flutter/material.dart';

class NoData extends StatelessWidget {
  

  const NoData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Center(
          child: Container(
        child: Column(
          children: [
            Icon(Icons.list),
            Text(
              "Data Kosong",
              style: TextStyle(
                fontSize: 30,
              ),
            )
          ],
        ),
        padding: const EdgeInsets.all(0.0),
        width: 300.0,
        height: 350.0,
      )),
    );
  }
}