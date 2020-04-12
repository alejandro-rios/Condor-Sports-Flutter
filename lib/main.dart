import 'package:condor_sports_flutter/features/teams_db/presentation/pages/team_list_page.dart';
import 'package:flutter/material.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Color(0xFFFDCD07),
          primaryColorDark: Color(0xFFC59D00),
          accentColor: Color(0xFF393536)),
      home: TeamListPage(),
    );
  }
}
