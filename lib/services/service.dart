import 'dart:convert';
import 'package:http/http.dart';
import 'package:netflix_analysis/model/analysis_series.dart';
import 'package:netflix_analysis/model/genres_popularity.dart';

class HttpService {
  static const String uri = "http://localhost:8000";

  static Future<dynamic> getAllActorsData() async {
    Response res = await get(Uri.parse('$uri/actors_analysis'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body;
    } else {
      throw "Unable to retrieve actors' data.";
    }
  }

  static Future<dynamic> getAllDirectorsData() async {
    Response res = await get(Uri.parse('$uri/directors_analysis'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body;
    } else {
      throw "Unable to retrieve directors' data.";
    }
  }

  static Future<dynamic> getPersonData(type, id) async {
    Response res = await get(Uri.parse('$uri/person/$type/$id'));
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      return body;
    } else {
      throw "Unable to retrieve user information.";
    }
  }

  static Future<List<AnalysisSeries>> getAnalysisData(metric) async {
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

  static Future<List<GenresPopularity>> getGenreData() async {
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