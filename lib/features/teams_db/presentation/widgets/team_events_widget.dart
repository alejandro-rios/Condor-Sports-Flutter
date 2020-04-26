import 'package:condor_sports_flutter/features/teams_db/domain/entities/api_team_events.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TeamEventsWidget extends StatefulWidget {
  final List<APITeamEvents> events;
  final String homeTeamBadgeUrl;

  const TeamEventsWidget({
    @required this.events,
    @required this.homeTeamBadgeUrl,
  });

  @override
  _TeamEventsWidgetState createState() => _TeamEventsWidgetState();
}

class _TeamEventsWidgetState extends State<TeamEventsWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.events.length,
        itemBuilder: (context, index) {
          return _eventItem(
              context, widget.events[index], widget.homeTeamBadgeUrl);
        });
  }

  Card _eventItem(
      BuildContext context, APITeamEvents event, String homeTeamBadgeUrl) {
    final String formattedDate =
        DateFormat("dd MMMM yyyy").format(DateTime.parse(event.dateEvent));

    return Card(
      elevation: 4.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 4.0),
                child: Container(
                  child: Center(
                    child: Image.network(
                      homeTeamBadgeUrl,
                      height: 80,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    event.strHomeTeam,
                    style: TextStyle(fontSize: 16, color: Color(0x8A000000)),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  formattedDate,
                  style: TextStyle(fontSize: 16, color: Color(0xFF393536)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "VS",
                  style: TextStyle(fontSize: 28, color: Color(0xFF393536)),
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 4.0),
                child: Container(
                  child: Center(
                    child: Image.network(
                      homeTeamBadgeUrl,
                      height: 80,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    event.strAwayTeam,
                    style: TextStyle(fontSize: 16, color: Color(0x8A000000)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
