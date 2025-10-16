import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technical_test_isaanita/presentation/blocs/trending_movies/trending_movie_bloc.dart';
import 'package:technical_test_isaanita/presentation/widget/category_segmented_control_widget.dart';
import 'package:technical_test_isaanita/presentation/widget/floating_bottom_bar_widget.dart';
import 'package:technical_test_isaanita/presentation/widget/trending_movies_carousel_widget.dart';

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  late TrendingMovieBloc trendingBloc;

  @override
  void initState() {
    super.initState();
    trendingBloc = TrendingMovieBloc()..add(TrendingMovieInitialFetchEvent());
  }

  @override
  void dispose() {
    trendingBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: trendingBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          title: const Text(
            "Trending Hari ini",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(
              top: 10.0, left: 16.0, right: 16.0, bottom: 120.0),
          child: Column(
            children: [
              CategorySegmentedControlWidget(
                items: const ["Semua", "Film", "Serial TV"],
                onChanged: (index) {
                  if (index == 0) {
                    trendingBloc.add(TrendingMovieInitialFetchEvent());
                  } else if (index == 1) {
                    trendingBloc.add(TrendingMovieCategoryInitialFetchEvent());
                  } else {
                    trendingBloc.add(TrendingTVCategoryInitialFetchEvent());
                  }
                },
              ),
              BlocBuilder<TrendingMovieBloc, TrendingMovieState>(
                builder: (context, state) {
                  if (state is TrendingMovieFetchingLoadingState) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height -
                          kToolbarHeight -
                          120, // sesuaikan padding bawah
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is TrendingMovieFetchingErrorState) {
                    return const Text("Error");
                  } else if (state is TrendingMovieSuccessfulFetchState) {
                    final movies = state.trendingMoviesModels;

                    return Column(
                      children: movies.map((movie) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: TrendingMoviesCarouselWidget(
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            title: movie.displayTitle,
                            description: movie.overview,
                            rating: '60',
                          ),
                        );
                      }).toList(),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: const FloatingBottomBar(currentIndex: 1),
      ),
    );
  }
}
