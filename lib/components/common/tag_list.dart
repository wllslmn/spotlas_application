import 'package:flutter/material.dart';
import 'package:spotlas_test/stores/models/recommendation/tag.dart';

class TagList extends StatelessWidget {
  final EdgeInsets listPadding;
  final EdgeInsets spacerPadding;
  final List<Tag> tags;

  const TagList({Key? key, required this.listPadding, required this.spacerPadding, required this.tags}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        padding: listPadding,
        children: tags
            .map((tag) => Padding(
          padding: spacerPadding,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColorLight.withOpacity(0.5),
                  spreadRadius: 0.1,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    tag.name,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                )),
          ),
        ))
            .toList(),
      ),
    );
  }
}
