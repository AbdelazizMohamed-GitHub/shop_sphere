import 'package:flutter/material.dart';

class SlideInText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration duration;

  const SlideInText({
    super.key,
    required this.text,
    this.style,
    this.duration = const Duration(milliseconds: 600),
  });

  @override
  State<SlideInText> createState() => _SlideInTextState();
}

class _SlideInTextState extends State<SlideInText> {
  Offset offset = const Offset(0, 1); // يبدأ من تحت

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        offset = Offset.zero; // يرجع مكانه الطبيعي
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: offset,
      duration: widget.duration,
      curve: Curves.easeOut,
      child: Text(widget.text, style: widget.style),
    );
  }
}
