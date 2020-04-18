import 'package:condor_sports_flutter/core/util/constants.dart';
import 'package:condor_sports_flutter/features/teams_db/presentation/bloc/bloc.dart';
import 'package:condor_sports_flutter/features/teams_db/presentation/widgets/loading_widget.dart';
import 'package:condor_sports_flutter/features/teams_db/presentation/widgets/message_display.dart';
import 'package:condor_sports_flutter/features/teams_db/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
/*
class TeamDetailsPage extends StatelessWidget {
  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Details'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<TeamsDbBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TeamsDbBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child:
              // Top half
              BlocBuilder<TeamsDbBloc, TeamsDbState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is Empty) {
                if (!isLoaded) {
                  BlocProvider.of<TeamsDbBloc>(context)
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
              }
            },
          ),
        ),
      ),
    );
  }
}

*/
