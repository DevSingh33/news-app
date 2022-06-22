import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black12,
      surfaceTintColor: Colors.transparent,
      elevation: 2,
      toolbarHeight: 50,
      leadingWidth: 50,
      automaticallyImplyLeading: false,
      leading: CircleAvatar(
        backgroundColor: Colors.black45,
        child: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 18,
          ),
        ),
      ),
    );
  }
}
