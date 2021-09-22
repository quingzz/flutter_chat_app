import 'package:flutter/material.dart';
import 'package:simple_flutter_app/pages/chat_page.dart';
import 'package:simple_flutter_app/pages/search_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _chatRooms = ['sample room', 'sample room'];

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
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: _chatRooms.length,
          itemBuilder: (BuildContext context, int index) {
            return ChatRoomCard(_chatRooms[index]);
          }),
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
  String _roomName;
  ChatRoomCard(String roomName, {Key? key})
      : _roomName = roomName,
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
                    child: const Image(
                        image: AssetImage('lib/assets/room.jpg'),
                        fit: BoxFit.fitHeight),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // room name
                    _roomName,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    // room name
                    'latest message',
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
