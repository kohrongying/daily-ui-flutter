// Theme toggle implemented with credit from https://itnext.io/an-easy-way-to-switch-between-dark-and-light-theme-in-flutter-fb971155eefe

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

const PAGE_HEIGHT = 600.0;
const PAGE_WIDTH = 300.0;
MyTheme currentTheme = MyTheme();


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/detail': (BuildContext context) => SettingDetailPage()},
      darkTheme: ThemeData.dark(),
      theme: ThemeData.light(),
      themeMode: currentTheme.currentTheme(),
      home: SettingsPage(),
      debugShowCheckedModeBanner: false,
    );
  }

  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }
}

class MyTheme with ChangeNotifier {
  bool _isDark = true;
  ThemeMode currentTheme() {
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void toggle() {
    _isDark = !_isDark;
    notifyListeners();
  }
}

class CustomPage extends StatelessWidget {
  final Widget child;
  final String title;

  CustomPage({this.child, this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: PAGE_WIDTH,
        height: PAGE_HEIGHT,
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: (){
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                }
              },
            ),
            automaticallyImplyLeading: true,
          ),
          body: child,
        ),
      ),
    );
  }
}

class HeadingItem extends StatelessWidget {
  final String heading;

  HeadingItem(this.heading);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        heading.toUpperCase(),
        style: TextStyle(
            fontSize: 12.0, fontWeight: FontWeight.w600, color: Colors.grey),
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final String title;
  final IconData icon;

  SettingItem(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/detail');
      },
      child: ListTile(
        dense: true,
        title: Text(title, style: TextStyle(fontSize: 12.0)),
        leading: Icon(
          icon,
          size: 18.0,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 13.0,
          color: Colors.grey[400],
        ),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List _settings = [
    {'heading': true, 'title': 'General', 'icon': null},
    {'heading': false, 'title': 'Account', 'icon': Icons.person},
    {'heading': false, 'title': 'Apps', 'icon': Icons.apps},
    {'heading': false, 'title': 'Bluetooth', 'icon': Icons.bluetooth},
    {'heading': false, 'title': 'Location', 'icon': Icons.location_on},
    {'heading': false, 'title': 'Notifications', 'icon': Icons.notifications},
    {'heading': true, 'title': 'Security and Privacy', 'icon': null},
    {'heading': false, 'title': 'Privacy', 'icon': Icons.lock},
    {'heading': false, 'title': 'Security', 'icon': Icons.security},
    {'heading': false, 'title': 'Biometrics', 'icon': Icons.fingerprint},
    {'heading': true, 'title': 'Appearance and Sound', 'icon': null},
    {'heading': false, 'title': 'Wallpaper', 'icon': Icons.wallpaper},
    {'heading': false, 'title': 'Sound', 'icon': Icons.volume_up},
    {'heading': false, 'title': 'Brightness', 'icon': Icons.brightness_medium},
  ];

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: "Settings",
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8.0),
        children: _settings.map((setting) {
          if (setting['heading']) {
            return HeadingItem(setting['title']);
          }
          return SettingItem(setting['title'], setting['icon']);
        }).toList(),
      ),
    );
  }
}

class SettingDetailPage extends StatefulWidget {
  @override
  _SettingDetailPageState createState() => _SettingDetailPageState();
}


class _SettingDetailPageState extends State<SettingDetailPage> {
  bool _switchVal = currentTheme._isDark;
  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: "General",
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Dark Mode'),
            Switch(
              value: _switchVal,
              onChanged: (newBool) {
                setState(() {
                  _switchVal = !_switchVal;
                  currentTheme.toggle();
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
