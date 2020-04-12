import 'package:condor_sports_flutter/core/util/constants.dart';
import 'package:condor_sports_flutter/features/teams_db/presentation/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../../../injection_container.dart';

class SpeedDialFab extends StatefulWidget {
  final Function() onClick;
  final String toolTip;
  final IconData icon;

  SpeedDialFab({this.onClick, this.toolTip, this.icon});

  @override
  _SpeedDialFabState createState() => _SpeedDialFabState();
}

class _SpeedDialFabState extends State<SpeedDialFab> {
  TeamsDbBloc _teamsDbBloc;

  @override
  void initState() {
    super.initState();
    _teamsDbBloc = sl<TeamsDbBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      // this is ignored if animatedIcon is non null
      // child: Icon(Icons.add),
      visible: true,
      // If true user is forced to close dial manually
      // by tapping main button and overlay is not rendered.
      closeManually: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: Color(0xFF393536),
      foregroundColor: Colors.white,
      elevation: 8.0,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
            labelBackgroundColor: Color(0xFFFDCD07),
            child: SizedBox(
                height: 28.0,
                width: 28.0,
                child: Image.asset(
                  'images/ic_russian_league.png',
                )),
            backgroundColor: Color(0xFFFDCD07),
            label: 'Russian Premier League',
            labelStyle: TextStyle(fontSize: 14.0),
            onTap: () => _teamsDbBloc
                .add(GetTeamsByLeagueEvent(Constants.RUSSIAN_LEAGUE_ID))),
        SpeedDialChild(
          labelBackgroundColor: Color(0xFFFDCD07),
          child: new Image.asset('images/ic_english.png'),
          backgroundColor: Color(0xFFFDCD07),
          label: 'English League',
          labelStyle: TextStyle(fontSize: 14.0),
          onTap: () => _teamsDbBloc
              .add(GetTeamsByLeagueEvent(Constants.ENGLISH_LEAGUE_ID)),
        ),
        SpeedDialChild(
          labelBackgroundColor: Color(0xFFFDCD07),
          child: new Image.asset('images/ic_la_liga.png'),
          backgroundColor: Color(0xFFFDCD07),
          label: 'La Liga',
          labelStyle: TextStyle(fontSize: 14.0),
          onTap: () => _teamsDbBloc
              .add(GetTeamsByLeagueEvent(Constants.SPANISH_LEAGUE_ID)),
        ),
      ],
    );
  }
}
