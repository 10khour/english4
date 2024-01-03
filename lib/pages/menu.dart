import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:english4k/components/unit.dart';
import 'package:english4k/constants.dart';
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
  FocusNode focusNode = FocusNode();
  List<Unit> units = [];
  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: focusNode,
      onKey: (event) {
        if (event is RawKeyDownEvent) {
          String key = event.logicalKey.keyLabel;
          if (key == "Escape") {
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(37, 137, 189, 0.6),
        body: ListView(
            children: units.map((element) {
          return UnitWdiget(unit: element);
        }).toList()),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    String url = "$host/assets/${widget.index}/data.json";

    if (kDebugMode) {
      print("loading $url");
    }
    http.get(Uri.parse(url)).then((res) {
      String value = res.body;
      value = utf8.decode(value.codeUnits, allowMalformed: true);
      Map<String, dynamic> hash = jsonDecode(value);
      List<Unit> units = List.empty(growable: true);
      List<dynamic> flashcards = hash['flashcard'] as List<dynamic>;
      for (var element in flashcards) {
        units.add(Unit.fromJson(widget.index, element));
      }
      renderUnits(units);
    });

    // loadAsset(path).then((value) {
    //   Map<String, dynamic> hash = jsonDecode(value);
    //   List<Unit> units = List.empty(growable: true);
    //   List<dynamic> flashcards = hash['flashcard'] as List<dynamic>;
    //   for (var element in flashcards) {
    //     units.add(Unit.fromJson(widget.index, element));
    //   }
    //   renderUnits(units);
    // });
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
