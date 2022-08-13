import 'package:flutter/material.dart';

class PageErrorWidget extends StatelessWidget {
  const PageErrorWidget({Key? key, this.error, this.retryMethod}) : super(key: key);
  final Function? retryMethod;
  final dynamic error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Error: $error',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.red,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            child: const Text('Retry'),
            onPressed: () {
              if (retryMethod != null) {
                retryMethod!();
              }
            },
          ),
        ],
      ),
    );
  }
}
