import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:catchthetrain/actions/actions.dart';
import 'package:catchthetrain/middleware/middleware.dart';
import 'package:catchthetrain/presentation/HomeScreen.dart';
import 'package:redux/redux.dart';

import 'package:catchthetrain/localization.dart';
import 'package:catchthetrain/models/app_state.dart';
import 'package:catchthetrain/reducers/app_state_reducer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    CatchTheTrainApp(
      store: Store<AppState>(
        appReducer,
        initialState: AppState.loading(),
        middleware: createAllMiddleware(),
      ),
    ),
  );
}

class CatchTheTrainApp extends StatelessWidget {
  final Store<AppState> store;

  const CatchTheTrainApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
          onGenerateTitle: (context) => ReduxLocalizations.of(context).translate('title'),
          theme: ThemeData(
              primaryColor: Colors.blue[500],
              primaryColorLight: Color.fromRGBO(110, 198, 255, 1),
              primaryColorDark: Color.fromRGBO(0, 105, 192, 1)),
          localizationsDelegates: [
            ReduxLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: [
            const Locale('en', ''),
            const Locale('de', ''),
          ],
          initialRoute: '/home',
          routes: {
            '/home': (context) {
              return HomeScreen(onInit: () {
                StoreProvider.of<AppState>(context)
                    .dispatch(LoadFavouredStopsAction());
              });
            },
          }),
    );
  }
}
