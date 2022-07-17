import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix_analysis/charts/numbers_chart.dart';
import 'package:netflix_analysis/charts/text_numbers_chart.dart';
import 'package:netflix_analysis/services/service.dart';

class AnalysisPage extends ConsumerWidget {
  const AnalysisPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final imdbScoreData = ref.watch(analysisProvider("imdb_score"));
    final tmdbScoreData = ref.watch(analysisProvider("tmdb_score"));
    final runtimeData = ref.watch(analysisProvider("runtime"));
    final genresData = ref.watch(genresProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Analysis of Shows/Movies on Netflix"),
      ),
      body: 
      ListView(
        children: [
          imdbScoreData.when(
            data: (imdbScoreData) {
              return Center(
                child: NumbersChart(
                  data: imdbScoreData,
                  title: "Average IMDB Score Across Years"
                ),
              );
            },
            error: (err, s) => Text(err.toString()),
            loading: () => const Center(child: Text("Loading Data..."))
          ),
          tmdbScoreData.when(
            data: (tmdbScoreData) {
              return Center(
                child: NumbersChart(
                  data: tmdbScoreData,
                  title: "Average TMDB Score Across Years"
                ),
              );
            },
            error: (err, s) => Text(err.toString()),
            loading: () => const Center(child: Text("Loading Data..."))
          ),
          runtimeData.when(
            data: (runtimeData) {
              return Center(
                child: NumbersChart(
                  data: runtimeData,
                  title: "Total Runtime of Shows Released Across Years",
                ),
              );
            },
            error: (err, s) => Text(err.toString()),
            loading: () => const Center(child: Text("Loading Data..."))
          ),
          genresData.when(
            data: (genresData) {
              return Center(
                child: TextNumbersChart(
                  data: genresData,
                  title: "Genres Runtime"
                ),
              );
            },
            error: (err, s) => Text(err.toString()),
            loading: () => const Center(child: Text("Loading Data..."))
          ),
        ],
      )
    );
  }
}