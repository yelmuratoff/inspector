import 'package:flutter/material.dart';

import '../components/box_info_widget.dart';
import 'box_info.dart';

class InspectorOverlay extends StatelessWidget {
  const InspectorOverlay({
    Key? key,
    required this.size,
    required this.boxInfo,
    this.hoveredBoxInfo,
    this.comparedBoxInfo,
  }) : super(key: key);

  final Size size;
  final BoxInfo? boxInfo;
  final BoxInfo? hoveredBoxInfo;
  final BoxInfo? comparedBoxInfo;

  bool _canRender(BoxInfo? boxInfo) =>
      boxInfo?.targetRenderBox.attached ?? false;

  @override
  Widget build(BuildContext context) {
    if (!_canRender(boxInfo) && !_canRender(hoveredBoxInfo)) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      width: size.width,
      height: size.height,
      child: BoxInfoWidget(
        boxInfo: boxInfo,
        hoveredBoxInfo: hoveredBoxInfo,
        comparedBoxInfo: comparedBoxInfo,
      ),
    );
  }
}
