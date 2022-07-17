import 'package:flutter/material.dart';
import 'package:netflix_analysis/charts/numbers_chart.dart';
import 'package:netflix_analysis/charts/text_numbers_chart.dart';
import 'package:netflix_analysis/model/analysis_series.dart';
import 'package:netflix_analysis/model/genres_popularity.dart';
import 'package:netflix_analysis/services/service.dart';

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Analysis of Shows/Movies on Netflix"),
      ),
      body: 
      ListView(
        children: [
          FutureBuilder(
            future: HttpService.getAnalysisData("imdb_score"),
            builder:(context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text("Loading Data..."),);
              }
              if (snapshot.hasData) {
                return Center(
                  child: NumbersChart(
                    data: snapshot.data as List<AnalysisSeries>,
                    title: "Average IMDB Score Across Years"
                  ),
                );
              }
              return const Scaffold();
            }
          ),
          FutureBuilder(
            future: HttpService.getAnalysisData("tmdb_score"),
            builder:(context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text("Loading Data..."),);
              }
              if (snapshot.hasData) {
                return Center(
                  child: NumbersChart(
                    data: snapshot.data as List<AnalysisSeries>,
                    title: "Average TMDB Score Across Years"
                  ),
                );
              }
              return const Scaffold();
            }
          ),
          FutureBuilder(
            future: HttpService.getAnalysisData("runtime"),
            builder:(context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text("Loading Data..."),);
              }
              if (snapshot.hasData) {
                return Center(
                  child: NumbersChart(
                    data: snapshot.data as List<AnalysisSeries>,
                    title: "Total Runtime of Shows Released Across Years",
                  ),
                );
              }
              return const Scaffold();
            }
          ),
          FutureBuilder(
            future: HttpService.getGenreData(),
            builder:(context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text("Loading Data..."),);
              }
              if (snapshot.hasData) {
                return Center(
                  child: TextNumbersChart(
                    data: snapshot.data as List<GenresPopularity>,
                    title: "Genres Runtime"
                  ),
                );
              }
              return const Scaffold();
            }
          )
        ],
      )
    );
  }
}