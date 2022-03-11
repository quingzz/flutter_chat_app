import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Message {
  final String _roomId;
  final String _message;
  final String _sender;

  String get roomId => _roomId;
  String get messageContent => _message;
  String get sender => _sender;

  Message(this._roomId, this._message, this._sender);

  void postMessage() {
    // Method to post Message to database

    // get database references
    final _databaseRef = FirebaseDatabase.instance.reference();
    final _messageTable = _databaseRef.child('messages/$_roomId');
    final _chatRoomRef = _databaseRef.child('chatrooms/$_roomId');

    // create new message object
    var newMessage = {
      'message': _message,
      'sender': _sender,
      'timestamp': DateTime.now().millisecondsSinceEpoch
    };

    // push a new node to messages/chatRoomId and set new node with predefined content
    _messageTable.push().set(newMessage);
    // Update latest message to the new message attribute of chatroom
    _chatRoomRef.update({'lastMess': _message});
  }

  // factory method to convert fetched data snapshot to Message object
  factory Message.fromDB(Map<String, dynamic> data, String roomId) {
    return Message(roomId, data['message'], data['sender']);
  }
}
