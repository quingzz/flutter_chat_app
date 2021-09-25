import 'package:flutter/material.dart';
import '../authentication/google_signin.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: const Text(
                'Use current google account',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: ElevatedButton(
                    onPressed: () {
                      GoogleAuth.signInWithGoogle();
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 1, vertical: 1)),
                    child: Row(
                      children: [
                        Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            margin: EdgeInsets.all(2),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            child: const Image(
                              height: 40,
                              image: AssetImage('lib/assets/google.png'),
                              fit: BoxFit.contain,
                            )),
                        const Expanded(
                            child: Center(
                          child: Text('Login with Google',
                              style: TextStyle(fontSize: 20)),
                        ))
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
