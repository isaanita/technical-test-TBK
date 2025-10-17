import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test_isaanita/data/repositories/now_playing_repository.dart';
import 'package:technical_test_isaanita/data/repositories/top_rated_repository.dart';
import 'package:technical_test_isaanita/data/repositories/trending_movies_repository.dart';
import 'package:technical_test_isaanita/data/services/api_services.dart';
import 'package:technical_test_isaanita/presentation/blocs/now_playing_movies/now_playing_movie_bloc.dart';
import 'package:technical_test_isaanita/presentation/blocs/top_rated_movies/top_rated_movie_bloc.dart';
import 'package:technical_test_isaanita/presentation/blocs/trending_movies/trending_movie_bloc.dart';
import 'package:technical_test_isaanita/presentation/routes/app_routes.dart';
import 'package:technical_test_isaanita/presentation/widget/floating_bottom_bar_widget.dart';
import 'package:technical_test_isaanita/presentation/widget/genre_badges.dart';
import 'package:technical_test_isaanita/presentation/widget/now_playing_carousel_widget.dart';
import 'package:technical_test_isaanita/presentation/widget/section_title_home_page.dart';
import 'package:technical_test_isaanita/presentation/widget/trending_movies_carousel_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ApiService apiService;
  late final TrendingRepository repo;
  late final NowPlayingRepository nowPlayingRepo;
  late final TopRatedRepository topRatedRepo;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
    repo = TrendingRepository(apiService);
    nowPlayingRepo = NowPlayingRepository(apiService);
    topRatedRepo = TopRatedRepository(apiService);
  }

  final List<String> genres = [
    'Action',
    'Drama',
    'Comedy',
    'Thriller',
    'Sci-Fi',
    'Romance',
    'Horror',
    'Fantasy',
    'Animation',
    'Documentary',
    'Adventure',
    'Mystery',
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              TrendingMovieBloc()..add(TrendingMovieInitialFetchEvent()),
        ),
        BlocProvider(
          create: (context) =>
              NowPlayingMovieBloc()..add(NowPlayingMovieInitialFetchEvent()),
        ),
        BlocProvider(
          create: (context) =>
              TopRatedMovieBloc()..add(TopRatedMovieInitialFetchEvent()),
        )
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        appBar: AppBar(
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          elevation: 0,
          titleSpacing: 16,
          title: Row(
            children: [
              Image.asset('assets/logos/tmbd-horizontal.png'),
            ],
          ),
          actions: const [
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.notifications_none_rounded,
                color: Color(0xFF3D5AFE),
                size: 26,
              ),
            ),
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.search_outlined,
                color: Color(0xFF3D5AFE),
                size: 26,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10.0, bottom: 120.0, top: 10.0),
          child: Column(
            children: [
              SectionTitleHomePage(
                title: 'Trending',
                subtitle: 'Hari ini',
                onSeeAllTap: () {
                  Navigator.pushNamed(context, AppRoutes.trending);
                },
              ),
              BlocBuilder<TrendingMovieBloc, TrendingMovieState>(
                builder: (context, state) {
                  if (state is TrendingMovieFetchingLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TrendingMovieFetchingErrorState) {
                    return const Text("Error");
                  } else if (state is TrendingMovieSuccessfulFetchState) {
                    final movies = state.trendingMoviesModels;

                    // 🎯 ini bagian penting
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal, // scroll ke samping
                      child: Row(
                        children: movies.map((movie) {
                          return TrendingMoviesCarouselWidget(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            title: movie.displayTitle,
                            description: movie.overview,
                            rating: '60',
                            onSeeAllTap: () {
                              // Navigasi ke halaman detail
                              Navigator.pushNamed(
                                context,
                                AppRoutes.movieDetail,
                                arguments: movie.id, // <-- kirim movieId
                              );
                            },
                          );
                        }).toList(),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 15, top: 30),
                child: SectionTitleHomePage(
                  title: 'Baru Rilis',
                  subtitle: 'Oktober',
                ),
              ),
              BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState>(
                builder: (context, state) {
                  if (state is NowPlayingMovieFetchingLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is NowPlayingMovieFetchingErrorState) {
                    return const Text("error");
                  } else if (state is NowPlayingMovieSuccessfullFetchState) {
                    final nowPlayingMovies = state.nowPlayingModels;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: nowPlayingMovies.map((movie) {
                          return NowPlayingCarouselWidget(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            title: movie.title,
                            rating: 6.0,
                            onSeeAllTap: () {
                              // Navigasi ke halaman detail
                              Navigator.pushNamed(
                                context,
                                AppRoutes.movieDetail,
                                arguments: movie.id, // <-- kirim movieId
                              );
                            },
                          );
                        }).toList(),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 15, top: 40),
                child: SectionTitleHomePage(
                  title: 'Rating Tertinggi',
                  subtitle: '',
                ),
              ),
              BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
                builder: (context, state) {
                  if (state is TopRatedMovieLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TopRatedMovieErrorState) {
                    return const Text("error");
                  } else if (state is TopRatedMovieSuccessfullFetchState) {
                    final topRatedMovies = state.topRatedModels;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: topRatedMovies.map((movie) {
                          return TrendingMoviesCarouselWidget(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            title: movie.title,
                            description: movie.overview,
                            rating: '87',
                            releaseDate: movie.releaseDate,
                            variant: TrendingMoviesVariant.compact,
                            onSeeAllTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.movieDetail,
                                arguments: movie.id,
                              );
                            },
                          );
                        }).toList(),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 15, top: 40),
                child: SectionTitleHomePage(
                  title: 'Jelajahi FIlm & Serial TV',
                  subtitle: '',
                  showSeeAll: false,
                ),
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    genres.map((genre) => GenreBadge(label: genre)).toList(),
              )
            ],
          ),
        ),
        bottomNavigationBar: const FloatingBottomBar(
          currentIndex: 0,
        ),
      ),
    );
  }
}
