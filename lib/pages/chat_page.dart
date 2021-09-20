import 'package:flutter/material.dart';
import '../widgets/message_container.dart';
import '../widgets/textInputWidget.dart';

// Widget used for ChatPage, creating a canvas to add other widgets on
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<String> _textList = [
    "Sample chat text",
    "Another sample message",
    "urhgo eriogewrgoi werogwgj ewrohijrjtph ergjrthpo",
    "urhgo eriogewrgoi werogwgj ewrohijrjtph ergjrthpo",
    "urhgo eriogewrgoi werogwgj ewrohijrjtph ergjrthpo",
    "urhgo eriogewrgoi werogwgj ewrohijrjtph ergjrthpo",
    "urhgo eriogewrgoi werogwgj ewrohijrjtph ergjrthpo",
    "urhgo eriogewrgoi werogwgj ewrohijrjtph ergjrthpo",
    "Sample text Sample text Sample text Sample text Sample text Sample text",
    " Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam eaque ipsa, quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt, explicabo. Nemo enim ipsam voluptatem, quia voluptas sit, aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos, qui ratione voluptatem sequi nesciunt, neque porro quisquam est, qui dolorem ipsum, quia dolor sit amet consectetur adipisci[ng] velit, sed quia non numquam [do] eius modi tempora inci[di]dunt, ut labore et dolore magnam aliquam quaerat voluptatem."
  ];

  void setText(String newText) {
    setState(() {
      _textList.add(newText);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          // App bar display chat room info
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          toolbarHeight: 58,
          elevation: 0,
          backgroundColor: Colors.lightBlue.shade50.withOpacity(0.9),
          title: Row(
            children: [
              // container for image
              Container(
                  height: 58,
                  padding: const EdgeInsets.only(bottom: 5, right: 8, left: 30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: const Image(
                        image: AssetImage('lib/assets/avatar.png'),
                        fit: BoxFit.contain),
                  )),
              // container for chat room name
              Container(
                padding: const EdgeInsets.only(left: 30),
                child: const Text(
                  "Sample chat",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            // List of messages
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _textList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: MessageContainer(true, _textList[index]));
                  }),
            ),
            // Container for text input
            Container(
                // Outer container for bottom padding
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextInputWidget(setText)))
          ], // pass setText/callback to child widget/ text box
        ),
      ),
    );
  }
}
