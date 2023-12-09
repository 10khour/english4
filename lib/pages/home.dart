import 'package:english4k/components/book_card.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(37, 137, 189, 0.6),
        body: Wrap(
          runSpacing: 20,
          spacing: 20,
          children: getBooks(6),
        ));
  }

  List<Widget> getBooks(int count) {
    int i = 1;
    List<BookCard> cards = List.empty(growable: true);
    for (i = 1; i <= 6; i++) {
      cards.add(BookCard(index: i));
    }
    return cards;
  }
}
