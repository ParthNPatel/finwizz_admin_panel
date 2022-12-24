import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final Widget leading;
  final Color? hoverColor;
  final String titleMessage;
  final double textFontSize;
  final Color textColor;
  final EdgeInsets? titleMargin;
  final void Function() onTap;

  const CustomTile({
    super.key,
    required this.leading,
    required this.titleMessage,
    required this.onTap,
    this.hoverColor,
    this.textColor = Colors.white,
    this.textFontSize = 14,
    this.titleMargin = const EdgeInsets.only(left: 16),
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      horizontalTitleGap: 0.0,
      hoverColor: hoverColor,
      title: Container(
        margin: titleMargin,
        child: Text(
          titleMessage,
          maxLines: 1,
          overflow: TextOverflow.fade,
          style: TextStyle(color: textColor, fontSize: textFontSize),
        ),
      ),
      onTap: onTap,
    );
  }
}
