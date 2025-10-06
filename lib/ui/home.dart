import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slash_music_frontend/core/configs/assets/app_images.dart';
import 'package:slash_music_frontend/resource/constants.dart';

class HomePage extends StatefulWidget {
  // Optional: allow passing name via constructor (useful for direct navigation)
  final String? displayName;

  const HomePage({this.displayName, super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String? _displayName;

  @override
  void initState() {
    super.initState();
    // Prefer route arg, then constructor prop
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Map && args['name'] != null) {
        setState(() => _displayName = args['name'] as String);
      } else if (widget.displayName != null) {
        setState(() => _displayName = widget.displayName);
      }
    });
  }

  Future<void> _signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(Constants.accessKey);
    await prefs.remove(Constants.refreshKey);

    // Optionally remove any other saved user info
    // await prefs.remove('user_name');

    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed('/signin');
  }

  void _onNavTap(int index) {
    setState(() => _selectedIndex = index);
    // TODO: route to other pages or load different content
  }

  @override
  Widget build(BuildContext context) {
    final greeting = _displayName != null && _displayName!.isNotEmpty
        ? 'Welcome, ${_displayName!}'
        : 'Welcome';

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(AppImages.logoFull, height: 32),
            const SizedBox(width: 12),
            Expanded(child: Text(greeting)),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Optionally open search page
              setState(() => _selectedIndex = 1);
            },
            icon: const Icon(Icons.search),
            tooltip: 'Search',
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(_displayName ?? 'Guest'),
                accountEmail: const Text(''),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: const Icon(
                    Icons.person,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  Navigator.of(context).pop();
                  _onNavTap(0);
                },
              ),
              ListTile(
                leading: const Icon(Icons.library_music),
                title: const Text('Your Library'),
                onTap: () {
                  Navigator.of(context).pop();
                  _onNavTap(2);
                },
              ),
              const Spacer(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Sign out'),
                onTap: () async {
                  Navigator.of(context).pop();
                  await _signOut();
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: _buildBodyForIndex(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Library',
          ),
        ],
      ),
    );
  }

  Widget _buildBodyForIndex(int index) {
    switch (index) {
      case 1:
        return _buildSearchPlaceholder();
      case 2:
        return _buildLibraryPlaceholder();
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildSearchPlaceholder() {
    return const Center(
      child: Text('Search page - coming soon', style: TextStyle(fontSize: 18)),
    );
  }

  Widget _buildLibraryPlaceholder() {
    return const Center(
      child: Text('Library page - coming soon', style: TextStyle(fontSize: 18)),
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting + small subtitle
          Text(
            _displayName != null
                ? 'Welcome back, ${_displayName!}!'
                : 'Welcome back!',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Search input (visual)
          TextField(
            readOnly: true,
            onTap: () {
              setState(() => _selectedIndex = 1);
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search for artists, songs, or podcasts',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Horizontal playlists (mock)
          const Text(
            'Made for you',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, idx) => _playlistCard(idx),
            ),
          ),

          const SizedBox(height: 24),

          // Grid of tracks (mock)
          const Text(
            'Popular',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 8,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 3 / 2,
            ),
            itemBuilder: (context, idx) => _songCard(idx),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _playlistCard(int idx) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(8),
        image: const DecorationImage(
          image: AssetImage(AppImages.logoFull), // placeholder image
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          width: double.infinity,
          child: Text(
            'Playlist ${idx + 1}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _songCard(int idx) {
    return Material(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: () {
          // TODO: play track or navigate to track page
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Play song ${idx + 1}')));
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(6),
                  image: const DecorationImage(
                    image: AssetImage(AppImages.logoFull), // placeholder
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Song ${idx + 1}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Artist ${idx + 1}',
                      style: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Queued song ${idx + 1}')),
                ),
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
