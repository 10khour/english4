import 'dart:convert';
import 'dart:math';

import 'package:english4k/components/unit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class PageManu extends StatefulWidget {
  int index;
  PageManu({super.key, required this.index});
  @override
  State<StatefulWidget> createState() {
    return _PageManuState();
  }
}

class _PageManuState extends State<PageManu> {
  List<Unit> units = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          children: units.map((element) {
        return UnitWdiget(unit: element);
      }).toList()),
    );
  }

  @override
  void initState() {
    super.initState();
    String path = "assets/${widget.index}/data.json";

    if (kDebugMode) {
      print("loading ${path}");
    }
    loadAsset(path).then((value) {
      Map<String, dynamic> hash = jsonDecode(value);
      List<Unit> units = List.empty(growable: true);
      List<dynamic> flashcards = hash['flashcard'] as List<dynamic>;
      flashcards.forEach((element) {
        units.add(Unit.fromJson(widget.index, element));
      });
      renderUnits(units);
    });
  }

  renderUnits(List<Unit> list) {
    setState(() {
      units = list;
    });
  }

  Future<String> loadAsset(String pathfile) async {
    return await rootBundle.loadString(pathfile);
  }
}
