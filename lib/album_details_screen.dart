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

  String _formatDuration(int milliseconds) {
    Duration duration = Duration(milliseconds: milliseconds);
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    int? trackNumber = widget.albumDetails?['trackNumber'] as int?;
    List<String>? trackName = widget.albumDetails?['trackName']?.cast<String>();
    String releaseDate = widget.albumDetails?['releaseDate'] ?? '';

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
            Text('Release Date: $releaseDate'),
            SizedBox(height: 16.0),
            Text(
              'Tracklist:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),

            // Generic Table with Fixed Data
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    TableCell(child: Text('Track #')),
                    TableCell(child: Text('Title')),
                    TableCell(child: Text('Rating')),
                  ],
                ),
                for (int i = 0; i < (trackName?.length ?? 0); i++)
                  TableRow(
                    children: [
                      TableCell(child: Text((trackNumber ?? 0).toString())),
                      TableCell(child: Text(trackName?[i] ?? '')),
                      TableCell(child: Text('Rating ${i + 1}')),
                    ],
                  ),
              ],
            ),

            // ...

            // Submit button
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Calculate average rating
                double totalRating = 0;
                songRatings.forEach((key, value) {
                  totalRating += value;
                });

                double averageRating =
                    songRatings.isNotEmpty ? totalRating / songRatings.length : 0;

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
