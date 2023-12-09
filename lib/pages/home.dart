import 'package:english4k/components/book_card.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildGrid());
  }

  Widget _buildGrid() => GridView.extent(
      maxCrossAxisExtent: 150,
      padding: const EdgeInsets.all(4),
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      children: _buildGridTileList(6));
  List<Container> _buildGridTileList(int count) =>
      List.generate(count, (i) => Container(child: BookCard(index: i + 1)));
}
