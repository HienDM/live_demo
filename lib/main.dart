import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:live_demo/shared/app_route.dart';
import 'package:live_demo/ui/CreateLive/create_live.dart';
import 'package:live_demo/ui/WatchLive/watch_live.dart';
import 'package:permission_handler/permission_handler.dart';

const appId = "ef1d23da076141088c35b5467ee61753";
const token = "<-- Insert Token -->";
const channel = "<-- Insert Channel Name -->";

void main() => runApp(const MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _controller = CupertinoTabController();
  int _currentIndex = 0;
  static final List<Widget> _widgetOptions = [
    const CreateLiveScreen(),
    const WatchLiveScreen(),
  ];

  static final List<GlobalKey<NavigatorState>> _tabNavKey = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live_demo'),
      ),
      body: CupertinoTabScaffold(
        resizeToAvoidBottomInset: false,
        tabBar: CupertinoTabBar(
          backgroundColor: const Color(0xFFF2F2F9).withOpacity(0.8),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.camera),
              label: 'Tạo Live',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.remove_red_eye),
              label: 'Xem Live',
            ),
          ],
          onTap: (index) {
            if (index == _currentIndex) {
              _tabNavKey
                  .elementAt(index)
                  .currentState
                  ?.popUntil((r) => r.isFirst);
            }
            _currentIndex = index;
          },
        ),
        controller: _controller,
        tabBuilder: (context, index) {
          return CupertinoTabView(
            navigatorKey: _tabNavKey.elementAt(index),
            builder: (BuildContext context) => _widgetOptions.elementAt(index),
            onGenerateRoute: AppRouteExt.generateRoute,
          );
        },
      ),
    );
  }
}
