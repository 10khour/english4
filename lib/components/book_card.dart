import 'package:english4k/constants.dart';
import 'package:english4k/pages/menu.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BookCard extends StatefulWidget {
  int index;
  BookCard({super.key, required this.index});

  @override
  State<StatefulWidget> createState() {
    return _BookCard();
  }
}

class _BookCard extends State<BookCard> {
  FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Focus(
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return PageManu(index: widget.index);
          }));
        },
        child: Image.network(
          height: 300,
          fit: BoxFit.fitHeight,
          "$host/assets/${widget.index}.jpg",
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (focusNode == null) {
      focusNode = FocusNode();
      if (widget.index == 0) {
        Focus.of(context).requestFocus(focusNode);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (focusNode != null) {
      focusNode!.dispose();
    }
  }
}
