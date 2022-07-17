import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:netflix_analysis/model/analysis_series.dart';
import 'package:netflix_analysis/model/genres_popularity.dart';
import 'package:tuple/tuple.dart';

class HttpService {
  static const String uri = "https://netflixanalysis.azurewebsites.net";

  Future<dynamic> getAllActorsData() async {
    Response res = await get(Uri.parse('$uri/actors_analysis'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body;
    } else {
      throw "Unable to retrieve actors' data.";
    }
  }

  Future<dynamic> getAllDirectorsData() async {
    Response res = await get(Uri.parse('$uri/directors_analysis'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body;
    } else {
      throw "Unable to retrieve directors' data.";
    }
  }

  Future<dynamic> getPersonData(type, id) async {
    Response res = await get(Uri.parse('$uri/person/$type/$id'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body;
    } else {
      throw "Unable to retrieve user information.";
    }
  }

  Future<List<AnalysisSeries>> getAnalysisData(metric) async {
    Response res = await get(Uri.parse('$uri/analysis/$metric'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<AnalysisSeries> result = [];
      for (var i = 0; i < body.length; i++) {
        AnalysisSeries toAdd = AnalysisSeries(year: int.parse(body[i]["year"]), metric: double.parse(body[i]["metric"]));
        result.add(toAdd);
      }
      return result;
    } else {
      throw "Unable to retrieve popularity analysis data.";
    }
  }

  Future<List<GenresPopularity>> getGenreData() async {
    var genres = ["crime", "documentation", "drama", "comedy", "fantasy", "horror", "european", "thriller",
      "action", "music", "romance", "family", "western", "war", "history", "scifi", "animation", "sport"];
    List<GenresPopularity> result = [];
    for (var genre in genres) {
      Response res = await get(Uri.parse('$uri/analysis/genres/$genre'));
      if (res.statusCode == 200) {
        List<dynamic> body = jsonDecode(res.body);
        for (var i = 0; i < body.length; i++) {
          GenresPopularity toAdd = GenresPopularity(genre: genre, runtime: double.parse(body[i]["total_runtime"]));
          result.add(toAdd);
        }
      } else {
        throw "Unable to retrieve popularity analysis data.";
      }
    }
    return result;
  }
}

final apiProvider = Provider<HttpService>((ref) => HttpService());

final actorsProvider = FutureProvider<dynamic>((ref) async {
  return ref.read(apiProvider).getAllActorsData();
});

final directorsProvider = FutureProvider<dynamic>((ref) async {
  return ref.read(apiProvider).getAllDirectorsData();
});

final personProvider = FutureProvider.family<dynamic, Tuple2<String, String>>((ref, tuple) async {
  return ref.read(apiProvider).getPersonData(tuple.item1, tuple.item2);
});

final analysisProvider = FutureProvider.family<List<AnalysisSeries>, String>((ref, metric) async {
  return ref.read(apiProvider).getAnalysisData(metric);
});

final genresProvider = FutureProvider<List<GenresPopularity>>((ref) async {
  return ref.read(apiProvider).getGenreData();
});