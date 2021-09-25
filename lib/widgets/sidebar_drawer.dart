import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../pages/home_page.dart';
import '../widgets/sidebar.dart';

import 'dart:math' as math;

// Code for accessing sidebar from homepage

class SidebarDrawer extends StatefulWidget {
  User? _currUser;

  SidebarDrawer(User? currUser, {Key? key})
      : _currUser = currUser,
        super(key: key);

  @override
  _SidebarDrawerState createState() => _SidebarDrawerState();
}

class _SidebarDrawerState extends State<SidebarDrawer>
    with SingleTickerProviderStateMixin {
  static const double maxRight = 300;
  late AnimationController _animationController;
  static const double _minDragStartEdge = 60;
  static const double _maxDragStartEdge = maxRight - 40;
  late bool _canBeDragged;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void close() => _animationController.reverse();

  void open() => _animationController.forward();

  // Function to close or open sidebar
  void toggle() => _animationController.isCompleted ? close() : open();

  // Functions to update animation based on drag gesture
  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _animationController.isDismissed &&
        details.globalPosition.dx < _minDragStartEdge;

    bool isDragCloseFromRight = _animationController.isCompleted &&
        details.globalPosition.dx > _maxDragStartEdge;

    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta! / maxRight;
      _animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    double _kMinFlingVelocity = 365.0;

    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value < 0.5) {
      close();
    } else {
      open();
    }
  }

  @override
  Widget build(BuildContext context) {
    const homepage = HomePage();
    var sidebar = Sidebar(widget._currUser, maxRight);

    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      behavior: HitTestBehavior.translucent,
      onTap: toggle,
      child: AnimatedBuilder(
        // Animation to display behavior of sidebar during drag
        animation: _animationController,
        builder: (context, _) {
          return Material(
            color: Colors.blueGrey.shade100,
            child: Stack(
              children: [
                // Transformation for sidebar
                Transform.translate(
                  offset:
                      Offset(maxRight * (_animationController.value - 1), 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(math.pi / 2 * (1 - _animationController.value)),
                    alignment: Alignment.centerRight,
                    child: sidebar,
                  ),
                ),
                // Transformation for homepage
                Transform.translate(
                  offset: Offset(maxRight * _animationController.value, 0),
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(-math.pi * _animationController.value / 2),
                    alignment: Alignment.centerLeft,
                    child: homepage,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
