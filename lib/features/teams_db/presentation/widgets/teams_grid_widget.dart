import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team.dart';
import 'package:flutter/material.dart';

class TeamGridWidget extends StatefulWidget {
  final int crossAxis;
  final List<APITeam> teams;

  const TeamGridWidget({
    @required this.crossAxis,
    @required this.teams,
  });

  @override
  _TeamGridWidgetState createState() => _TeamGridWidgetState();
}

class _TeamGridWidgetState extends State<TeamGridWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: widget.crossAxis,
      children: List.generate(widget.teams.length, (index) {
        return _teamItem(context, widget.teams[index]);
      }),
    );
  }

  Card _teamItem(BuildContext context, APITeam team) {
    return Card(
      elevation: 4.0,
      child: Container(
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                child: Center(
                  child: Image.network(
                    team.strTeamBadge,
                    height: 100,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ListTile(
//      title: widget.teams[index].strTeamBadge == null ? Image.asset(Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL) : Image.network(widget.teams[index].strTeamBadge),
                  title: Text(team.strTeam),
                  subtitle: Text(team.strStadium),
                ),
              ),
            ],
          ),
          onTap: () => print("Click on "+team.strTeam),
        ),
      ),
    );
  }
}
