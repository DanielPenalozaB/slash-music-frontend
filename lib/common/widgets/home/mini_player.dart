import 'package:flutter/material.dart';
import '../../mock/mock_music.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key, required this.song, this.onTapPlay});

  final Song song;
  final VoidCallback? onTapPlay;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Material(
      color: color.surface,
      elevation: 8,
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(song.coverUrl, width: 48, height: 48, fit: BoxFit.cover),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(song.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  Text(song.artist,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: color.onSurfaceVariant)),
                ],
              ),
            ),
            IconButton(
              onPressed: onTapPlay,
              icon: const Icon(Icons.play_arrow_rounded, size: 28),
            ),
          ],
        ),
      ),
    );
  }
}
