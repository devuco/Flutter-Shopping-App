import 'package:flutter/material.dart';

class RatingBar extends StatefulWidget {
  final num initialIndex;
  final bool enabled;
  const RatingBar({super.key, this.initialIndex = -1, this.enabled = true});

  @override
  State<RatingBar> createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  num index = -1;

  @override
  void initState() {
    index = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: ListView.builder(
        itemBuilder: (contex, i) => GestureDetector(
          onTap: () => widget.enabled ? setState(() => index = i) : null,
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(
              Icons.star,
              size: 28,
              color: i <= index ? Colors.yellow[700] : Colors.grey,
            ),
          ),
        ),
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
      ),
    );
  }
}
