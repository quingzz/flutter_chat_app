import 'package:flutter/material.dart';
import 'package:simple_flutter_app/pages/chat_page.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({Key? key}) : super(key: key);

  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  final List<String> _users = ['Sample users', 'Sample users'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _searchUser() {
    // Update list of users based on input
    // Called when text in text field is changed
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // On tap, unfocus current focus scope (text field)
        FocusScope.of(context).unfocus();
      },
      child: Container(
        // For some reason, gesture detector only works when there is color :/
        color: Colors.white.withOpacity(0),
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          children: [
            SearchBar(),
            ListView.builder(
                shrinkWrap: true,
                itemCount: _users.length,
                itemBuilder: (BuildContext context, int index) {
                  return UserCard(_users[index]);
                })
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _textController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
        margin: const EdgeInsets.only(top: 5, right: 10, left: 10, bottom: 20),
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: TextField(
          controller: _textController,
          decoration: const InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search),
            fillColor: Colors.grey,
          ),
        ));
  }
}

class UserCard extends StatelessWidget {
  final String _username;
  const UserCard(String username, {Key? key})
      : _username = username,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    void enterChat() {
      // Navigator.pop(context);
      // Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return ChatPage();
      // }));
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
              Text(
                // Username
                'Username',
                textAlign: TextAlign.left,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ));
  }
}
