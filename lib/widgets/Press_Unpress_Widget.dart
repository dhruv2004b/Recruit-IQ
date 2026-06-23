import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PressUnPressWidget extends StatefulWidget {
  final Widget widget;
  void Function()? onTap;

  PressUnPressWidget({
    required this.widget,
    required this.onTap,
  });

  @override
  _PressUnPressWidgetState createState() => _PressUnPressWidgetState();
}

class _PressUnPressWidgetState extends State<PressUnPressWidget> {
  final _imageAssetController = StreamController<String>.broadcast();
  RxBool isPressed = false.obs;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _imageAssetController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        isPressed.value = true;
      },
      onPointerUp: (PointerUpEvent event) {
        isPressed.value = false;
      },
      onPointerCancel: (PointerCancelEvent event) {
        isPressed.value = false;
      },
      child: GestureDetector(
        onTap: widget.onTap,
        onDoubleTap: () {},
        child: StreamBuilder<String>(
            stream: _imageAssetController.stream,
            builder: (context, snapshot) {
              return Obx(
                    () => Opacity(
                  opacity: isPressed.value ? 0.5: 1.0,
                  child: widget.widget
                ),
              );
            }),
      ),
    );
  }
}
