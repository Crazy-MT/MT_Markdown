import 'package:flutter/material.dart';

class PageLoadingWidget extends StatelessWidget {
  const PageLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
