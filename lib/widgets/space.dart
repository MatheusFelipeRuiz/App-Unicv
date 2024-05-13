import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class SpaceWidget extends StatefulWidget {
  final double spaceWidth;
  final double spaceHeight;
  const SpaceWidget(
      {super.key, required this.spaceWidth, required this.spaceHeight});

  @override
  State<SpaceWidget> createState() => _SpaceWidgetState();
}

class _SpaceWidgetState extends State<SpaceWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.spaceWidth,
      height: widget.spaceHeight,
    );
  }
}
