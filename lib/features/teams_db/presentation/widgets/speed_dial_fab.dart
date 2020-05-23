import 'package:condor_sports_flutter/core/util/constants.dart';
import 'package:condor_sports_flutter/features/teams_db/presentation/bloc/team_list/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class SpeedDialFab extends StatefulWidget {
  final TeamsListBloc teamListBloc;

  SpeedDialFab({@required this.teamListBloc});

  @override
  _SpeedDialFabState createState() => _SpeedDialFabState(teamListBloc);
}

class _SpeedDialFabState extends State<SpeedDialFab> {
  _SpeedDialFabState(Bloc<TeamsListEvent, TeamsListState> teamListBloc);

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
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: Color(0xFF393536),
      foregroundColor: Colors.white,
      elevation: 8.0,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
            labelBackgroundColor: Color(0xFFFDCD07),
            child: Image.asset('images/ic_russian_league.png', scale: 3),
            backgroundColor: Color(0xFFFDCD07),
            label: 'Russian Premier League',
            labelStyle: TextStyle(fontSize: 14.0),
            onTap: () => _dispatchGetTeams(Constants.RUSSIAN_LEAGUE_ID)),
        SpeedDialChild(
          labelBackgroundColor: Color(0xFFFDCD07),
          child: Image.asset('images/ic_english.png', scale: 3),
          backgroundColor: Color(0xFFFDCD07),
          label: 'English League',
          labelStyle: TextStyle(fontSize: 14.0),
          onTap: () => _dispatchGetTeams(Constants.ENGLISH_LEAGUE_ID),
        ),
        SpeedDialChild(
          labelBackgroundColor: Color(0xFFFDCD07),
          child: Image.asset('images/ic_la_liga.png', scale: 3),
          backgroundColor: Color(0xFFFDCD07),
          label: 'La Liga',
          labelStyle: TextStyle(fontSize: 14.0),
          onTap: () => _dispatchGetTeams(Constants.SPANISH_LEAGUE_ID),
        ),
      ],
    );
  }

  void _dispatchGetTeams(String leagueId) {
    widget.teamListBloc.add(GetTeamsByLeagueEvent(leagueId));
  }
}
