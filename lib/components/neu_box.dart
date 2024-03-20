import 'package:flutter/material.dart';
import 'package:melodify/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class NeuBox extends StatelessWidget {
  final Widget? child;
  const NeuBox({super.key,required this.child});

  @override
  Widget build(BuildContext context) {

    //is dark mode
    bool isDarkMode=Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).colorScheme.background,
        boxShadow: [
          // darker shadow on bottom right
          BoxShadow(
            color: isDarkMode ?Colors.black:Colors.grey.shade500,
            blurRadius: 15,
            offset: const Offset(4,4),
          ),

          //lighter shadow top left
          BoxShadow(
            color: isDarkMode?Colors.grey.shade900:Colors.white,
            blurRadius: 15,
            offset: const Offset(-4,-4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: child,
    );
  }
}
