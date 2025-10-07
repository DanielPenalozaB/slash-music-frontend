

class Song {
  final String id;
  final String title;
  final String artist;
  final String coverUrl;
  final Duration duration;

  const Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.coverUrl,
    required this.duration,
  });
}

class Playlist {
  final String id;
  final String title;
  final String coverUrl;
  final int songsCount;

  const Playlist({
    required this.id,
    required this.title,
    required this.coverUrl,
    required this.songsCount,
  });
}

// Imágenes libres (placeholders)
const _covers = [
  'https://images.unsplash.com/photo-1511379938547-c1f69419868d',
  'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4',
  'https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3',
  'https://images.unsplash.com/photo-1507874457470-272b3c8d8ee2',
  'https://images.unsplash.com/photo-1513863323963-0cc7f0b5140d',
];

final demoSongs = List<Song>.generate(
  10,
  (i) => Song(
    id: 's$i',
    title: 'Track #$i',
    artist: i.isEven ? 'Slash Band' : 'Lo-Fi Crew',
    coverUrl: _covers[i % _covers.length],
    duration: Duration(minutes: 3 + (i % 3), seconds: 10 + (i * 7) % 50),
  ),
);

final demoPlaylists = List<Playlist>.generate(
  8,
  (i) => Playlist(
    id: 'p$i',
    title: i.isEven ? 'Focus Beats $i' : 'Daily Mix $i',
    coverUrl: _covers[(i + 2) % _covers.length],
    songsCount: 15 + i,
  ),
);
