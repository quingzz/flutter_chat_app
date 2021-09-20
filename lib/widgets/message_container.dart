// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MessageContainer extends StatelessWidget {
  final bool _currUser;
  final String _message;
  const MessageContainer(bool currUser, String message, {Key? key})
      : _currUser = currUser,
        _message = message,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Color> userColor = [
      Colors.lightBlue[700]!,
      Colors.lightBlue[600]!,
      Colors.lightBlue[500]!,
      Colors.lightBlue[300]!
    ];

    final List<Color> guestColor = [
      Colors.blueGrey[300]!,
      Colors.blueGrey[200]!,
      Colors.blueGrey[100]!
    ];

    return FractionallySizedBox(
      alignment: _currUser ? Alignment.centerRight : Alignment.centerLeft,
      // max size is 70 % of parent
      widthFactor: 0.7,
      child: Container(
        // Outer container for padding between box and text
        padding: const EdgeInsets.symmetric(horizontal: 5),
        // Inner container for padding inside text box
        child: Wrap(
          alignment: _currUser ? WrapAlignment.end : WrapAlignment.start,
          // for some reason Wrap shrinks the container based on content
          children: [
            Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: _currUser ? userColor : guestColor),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12),
                      bottomRight:
                          _currUser ? Radius.circular(0) : Radius.circular(12),
                      bottomLeft:
                          _currUser ? Radius.circular(12) : Radius.circular(0)),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
                child: Text(_message,
                    style: TextStyle(
                        color: _currUser ? Colors.white : Colors.black,
                        fontSize: 16)))
          ],
        ),
      ),
    );
  }
}
