// Automatic FlutterFlow imports
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your widget name, define your parameter, and then add the
// boilerplate code using the button on the right!

class CustomDropdown extends StatefulWidget {
  final String text;
  Function? minusIconPress;
  Function? plusIconPress;
  int? count;
  CustomDropdown(
      {Key? key,
      required this.text,
      this.minusIconPress,
      this.plusIconPress,
      this.count})
      : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  GlobalKey? actionKey;
  double? height, width, xPosition, yPosition;
  bool isDropdownOpened = false;
  late OverlayEntry floatingDropdown;
  @override
  void initState() {
    actionKey = LabeledGlobalKey(widget.text);
    super.initState();
  }

  void findDropdownData() {
    RenderBox renderBox =
        actionKey!.currentContext!.findRenderObject() as RenderBox;
    height = renderBox.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
    print(height);
    print(width);
    print(xPosition);
    print(yPosition);
  }

  OverlayEntry _createFloatingDropdown() {
    return OverlayEntry(builder: (context) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          hideTheDropDown();
        },
        onVerticalDragUpdate: (details) {
          hideTheDropDown();
        },
        onHorizontalDragUpdate: (details) {
          hideTheDropDown();
        },
        child: Stack(
          children: [
            Positioned(
                right: xPosition! + 55,
                width: 100,
                top: yPosition,
                height: 40,
                child: Column(
                  children: <Widget>[
                    Material(
                      elevation: 20,
                      child: Container(
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap:
                                      widget.minusIconPress as void Function()?,
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.black,
                                  )),
                              Text('${widget.count}'),
                              GestureDetector(
                                  onTap:
                                      widget.plusIconPress as void Function()?,
                                  child: Icon(
                                    Icons.add_box,
                                    color: Colors.black,
                                  ))
                            ],
                          )),
                    ),
                  ],
                )),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: actionKey,
      onTap: () {
        setState(() {
          if (isDropdownOpened) {
            floatingDropdown.remove();
          } else {
            findDropdownData();
            floatingDropdown = _createFloatingDropdown();
            Overlay.of(context)!.insert(floatingDropdown);
          }
          isDropdownOpened = !isDropdownOpened;
        });
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.add_box,
            color: Colors.white,
          )),
    );
  }

  hideTheDropDown() {
    if (isDropdownOpened) {
      floatingDropdown.remove();
    }
    setState(() {
      isDropdownOpened = false;
    });
  }
}
