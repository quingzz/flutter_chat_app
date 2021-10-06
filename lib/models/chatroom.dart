import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatRoom {
  final String _roomId;
  final String _roomName;
  final String _imgURL;
  final String _lastMess;

  String get roomId => _roomId;
  String get roomName => _roomName;
  String get imgURL => _imgURL;
  String get lastMess => _lastMess;

  ChatRoom(this._roomId, this._roomName, this._imgURL, this._lastMess);

  // factory constructor which creates obj from map of string : value
  // used for converting data from db to obj
  factory ChatRoom.fromDB(String roomId, Map<String, dynamic> data,
      {Map<String, dynamic>? chatMember}) {
    // final currUser = FirebaseAuth.instance.currentUser;
    late String? imgURL;
    late String? roomName;

    if (chatMember != null) {
      imgURL = chatMember['img'];
      roomName = chatMember['name'];
    } else {
      imgURL =
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXa1s1BI-GgogSRmwZYZiDRGN2Elkr5hfysw&usqp=CAU';
      roomName = 'Chat room';
    }

    return ChatRoom(
        roomId, roomName!, imgURL!, data['lastMess'] ?? 'No message');
  }
}
