import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:simple_flutter_auth_app/models/state.dart';
import 'package:simple_flutter_auth_app/ui/widgets/loading.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    List<Widget> buildMenu(StateModel state) {
      List<Widget> builder = [];

      if (state.user != null) {
        builder.add(Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 0.0),
          child: Text("Hello"),
        ));
        if (state.user.isAnonymous) {
          builder.add(Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
            child: Text("Anonymous user",
                style: TextStyle(
                  fontSize: 24.0,
                )),
          ));
        }
        builder.add(RaisedButton(
          onPressed: () async {
            state.setIsLoading(true);
            await state.signOut();
            state.setIsLoading(false);
          },
          child: Text('Logout'),
        ));
      } else {
        builder.add(Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 18.0, 8.0, 8.0),
          child: Text("You are not connected",
              style: TextStyle(
                fontSize: 20.0,
              )),
        ));
        builder.add(
          FlatButton(
            onPressed: () async {
              state.setIsLoading(true);
              await state.signInAnonymous();
              state.setIsLoading(false);
            },
            child: Text(
              'Anonymous log in',
              style: TextStyle(color: Colors.black54),
            ),
          ),
        );
      }
      builder.add(
        Container(
          height: 300.0,
          child: ListView.builder(itemBuilder: (context, index) {
            if (index == 0) {
              return ListTile(
                title: Text("User page"),
                subtitle: Text(state.toString()),
              );
            }
            else if (index < 20) {
              return ListTile(
                title: Text('Lorem Ipsum'),
                subtitle: Text('$index'),
              );
            }
          }),
        ),
      );
      return builder;
    }

    return Consumer<StateModel>(builder: (context, state, child) {
        //print(state); // To check if there is not loop, consumer build one time 
        return LoadingScreen(
            inAsyncCall: state.isLoading,
            child: Center(
              child: Column(
                children: buildMenu(state),
              ),
            ));
      });
  }
}