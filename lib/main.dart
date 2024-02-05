import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'album_details_screen.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rate Me!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AlbumSearchScreen(),
    );
  }
}

class AlbumSearchScreen extends StatefulWidget {
  @override
  _AlbumSearchScreenState createState() => _AlbumSearchScreenState();
}

class _AlbumSearchScreenState extends State<AlbumSearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  void _searchAlbums() async {
    final query = _searchController.text.trim();

    if (query.isEmpty) {
      return;
    }

    final response = await http.get(
      Uri.parse('https://itunes.apple.com/search?term=$query&entity=album'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      setState(() {
        _searchResults = List<Map<String, dynamic>>.from(results);
      });
    } else {
      print('Failed to load album data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Rate Me!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search for an album',
              ),
              onChanged: (_) => _searchAlbums(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _searchAlbums,
              child: Text('Search'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final album = _searchResults[index];
                  return ListTile(
                    title: Text(album['collectionName']),
                    subtitle: Text(album['artistName']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AlbumDetailsScreen(albumDetails: album),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
