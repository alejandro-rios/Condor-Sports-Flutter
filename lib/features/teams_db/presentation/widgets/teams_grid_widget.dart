import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team.dart';
import 'package:condor_sports_flutter/features/teams_db/presentation/pages/team_details_page.dart';
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
      childAspectRatio: 1 / 1.5,
      crossAxisCount: widget.crossAxis,
      children: List.generate(widget.teams.length, (index) {
        return _teamItem(context, widget.teams[index]);
      }),
    );
  }

  Card _teamItem(BuildContext context, APITeam team) {
    return Card(
      elevation: 4.0,
      child: GestureDetector(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 0.0),
                  child: Container(
                    child: Center(
                      child: FadeInImage.assetNetwork(
                          placeholder: 'images/ic_soccer_ball.svg',
                          image: team.strTeamBadge,
                        height: 100,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ListTile(
                      title: Text(team.strTeam, style: TextStyle(fontSize: 15.0),),
                      subtitle: Text(team.strStadium, maxLines: 1, overflow: TextOverflow.fade, style: TextStyle(fontSize: 12.0),),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () => Navigator.pushNamed(context, TeamDetailsPage.route,
            arguments: team),
      ),
    );
  }
}
