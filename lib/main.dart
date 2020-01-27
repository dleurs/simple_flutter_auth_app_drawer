import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

import 'package:simple_flutter_auth_app/models/state.dart';
import 'package:simple_flutter_auth_app/ui/screens/page-one-screen.dart';
import 'package:simple_flutter_auth_app/ui/screens/page-three-screen.dart';
import 'package:simple_flutter_auth_app/ui/screens/page-two-screen.dart';
import 'package:simple_flutter_auth_app/ui/screens/user-screen.dart';
import 'package:simple_flutter_auth_app/ui/widgets/material-app-no-bottom-nav.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StateModel>(
      create: (context) => StateModel(),
      child: MaterialApp(
        title: 'My Flutter App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: BaseScaffold(),
      ),
    );
  }
}

class BaseScaffold extends StatefulWidget {
  @override
  _BaseScaffoldState createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  int pageIndex = 0;
  final PageStorageBucket bucket = PageStorageBucket();

  final List<Widget> pages = [
    PageOneScreen(
      key: PageStorageKey('Page1'),
    ),
    PageTwoScreen(
      key: PageStorageKey('Page2'),
    ),
    PageThreeScreen(
      key: PageStorageKey('Page3'),
    ),
  ];

  final List<String> titles = [
    "Page one",
    "Page two",
    "Page three",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(titles[pageIndex]),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.portrait),
                color: Colors.white,
                iconSize: 42.0,
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.downToUp,
                          child: MaterialAppNoBottomNav(
                              child: UserScreen(
                                key: PageStorageKey('PageUser'),
                              ),
                              title: "User",
                              bucket: bucket)));
                }),
          ],
        ),
        body: PageStorage(
          child: pages[this.pageIndex],
          bucket: this.bucket,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: this.pageIndex,
          onTap: (int indexInput) {
            setState(() => this.pageIndex = indexInput);
          },
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey[700],
          //showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted),
              title: Text('Page 1'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              title: Text('Page 2'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business_center),
              title: Text('Page 3'),
            ),
          ],
        ));
  }
}
