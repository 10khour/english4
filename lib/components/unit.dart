import 'package:english4k/components/word.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UnitWdiget extends StatefulWidget {
  Unit unit;
  UnitWdiget({super.key, required this.unit});
  @override
  State<StatefulWidget> createState() {
    return _UnitWdiget();
  }
}

class _UnitWdiget extends State<UnitWdiget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Image.asset("assets/${widget.unit.index}/${widget.unit.image}"),
        TextButton(
          child: Text(
            widget.unit.en,
            style: const TextStyle(fontSize: 30),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (c) {
              return WordWidget(
                words: widget.unit.worldlist,
              );
            }));
          },
        )
      ],
    );
  }
}

class Unit {
  int index;
  String image;
  String en;
  List<Word>? worldlist;
  Unit(
      {required this.image,
      required this.index,
      required this.en,
      required,
      this.worldlist});

  factory Unit.fromJson(int index, Map<String, dynamic> json) {
    List<dynamic>? list = json['wordlist'];
    List<Word>? worldlist;
    if (list != null) {
      worldlist = list.map((e) => Word.jfromJson(index, e)).toList();
    }
    return Unit(
        image: json['image'],
        en: json['en'],
        worldlist: worldlist,
        index: index);
  }
}
