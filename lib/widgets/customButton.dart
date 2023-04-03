import 'package:flutter/material.dart';
import 'package:my_app/widgets/loader.dart';

class CustomButton extends StatelessWidget {
  final GestureTapCallback? onPress;
  final String title;
  final Color color;
  final bool isLoading;
  const CustomButton(
      {super.key,
      required this.onPress,
      required this.title,
      this.color = Colors.orange,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 48),
              child: Center(
                child: isLoading
                    ? Loader(
                        isLoading: isLoading,
                        backgroundColor: color,
                        color: Colors.white,
                        size: 19,
                      )
                    : Text(
                        title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
