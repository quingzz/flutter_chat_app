import 'package:flutter/material.dart';
import '../authentication/google_signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Sidebar extends StatelessWidget {
  User? _currUser;
  final double _width;
  Sidebar(User? currUser, double width, {Key? key})
      : _currUser = currUser,
        _width = width,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      height: double.infinity,
      child: Container(
        color: Colors.blue.shade800,
        child: Column(
          children: [
            // container for user avatar
            Container(
                padding: const EdgeInsets.only(
                    top: 80, right: 90, left: 90, bottom: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image(
                      image: NetworkImage(_currUser!.photoURL.toString()),
                      fit: BoxFit.contain),
                )),
            // container for username
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              alignment: Alignment.center,
              child: Text(
                _currUser!.displayName,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
            // container for button
            Container(
              child: ElevatedButton(
                onPressed: () {
                  GoogleAuth.signOut();
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
