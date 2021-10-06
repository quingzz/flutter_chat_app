import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/chatroom.dart';

class ChatRoomStream extends ChangeNotifier {
  List<Future<ChatRoom>> _listChats = [];
  late StreamSubscription<Event> _chatroomStream;

  List<Future<ChatRoom>> get listChats => _listChats;

  final _database = FirebaseDatabase.instance.reference();
  ChatRoomStream() {
    _listenChatRoomStream();
  }

  void _listenChatRoomStream() {
    final _chatroomRef = _database.child('chatrooms');
    final currUser = FirebaseAuth.instance.currentUser;

    _chatroomStream = _chatroomRef.onValue.listen((event) {
      // get list of all chatrooms (format id : chatroom obj)
      final allChats = Map<String, dynamic>.from(event.snapshot.value);

      // go through each chat room in key:value format and change to ChatRoom obj
      _listChats = allChats.keys.map((roomId) async {
        var roomSnapshot = allChats[roomId];
        final roomData = Map<String, dynamic>.from(roomSnapshot);
        // Get member data from db
        Map<String, dynamic> memData = await _getMemData(roomData);

        return ChatRoom.fromDB(roomId, roomData, chatMember: memData);
      }).toList();

      notifyListeners();
    });
  }

  static Future<Map<String, dynamic>> _getMemData(
      Map<String, dynamic> roomData) async {
    final currUser = FirebaseAuth.instance.currentUser;

    late DataSnapshot memSnapshot;
    // get the list of id of members
    Map<String, dynamic> chatMemMap =
        Map<String, dynamic>.from(roomData['members']);
    List<String> members = List<String>.from(chatMemMap.keys);

    // get snapshot of member
    for (int i = 0; i < members.length; i++) {
      if (members[i] != currUser!.uid) {
        final memid = members[i];
        final memRef =
            FirebaseDatabase.instance.reference().child('user/$memid');
        // fetch member data from db and create ChatRoom object from given data
        memSnapshot = await memRef.once();
      }
    }
    Map<String, dynamic> memData = Map<String, dynamic>.from(memSnapshot.value);

    return memData;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _chatroomStream.cancel();
  }
}
