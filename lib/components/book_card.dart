import 'package:english4k/pages/menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BookCard extends StatelessWidget {
  int index;
  BookCard({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (kDebugMode) {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return PageManu(index: index);
          }));
        }
      },
      child: Image.asset(
        height: 450,
        fit: BoxFit.fitHeight,
        "assets/$index.jpg",
      ),
    );
  }
}
