import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team.dart';
import 'package:condor_sports_flutter/features/teams_db/presentation/bloc/team_details/bloc.dart';
import 'package:condor_sports_flutter/features/teams_db/presentation/widgets/loading_widget.dart';
import 'package:condor_sports_flutter/features/teams_db/presentation/widgets/message_display.dart';
import 'package:condor_sports_flutter/features/teams_db/presentation/widgets/team_events_widget.dart';
import 'package:condor_sports_flutter/features/teams_db/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../injection_container.dart';

class TeamDetailsPage extends StatelessWidget {
  static const route = "teamDetails";
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
                centerTitle: false,
                title: Container(
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        team.strTeam,
                        style: TextStyle(
                          color: Color(0xFF393536),
                          fontSize: 16.0,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      Text(
                        team.intFormedYear,
                        style: TextStyle(
                          color: Color(0xFF393536),
                          fontSize: 14.0,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                ),
                background: Container(
                  child: Image.network(
                    team.strTeamBadge,
                    fit: BoxFit.contain,
                    height: 280.0,
                  ),
                  alignment: Alignment.bottomLeft,
                  margin: EdgeInsets.fromLTRB(10, 0, 0, 20),
                ),
              ),
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
                child: FadeInImage.assetNetwork(
                  placeholder: 'images/ic_soccer_ball.svg',
                  image: team.strTeamJersey,
                  fit: BoxFit.contain,
                  height: 160,
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
                  padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
                  child: Text(
                    "Upcoming events",
                    style: _titleStyle,
                    textAlign: TextAlign.start,
                  )),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                  child: buildBody(context)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFFDCD07),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (int index) {
          switch (index) {
            case 0:
              _launchURL(context, team.strWebsite);
              break;
            case 1:
              _launchURL(context, team.strFacebook);
              break;
            case 2:
              _launchURL(context, team.strTwitter);
              break;
            case 3:
              _launchURL(context, team.strInstagram);
              break;
            case 4:
              _launchURL(context, team.strYoutube);
              break;
          }
        },
        items: allDestinations.map((Destination destination) {
          return BottomNavigationBarItem(
              icon: SvgPicture.asset(
                destination.icon,
                height: 24,
              ),
              backgroundColor: Color(0xFFFDCD07),
              title: Text(
                "",
              ));
        }).toList(),
      ),
    );
  }

  BlocProvider<TeamDetailsBloc> buildBody(BuildContext context) {
    List<APITeam> teams;

    return BlocProvider(
      create: (_) => sl<TeamDetailsBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              // Top half
              BlocBuilder<TeamDetailsBloc, TeamDetailsState>(
            // ignore: missing_return
            builder: (context, state) {
              if (state is EmptyDetails) {
                BlocProvider.of<TeamDetailsBloc>(context).add(GetTeamsFromDB());
              } else if (state is LoadingDetails) {
                return LoadingWidget();
              } else if (state is LoadedTeams) {
                teams = state.teams;

                BlocProvider.of<TeamDetailsBloc>(context)
                    .add(GetEventsByTeamEvent(team.idTeam));
              } else if (state is LoadedDetails) {
                return TeamEventsWidget(
                  events: state.events,
                  teams: teams,
                  homeTeamBadgeUrl: team.strTeamBadge,
                );
              } else if (state is ErrorDetails) {
                return MessageDisplay(
                    message: "There are no upcoming team events");
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
  final String icon;
}

const List<Destination> allDestinations = <Destination>[
  Destination('Home', "images/ic_website.svg"),
  Destination('Business', "images/ic_facebook.svg"),
  Destination('School', "images/ic_twitter.svg"),
  Destination('School', "images/ic_instagram.svg"),
  Destination('Flight', "images/ic_youtube.svg")
];

_launchURL(BuildContext context, String url) async {
  if (url != null && url.isNotEmpty && await canLaunch("https://" + url)) {
    print("launching: https://" + url);
    await launch("https://" + url);
  } else {
    final snackBar = SnackBar(content: Text('No url available'));

    Scaffold.of(context).showSnackBar(snackBar);
    throw 'Could not launch $url';
  }
}
