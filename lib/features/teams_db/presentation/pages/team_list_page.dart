import 'package:condor_sports_flutter/core/util/constants.dart';
import 'package:condor_sports_flutter/features/teams_db/presentation/bloc/team_list/bloc.dart';
import 'package:condor_sports_flutter/features/teams_db/presentation/widgets/loading_widget.dart';
import 'package:condor_sports_flutter/features/teams_db/presentation/widgets/message_display.dart';
import 'package:condor_sports_flutter/features/teams_db/presentation/widgets/speed_dial_fab.dart';
import 'package:condor_sports_flutter/features/teams_db/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../injection_container.dart';

class TeamListPage extends StatelessWidget {
  static const route = "teamList";
  final refreshIcon = SvgPicture.asset("images/doughnut.svg");
  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final teamsListBloc = sl<TeamsListBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Condor Sports',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        centerTitle: false,
      ),
      body: Center(
        child: buildBody(context, teamsListBloc),
      ),
      floatingActionButton: SpeedDialFab(teamListBloc: teamsListBloc),
    );
  }

  BlocProvider<TeamsListBloc> buildBody(
    BuildContext context,
    TeamsListBloc teamsBloc,
  ) {
    return BlocProvider(
      create: (_) => teamsBloc,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<TeamsListBloc, TeamsListState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is Empty) {
                if (!isLoaded) {
                  BlocProvider.of<TeamsListBloc>(context)
                      .add(GetTeamsByLeagueEvent(Constants.SPANISH_LEAGUE_ID));
                }
              } else if (state is Loading) {
                return LoadingWidget();
              } else if (state is Loaded) {
                isLoaded = true;
                return TeamGridWidget(
                  crossAxis: 3,
                  teams: state.teams,
                );
              } else if (state is Error) {
                return MessageDisplay(message: state.message);
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
