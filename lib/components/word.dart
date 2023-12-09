import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:styled_text/styled_text.dart';

// ignore: must_be_immutable
class WordWidget extends StatefulWidget {
  List<Word>? words;
  WordWidget({super.key, this.words});
  @override
  State<StatefulWidget> createState() {
    return _WordState();
  }
}

class _WordState extends State<WordWidget> {
  final player = AudioPlayer();
  FocusNode focusNode = FocusNode();
  Widget body = const Center(
      child: Text(
    "Loading ...",
    style: TextStyle(fontSize: 40),
  ));
  int state = 0;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    player.stop();
    if (widget.words != null && index < widget.words!.length && index >= 0) {
      player.play(AssetSource(
          "${widget.words?[index].index}/${widget.words?[index].sound}"));
      body = Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              SizedBox(
                width: 700,
                child: Row(children: [
                  Text(
                    widget.words![index].en,
                    style: const TextStyle(
                        fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 40),
                  Text(
                    widget.words![index].pron,
                    style: const TextStyle(fontSize: 45),
                  ),
                ]),
              ),
              const SizedBox(
                width: 100,
              ),
              Image.asset(
                  "assets/${widget.words?[index].index}/${widget.words?[index].image}"),
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          Text(
            widget.words![index].desc,
            style: const TextStyle(fontSize: 40),
          ),
          const SizedBox(
            height: 60,
          ),
          toRichText(widget.words![index].exam)
        ]),
      );
    } else {
      body = const Center(
          child: Text(
        "End",
        style: TextStyle(fontSize: 40),
      ));
    }

    return RawKeyboardListener(
      autofocus: true,
      focusNode: focusNode,
      onKey: (event) {
        if (kDebugMode) {
          print(event);
        }
        if (event is RawKeyDownEvent) {
          // just keyDown
          String key = event.logicalKey.keyLabel;
          if (key == 'Escape') {
            player.pause();

            Navigator.pop(context);
          }
          if (key == 'Arrow Up') {
            player.pause();
            setState(() {
              index--;
            });
          }
          if (key == 'Arrow Down') {
            player.pause();

            setState(() {
              index++;
            });
          }
          if (key == ' ') {
            player.pause();

            setState(() {
              index++;
            });
          }
        }
      },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(37, 137, 189, 0.6),
        body: body,
      ),
    );
  }

  Widget toRichText(String exam) {
    return StyledText(
      style: const TextStyle(fontSize: 40),
      text: exam,
      tags: {
        'strong': StyledTextTag(style: TextStyle(fontWeight: FontWeight.bold)),
      },
    );
  }
}

class Word {
  String en;
  String pron;
  String desc;
  String exam;
  String vi;
  String image;
  String sound;
  int index;
  Word(
      {required this.en,
      required this.pron,
      required this.desc,
      required this.exam,
      required this.vi,
      required this.image,
      required this.index,
      required this.sound});

  factory Word.jfromJson(int index, Map<String, dynamic> json) {
    return Word(
        en: json['en'],
        pron: json['pron'],
        desc: json['desc'],
        exam: json['exam'],
        vi: json['vi'],
        image: json['image'],
        index: index,
        sound: json['sound']);
  }
}
