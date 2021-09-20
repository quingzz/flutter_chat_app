// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
  // callback function to update text in HomePage widget
  late Function(String) callback;
  TextInputWidget(Function(String) callbackFunc, {Key? key})
      : this.callback = callbackFunc,
        super(key: key);

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final inputController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    inputController.dispose();
    super.dispose();
  }

  // use init state to listen to changes of text field
  @override
  void initState() {
    super.initState();
  }

  void _updateInput(String input) {
    inputController.clear();
    widget.callback(input);
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: TextField(
            maxLines: null,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.message),
                border: const UnderlineInputBorder(),
                labelText: 'Message',
                suffixIcon: IconButton(
                  onPressed: () {
                    _updateInput(inputController.text);
                  },
                  icon: const Icon(Icons.send),
                  splashColor: Colors.blue,
                )),
            controller: inputController,
          ),
        ),
      ],
    );
  }
}
