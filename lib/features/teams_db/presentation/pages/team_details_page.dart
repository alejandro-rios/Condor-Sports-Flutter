import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team.dart';
import 'package:condor_sports_flutter/features/teams_db/presentation/bloc/team_details/bloc.dart';
import 'package:condor_sports_flutter/features/teams_db/presentation/widgets/loading_widget.dart';
import 'package:condor_sports_flutter/features/teams_db/presentation/widgets/message_display.dart';
import 'package:condor_sports_flutter/features/teams_db/presentation/widgets/team_events_widget.dart';
import 'package:condor_sports_flutter/features/teams_db/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../injection_container.dart';

class TeamDetailsPage extends StatelessWidget {
  static const route = "teamDetails";
  final facebookIcon = SvgPicture.asset("images/ic_facebook.svg");
  TextStyle _titleStyle = TextStyle(
      color: Color(0xFF393536), fontSize: 18.0, fontWeight: FontWeight.bold);
  final APITeam team;

  TeamDetailsPage(this.team);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 350.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        team.strTeam,
                        style: TextStyle(
                          color: Color(0xFF393536),
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.end,
                      )),
                  background: Container(
                      child: Image.network(
                        team.strTeamBadge,
                        fit: BoxFit.contain,
                        height: 280.0,
                      ),
                      alignment: Alignment.centerLeft)),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Oficial Jersey",
                    style: _titleStyle,
                    textAlign: TextAlign.start,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  team.strTeamJersey,
                  fit: BoxFit.contain,
                  height: 160.0,
                ),
              ),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Description",
                    style: _titleStyle,
                    textAlign: TextAlign.start,
                  )),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  team.strDescriptionEN,
                  style: TextStyle(
                    color: Color(0xFF393536),
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Upcoming events",
                    style: _titleStyle,
                    textAlign: TextAlign.start,
                  )),
              Container(
                  width: double.infinity,
                  height: 500,
                  padding: EdgeInsets.all(8.0),
                  child: buildBody(context)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: 0,
        onTap: (int index) {
//          setState(() {
//            _currentIndex = index;
//          });
        },
        items: allDestinations.map((Destination destination) {
          return BottomNavigationBarItem(
              icon: Icon(destination.icon),
              backgroundColor: Color(0xFFFDCD07),
              title: Text(
                "",
                style: TextStyle(fontSize: 0),
              ));
        }).toList(),
      ),
    );
  }

  BlocProvider<TeamDetailsBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TeamDetailsBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child:
              // Top half
              BlocBuilder<TeamDetailsBloc, TeamDetailsState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is EmptyDetails) {
                BlocProvider.of<TeamDetailsBloc>(context)
                    .add(GetEventsByTeamEvent(team.idTeam));
              } else if (state is LoadingDetails) {
                return LoadingWidget();
              } else if (state is LoadedDetails) {
                print(state.events);
                return TeamEventsWidget(events: state.events, homeTeamBadgeUrl: team.strTeamBadge,);
              } else if (state is ErrorDetails) {
                return MessageDisplay(message: state.message);
              }
            },
          ),
        ),
      ),
    );
  }
}

class Destination {
  const Destination(this.title, this.icon);

  final String title;
  final IconData icon;
}

const List<Destination> allDestinations = <Destination>[
  Destination('Home', Icons.face),
  Destination('Business', Icons.business),
  Destination('School', Icons.school),
  Destination('School', Icons.inbox),
  Destination('Flight', Icons.flight)
];
