import 'package:flutter/widgets.dart';

import '../bandeja_bloc.dart';

class BandejaBlocProvider extends InheritedWidget {
  final BandejaBloc bloc;

  BandejaBlocProvider({Key key, Widget child}) : bloc = BandejaBloc(), super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static BandejaBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BandejaBlocProvider) as BandejaBlocProvider).bloc;
  }
}