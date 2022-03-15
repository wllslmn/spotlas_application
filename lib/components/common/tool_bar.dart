import 'package:flutter/material.dart';
import 'package:spotlas_test/components/common/icon_action.dart';

class ToolBar extends StatelessWidget {
  final List<IconAction> children;
  final EdgeInsets outerPadding;

  const ToolBar({Key? key, required this.children, required this.outerPadding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outerPadding,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
    );
  }
}
