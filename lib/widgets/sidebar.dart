import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final double _width;
  const Sidebar(double width, {Key? key})
      : _width = width,
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
                  child: const Image(
                      image: AssetImage('lib/assets/avatar.png'),
                      fit: BoxFit.contain),
                )),
            // container for username
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: const Text(
                'Username',
                style: TextStyle(fontSize: 28, color: Colors.white),
              ),
            ),
            // container for button
            Container(
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Logout',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
    ;
  }
}
