import 'package:flutter/material.dart';
import 'package:inspector/inspector.dart';

// Uncomment the following line if you have draggable_panel dependency
// import 'package:draggable_panel/draggable_panel.dart';

void main() {
  runApp(const CustomInspectorExample());
}

class CustomInspectorExample extends StatelessWidget {
  const CustomInspectorExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return Inspector(
          child: child!,
          // Custom panel builder
          panelBuilder: (context, controller) {
            // Here you can return your custom UI, e.g. DraggablePanel

            // Example using a simple custom UI that mimics a floating panel
            return Positioned(
              right: 20,
              bottom: 20,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(16),
                color: Colors.black87,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _PanelButton(
                        icon: Icons.format_shapes,
                        isActive: controller.modeNotifier.value ==
                            InspectorMode.inspector,
                        onTap: () => controller.setMode(
                          controller.modeNotifier.value ==
                                  InspectorMode.inspector
                              ? InspectorMode.none
                              : InspectorMode.inspector,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _PanelButton(
                        icon: Icons.colorize,
                        isActive: controller.modeNotifier.value ==
                            InspectorMode.colorPicker,
                        onTap: () => controller.setMode(
                          controller.modeNotifier.value ==
                                  InspectorMode.colorPicker
                              ? InspectorMode.none
                              : InspectorMode.colorPicker,
                          context: context,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _PanelButton(
                        icon: Icons.zoom_in,
                        isActive:
                            controller.modeNotifier.value == InspectorMode.zoom,
                        onTap: () => controller.setMode(
                          controller.modeNotifier.value == InspectorMode.zoom
                              ? InspectorMode.none
                              : InspectorMode.zoom,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      home: Scaffold(
        appBar: AppBar(title: const Text('Custom Inspector Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                color: Colors.red,
                child: const Center(child: Text('Red Box')),
              ),
              const SizedBox(height: 20),
              Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: const Center(child: Text('Blue Box')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PanelButton extends StatelessWidget {
  const _PanelButton({
    Key? key,
    required this.icon,
    required this.onTap,
    required this.isActive,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
