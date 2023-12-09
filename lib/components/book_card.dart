import 'package:english4k/pages/menu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BookCard extends StatelessWidget {
  int index;
  BookCard({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (kDebugMode) {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) { 
            return PageManu(index: index);
           }));
        }
      },
      icon: Image.asset(
        "assets/${index}.jpg",
        scale: 1.0,
        fit: BoxFit.contain,
      ),
    );
  }
}
