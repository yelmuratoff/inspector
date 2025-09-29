import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class InspectorUtils {
  static RenderBox? _bypassAbsorbPointer(RenderProxyBox renderObject) {
    RenderBox _lastObject = renderObject;

    while (_lastObject is! RenderAbsorbPointer) {
      _lastObject = renderObject.child!;
    }

    return _lastObject.child;
  }

  static Iterable<RenderBox> findRenderObjectsAt(
    BuildContext context,
    Offset pointerOffset,
  ) sync* {
    final root = context.findRenderObject();
    if (root == null) return;

    yield* _collectAt(root, pointerOffset);
  }

  static Iterable<RenderBox> _collectAt(
    RenderObject renderObject,
    Offset globalOffset,
  ) sync* {
    // Check bounds for boxes
    if (renderObject is RenderBox) {
      final local = renderObject.globalToLocal(globalOffset);
      if (!renderObject.paintBounds.contains(local)) return;
    }

    // Recurse into children
    if (renderObject is RenderViewportBase) {
      final children = <RenderSliver>[];
      renderObject.visitChildren((child) {
        if (child is RenderSliver) children.add(child);
      });

      for (final sliver in children) {
        yield* _collectAt(sliver, globalOffset);
      }
    } else if (renderObject is RenderStack) {
      final children = <RenderObject>[];
      renderObject.visitChildren(children.add);

      // reverse order: last painted = topmost visually
      for (final child in children.reversed) {
        yield* _collectAt(child, globalOffset);
      }
    } else {
      final children = <RenderObject>[];
      renderObject.visitChildren(children.add);

      for (final child in children) {
        yield* _collectAt(child, globalOffset);
      }
    }

    // Include box
    if (renderObject is RenderBox) {
      yield renderObject;
    }
  }

  @Deprecated("Use findRenderObjectsAt instead")
  static Iterable<RenderBox> onTap(BuildContext context, Offset pointerOffset) {
    final renderObject = context.findRenderObject() as RenderProxyBox?;

    if (renderObject == null) return [];

    final renderObjectWithoutAbsorbPointer = _bypassAbsorbPointer(renderObject);

    if (renderObjectWithoutAbsorbPointer == null) return [];

    final hitTestResult = BoxHitTestResult();
    renderObjectWithoutAbsorbPointer.hitTest(
      hitTestResult,
      position: renderObjectWithoutAbsorbPointer.globalToLocal(pointerOffset),
    );

    return hitTestResult.path
        .where((v) => v.target is RenderBox)
        .map((v) => v.target)
        .cast<RenderBox>();
  }
}
