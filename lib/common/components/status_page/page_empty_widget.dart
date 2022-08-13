import 'package:flutter/material.dart';

class PageEmptyWidget extends StatelessWidget {
  const PageEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          Text(
            'Empty',
            style: TextStyle(
              fontSize: 18,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
