// ignore_for_file: prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:simple_flutter_app/pages/home_page.dart';
import 'package:simple_flutter_app/widgets/sidebar.dart';
import './widgets/sidebar_drawer.dart';
import './pages/login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './authentication/login_stats.dart';

void main() {
  runApp(const FlutterApp());
}

class FlutterApp extends StatelessWidget {
  const FlutterApp({Key? key}) : super(key: key);

  // This widget is the root of your application. Aka the entry point
  // Used for setting the theme for the app
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MaterialApp(
        title: 'Sample chat',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: App(),
      ),
    );
  }
}

// Connect to firebase and start the app
class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            body: Text('Error connecting to DB'),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return ChangeNotifierProvider<LoginStatus>(
            create: (context) => LoginStatus(),
            child: Consumer<LoginStatus>(
              builder: (context, loginStatus, child) {
                if (loginStatus.user != null) {
                  return SidebarDrawer(loginStatus.user);
                } else {
                  return LoginPage();
                }
              },
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }
}
