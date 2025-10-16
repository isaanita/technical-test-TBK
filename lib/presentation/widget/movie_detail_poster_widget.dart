import 'package:flutter/material.dart';
import 'package:technical_test_isaanita/data/models/movie_detail_models.dart';

class MovieDetailPoster extends StatelessWidget {
  const MovieDetailPoster({
    super.key,
    required this.movie,
    required this.genres,
    required this.releaseDate,
  });

  final MovieDetailModel movie;
  final String genres;
  final String releaseDate;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 390,
          width: double.infinity,
          child: Image.network(
            'https://image.tmdb.org/t/p/w500${movie.backdropPath.isNotEmpty ? movie.backdropPath : movie.posterPath}',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Container(color: Colors.grey[300]),
          ),
        ),
        // Gradient overlay
        Container(
          height: 390,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black54,
                Colors.black87,
              ],
            ),
          ),
        ),
        // Tombol back
        Positioned(
          top: 30,
          left: 16,
          child: CircleAvatar(
            backgroundColor: Colors.black45,
            child: IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        // Info film di atas poster
        Positioned(
          left: 20,
          right: 20,
          bottom: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                genres,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.calendar_today,
                      size: 16, color: Colors.white),
                  const SizedBox(width: 4),
                  Text(
                    releaseDate,
                    style:
                        const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.access_time,
                      size: 16, color: Colors.white),
                  const SizedBox(width: 4),
                  Text(
                    movie.runtime == 0
                        ? '-'
                        : '${movie.runtime} menit',
                    style:
                        const TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.play_arrow),
                      label: const Text("Lihat Trailer"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(999),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text("Watchlist"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(
                            color: Colors.white70),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(999),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 14),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade600,
                        borderRadius:
                            BorderRadius.circular(999),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 15.0,
                              color: Color.fromRGBO(
                                  113, 63, 18, 1),
                            ),
                            Text(
                              '${(movie.voteAverage * 10).toInt()}%',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
