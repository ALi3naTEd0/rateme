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
    // Fetch track information from albumDetails
    List<Map<String, dynamic>>? tracks =
        widget.albumDetails?['tracks']?.cast<Map<String, dynamic>>();

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

            // Display track information in a Table
            Table(
              border: TableBorder.all(),
              children: [
                // Header row
                TableRow(
                  children: [
                    TableCell(child: Text('Track #')),
                    TableCell(child: Text('Title')),
                    TableCell(child: Text('Rating')),
                  ],
                ),
                // Data rows
                for (int i = 0; i < (tracks?.length ?? 0); i++)
                  TableRow(
                    children: [
                      TableCell(child: Text((tracks![i]['trackNumber'] ?? i + 1).toString())),
                      TableCell(child: Text(tracks![i]['trackName']?.toString() ?? 'N/A')),
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
