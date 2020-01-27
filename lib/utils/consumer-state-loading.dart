/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:simple_flutter_auth_app/models/state.dart';
import 'package:simple_flutter_auth_app/ui/widgets/loading.dart';

class ConsumerAndLoading extends StatelessWidget {
  final Widget child;

  ConsumerAndLoading({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer<StateModel>(builder: (context, state, child) {
      return LoadingScreen(
        inAsyncCall: state.isLoading,
        child: child,
      );
    });
  }
}
*/