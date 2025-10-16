import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:technical_test_isaanita/presentation/blocs/crew_cast/crew_cast_bloc.dart';
import 'package:technical_test_isaanita/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:technical_test_isaanita/presentation/widget/cast_crew_widget.dart';
import 'package:technical_test_isaanita/presentation/widget/movie_detail_poster_widget.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;

  const MovieDetailPage({super.key, required this.movieId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    // panggil event lewat context.read biar pakai bloc dari main.dart
    context
        .read<MovieDetailBloc>()
        .add(MovieDetailInitialFetchEvent(movieId: widget.movieId));

    context
        .read<CrewCastBloc>()
        .add(FetchCrewCastInitialFetchEvent(movieId: widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is MovieDetailErrorState) {
              return _buildError(
                message: 'Failed to fetch movie detail',
                onRetry: () => context.read<MovieDetailBloc>().add(
                      MovieDetailInitialFetchEvent(movieId: widget.movieId),
                    ),
              );
            }

            if (state is MovieDetailSuccessfulFetchState) {
              final movie = state.movieDetailModel;
              final genres = movie.genres.map((g) => g.name).join(', ');
              final releaseDate = DateFormat('dd/MM/yyyy')
                  .format(DateTime.parse(movie.releaseDate));

              final crewList = [
                {'role': 'Director, Writer', 'name': 'Todd Phillips'},
                {'role': 'Characters', 'name': 'Bob Kane'},
                {'role': 'Characters', 'name': 'Bill Finger'},
                {'role': 'Characters', 'name': 'Bruce Timm'},
                {'role': 'Characters', 'name': 'Paul Dini'},
                {'role': 'Characters', 'name': 'Jerry Robinson'},
                {'role': 'Writer', 'name': 'Scott Silver'},
              ];

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MovieDetailPoster(
                      movie: movie,
                      genres: genres,
                      releaseDate: releaseDate,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Gambaran Umum",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            movie.overview.isNotEmpty
                                ? movie.overview
                                : 'No overview available.',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Divider(color: Colors.grey[300], thickness: 1),
                          const SizedBox(height: 16),

                          // Crew (sementara static)
                          CrewListWidget(crewList: crewList),

                          // Cast
                          BlocBuilder<CrewCastBloc, CrewCastState>(
                            builder: (context, crewCastState) {
                              if (crewCastState is CrewCastLoadingState) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              if (crewCastState is CrewCastErrorState) {
                                return _buildError(
                                  message: 'Failed to fetch crew & cast',
                                  onRetry: () => context
                                      .read<CrewCastBloc>()
                                      .add(FetchCrewCastInitialFetchEvent(
                                          movieId: widget.movieId)),
                                );
                              }

                              if (crewCastState
                                  is CrewCastSuccessfullFetchState) {
                                final castList = crewCastState.crewCastModels
                                    .where(
                                        (p) => p.knownForDepartment == 'Acting')
                                    .toList();

                                return Container(
                                  // elevation: 0,
                                  width: MediaQuery.of(context).size.width,
                                  color: const Color(0xFFF8F8F8),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 20.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Pemeran & Kru",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 200,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: castList.length,
                                            itemBuilder: (context, index) {
                                              final cast = castList[index];
                                              final imageUrl = cast
                                                          .profilePath !=
                                                      null
                                                  ? 'https://image.tmdb.org/t/p/w500${cast.profilePath}'
                                                  : 'https://via.placeholder.com/150x200?text=No+Image';

                                              return CastCard(
                                                imageUrl: imageUrl,
                                                name: cast.name,
                                                character: cast.originalName,
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }

                              return const SizedBox();
                            },
                          ),

                          // === Tambahan Statistik & Ulasan ===
                          const SizedBox(height: 16),

                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _MovieStatItem(title: 'Status', value: 'Rilis'),
                              _MovieStatItem(
                                  title: 'Bahasa Ucapan', value: 'Inggris'),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _MovieStatItem(
                                  title: 'Anggaran', value: '\$195,000,000.00'),
                              _MovieStatItem(
                                  title: 'Pemasukan',
                                  value: '\$200,714,058.00'),
                            ],
                          ),
                          const SizedBox(height: 24),

                          const Text(
                            "Ulasan",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),

                          Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Color(0xFF1976D2),
                                      child: Text(
                                        'T',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'austinmgray',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 4,
                                                ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFFFF3CD),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: const Row(
                                                  children: [
                                                    Icon(Icons.star,
                                                        color: Colors.amber,
                                                        size: 16),
                                                    SizedBox(width: 4),
                                                    Text(
                                                      '8.0',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 2),
                                          const Text(
                                            '25 November 2023',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                const Text(
                                  "one of the best installments to the Hunger Games series. it’s definitely the darkest and most political entry to the saga. act III could have been more fleshed out, but it doesn’t detract from the story the film is telling. act III was the most compelling segments in aspects of Coriolanus Snow’s villain origins.\n\n"
                                  "if you're a fan of political dramas or a character study or just a huge fan of the Hunger Games series, this is the film for you. excellent casting, excellent music, and deliciously evil performances.",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      height: 1.5),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  /// 🔁 widget error reusable biar gak duplikat kode
  Widget _buildError({
    required String message,
    required VoidCallback onRetry,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

class _MovieStatItem extends StatelessWidget {
  final String title;
  final String value;

  const _MovieStatItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
