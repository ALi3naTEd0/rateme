// album_details_screen.dart
import 'package:flutter/material.dart';

class AlbumDetailsScreen extends StatefulWidget {
  final Map<String, dynamic>? albumDetails;

  AlbumDetailsScreen({required this.albumDetails});

  @override
  _AlbumDetailsScreenState createState() => _AlbumDetailsScreenState();
}

class _AlbumDetailsScreenState extends State<AlbumDetailsScreen> {
  Map<String, double> songRatings = {}; // Map to store song ratings

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>>? tracks = widget.albumDetails?['tracks']?.cast<Map<String, dynamic>>();

    if (tracks == null) {
      print('Tracks is null');
    } else {
      print('Number of tracks: ${tracks.length}');
      for (int i = 0; i < tracks.length; i++) {
        print('Track $i:');
        print('Track Number: ${tracks[i]['trackNumber']}');
        print('Track Name: ${tracks[i]['trackName']}');
        print('------');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Album Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.albumDetails!['artworkUrl100'] ?? ''),
            SizedBox(height: 16.0),
            Text(
              'Album: ${widget.albumDetails!['collectionName'] ?? ''}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Artist: ${widget.albumDetails!['artistName'] ?? ''}'),
            Text('Release Date: ${widget.albumDetails!['releaseDate'] ?? ''}'),
            SizedBox(height: 16.0),
            Text(
              'Tracklist:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),

            // Display track information in a ListView
            Expanded(
              child: ListView(
                children: tracks?.map((track) {
                  String trackNumber = track['trackNumber']?.toString() ?? 'N/A';
                  String trackName = track['trackName']?.toString() ?? 'N/A';

                  return ListTile(
                    title: Text('Track $trackNumber: $trackName'),
                    subtitle: Text('Rating ${track['rating'] ?? 'N/A'}'),
                  );
                }).toList() ?? [],
              ),
            ),

            // Submit button
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Calculate average rating
                double totalRating = 0;
                songRatings.forEach((key, value) {
                  totalRating += value;
                });

                double averageRating = songRatings.isNotEmpty
                    ? totalRating / songRatings.length
                    : 0;

                // TODO: Implement your logic to use averageRating
                print('Average Rating: $averageRating');
              },
              child: Text('Submit Ratings'),
            ),
          ],
        ),
      ),
    );
  }
}
