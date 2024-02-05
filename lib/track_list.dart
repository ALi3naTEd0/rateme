import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TrackList extends StatelessWidget {
  final List<String>? trackNames;
  final Map<String, double> songRatings;
  final ValueChanged<double> onRatingUpdate;

  TrackList({
    required this.trackNames,
    required this.songRatings,
    required this.onRatingUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: List.generate(
          trackNames?.length ?? 0,
          (index) {
            final trackName = trackNames?[index] ?? 'Unknown Track';
            return ListTile(
              title: Text(trackName),
              subtitle: Row(
                children: [
                  Text('Rate:'),
                  SizedBox(width: 8.0),
                  RatingBar.builder(
                    initialRating: songRatings[trackName] ?? 0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 20,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: onRatingUpdate,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
