import 'package:flutter/material.dart';
import 'package:pikachu_education/utils/management_color.dart';

class DotBuild extends StatelessWidget {
  const DotBuild({super.key,required this.pageViewIndex});
final int pageViewIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildDot(context: context, isSelected: pageViewIndex == 0),
        const SizedBox(
          width: 8,
        ),
        buildDot(context: context, isSelected: pageViewIndex == 1),
        const SizedBox(
          width: 8,
        ),
        buildDot(context: context, isSelected: pageViewIndex == 2),
      ],
    );
  }
  Widget buildDot({required BuildContext context, required bool isSelected}) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: isSelected ? ManagementColor.red : ManagementColor.grey,
          borderRadius: BorderRadius.circular(50)),
    );
  }
}
