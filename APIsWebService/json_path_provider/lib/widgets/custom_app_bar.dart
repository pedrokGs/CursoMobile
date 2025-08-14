import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget{
  String? title;
  CustomAppBar({super.key, this.title});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 5,
      centerTitle: true,
      title: Text(widget.title ?? "Sem título"),
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15))),
      actions: [

      ],
    );
  }
}