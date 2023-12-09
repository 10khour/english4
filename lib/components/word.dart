import 'package:flutter/material.dart';

class WordWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WordState();
  }
}

class _WordState extends State<WordWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class Word {
  String en;
  String porn;
  String desc;
  String exam;
  String vi;
  String image;
  String sound;
  Word(
      {required this.en,
      required this.porn,
      required this.desc,
      required this.exam,
      required this.vi,
      required this.image,
      required this.sound});
}
