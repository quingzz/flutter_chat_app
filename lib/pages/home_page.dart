import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_flutter_app/pages/chat_page.dart';
import 'package:simple_flutter_app/pages/search_user.dart';
import '../streamListeners/chatroom_stream.dart';
import '../models/chatroom.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _chatRooms = ['sample room', 'sample room'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // App bar display chat room info
        toolbarHeight: 58,
        elevation: 0,
        backgroundColor: Colors.lightBlue.shade50.withOpacity(0.9),
        title: Row(
          children: const [
            Expanded(
              child: Text(
                "Chats",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      // start of listing chat rooms
      body: ChangeNotifierProvider<ChatRoomStream>(
        create: (context) => ChatRoomStream(),
        child: Consumer<ChatRoomStream>(
          builder: (context, chatStream, child) {
            if (chatStream.listChats.length > 0) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: chatStream.listChats.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FutureBuilder<ChatRoom>(
                        future: chatStream.listChats[index],
                        builder: (context, AsyncSnapshot<ChatRoom> snapshot) {
                          if (snapshot.hasData) {
                            return ChatRoomCard(snapshot.data!);
                          } else {
                            return CircularProgressIndicator();
                          }
                        });
                  });
            } else {
              return Text('no chat room');
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Create new chat',
        backgroundColor: Colors.lightBlue.shade200,
        onPressed: () {
          showModalBottomSheet<dynamic>(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              builder: (BuildContext context) {
                return SearchUser();
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ChatRoomCard extends StatelessWidget {
  ChatRoom _room;
  ChatRoomCard(ChatRoom roomName, {Key? key})
      : _room = roomName,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    void enterChat() {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const ChatPage();
      }));
    }

    return InkWell(
        onTap: enterChat,
        hoverColor: Colors.blueGrey[300],
        splashColor: Colors.blue.withAlpha(30),
        radius: 200,
        child: Container(
          // Container with row and text
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Row(
            children: [
              Container(
                  // Container for image
                  height: 60,
                  padding: const EdgeInsets.only(right: 20, left: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image(
                        image: NetworkImage(_room.imgURL),
                        fit: BoxFit.fitHeight),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // room name
                    _room.roomName,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    // latest message
                    _room.lastMess,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 15),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
