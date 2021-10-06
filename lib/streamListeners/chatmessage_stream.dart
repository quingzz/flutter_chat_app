import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/message.dart';

class ChatMessageStream extends ChangeNotifier {
  List<Message> _messageList = [];
  late String _roomId;
  late StreamSubscription<Event> _messageStream;

  ChatMessageStream(String roomId) {
    _roomId = roomId;
    _listenMessageStream();
  }

  List<Message> get messageList => _messageList;

  final _databaseRef = FirebaseDatabase.instance.reference();

  void _listenMessageStream() {
    final _messageRef =
        _databaseRef.child('messages/$_roomId').orderByChild('timestamp');
    _messageStream = _messageRef.onValue.listen((event) {
      final allMessages = Map<String, dynamic>.from(event.snapshot.value);
      _messageList = allMessages.values
          .map((snapshot) =>
              Message.fromDB(Map<String, dynamic>.from(snapshot), _roomId))
          .toList();

      notifyListeners();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _messageStream.cancel();
    super.dispose();
  }
}
