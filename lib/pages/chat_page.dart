import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/message_container.dart';
import '../widgets/textInputWidget.dart';
import '../models/chatroom.dart';
import '../models/message.dart';
import '../streamListeners/chatmessage_stream.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Widget used for ChatPage, creating a canvas to add other widgets on
class ChatPage extends StatefulWidget {
  final ChatRoom _room;
  // chat room info
  const ChatPage(ChatRoom room, {Key? key})
      : _room = room,
        super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _currUser = FirebaseAuth.instance.currentUser;
  final ScrollController _scrollController = ScrollController();

  // Funciton to add text
  void setText(String newText) {
    // setState(() {
    //   _textList.add(newText);
    // });

    if (newText.length > 0) {
      Message newMessage =
          new Message(widget._room.roomId, newText, _currUser!.uid);

      newMessage.postMessage();
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 150),
          curve: Curves.fastOutSlowIn);
    }
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
          title: ChatInfoBar(widget._room.imgURL, widget._room.roomName),
        ),
        body: Column(
          children: [
            // List of messages
            Expanded(
              child: ChangeNotifierProvider<ChatMessageStream>(
                create: (context) => ChatMessageStream(widget._room.roomId),
                child: Consumer<ChatMessageStream>(
                  builder: (context, messageStream, child) {
                    if (messageStream.messageList.length > 0) {
                      return ListView.builder(
                          shrinkWrap: true,
                          controller: _scrollController,
                          itemCount: messageStream.messageList.length,
                          itemBuilder: (BuildContext context, int index) {
                            var messObj = messageStream.messageList[index];
                            return Container(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: MessageContainer(
                                    _currUser!.uid == messObj.sender,
                                    messObj.messageContent));
                          });
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
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

class ChatInfoBar extends StatelessWidget {
  final String _imgURL;
  final String _roomName;
  const ChatInfoBar(String imgURL, String roomName, {Key? key})
      : _imgURL = imgURL,
        _roomName = roomName,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // container for image
        Container(
            height: 58,
            padding: const EdgeInsets.only(bottom: 5, right: 5, left: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(29),
              child: Image(image: NetworkImage(_imgURL), fit: BoxFit.contain),
            )),
        Expanded(child: Container()),
        // container for chat room name
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            _roomName,
            style: const TextStyle(
              overflow: TextOverflow.fade,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
