import 'package:flutter/material.dart';
import '../../../common/mock/mock_music.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/mini_player.dart';
import '../widgets/playlist_card.dart';
import '../widgets/section_header.dart';
import '../widgets/song_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: true,
            titleSpacing: 16,
            title: const Text(
              'Slash Music',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none_rounded),
              ),
              const SizedBox(width: 4),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(72), // <-- antes 56
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  16,
                  0,
                  16,
                  8,
                ), // menos padding abajo
                child: SizedBox(
                  height: 48, // altura exacta del campo
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: 'Search songs, artists, albums…',
                      prefixIcon: const Icon(Icons.search_rounded),
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ), // sin extra vertical
                      filled: true,
                      fillColor: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Trending
          const SliverToBoxAdapter(child: SectionHeader(title: 'Trending Now')),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 220,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: demoSongs.length,
                padding: const EdgeInsets.only(right: 16),
                itemBuilder: (context, i) => SongCard(
                  song: demoSongs[i],
                  onTap: () {
                    // aquí luego navegas a la pantalla de reproducción
                  },
                ),
              ),
            ),
          ),

          // Made for you (grid)
          const SliverToBoxAdapter(child: SectionHeader(title: 'Made for You')),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            sliver: SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                mainAxisExtent: 256,
              ),
              itemCount: demoPlaylists.length,
              itemBuilder: (context, i) =>
                  PlaylistCard(playlist: demoPlaylists[i], onTap: () {}),
            ),
          ),

          // Recently played
          const SliverToBoxAdapter(
            child: SectionHeader(title: 'Recently Played'),
          ),
          SliverList.separated(
            itemCount: demoSongs.length.clamp(0, 6),
            separatorBuilder: (_, __) =>
                const Divider(height: 1, indent: 16, endIndent: 16),
            itemBuilder: (context, i) {
              final s = demoSongs[i];
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    s.coverUrl,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  s.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  s.artist,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.more_horiz_rounded),
                  onPressed: () {},
                ),
                onTap: () {},
              );
            },
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 96),
          ), // espacio para bottom widgets
        ],
      ),

      // Mini player + bottom nav
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const MiniPlayer(
            song: Song(
              id: 'demo',
              title: 'Demo Track',
              artist: 'Slash Band',
              coverUrl:
                  'https://images.unsplash.com/photo-1511379938547-c1f69419868d',
              duration: Duration(minutes: 3, seconds: 20),
            ),
          ),
          AppBottomNav(
            currentIndex: _tab,
            onTap: (i) => setState(() => _tab = i),
          ),
        ],
      ),
    );
  }
}
