import 'package:flutter/material.dart';
import 'package:netflix_analysis/actors_individual_page.dart';
import 'package:netflix_analysis/services/service.dart';

class ActorsTablePage extends StatelessWidget {
  const ActorsTablePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actors Analysis')
      ),
      body: 
      FutureBuilder(
        future: HttpService.getAllActorsData(),
        builder:(context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold();
          }

          if (snapshot.hasData) {
            return Table(
              border: TableBorder.all(),
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
                4: FlexColumnWidth(1),
                6: FlexColumnWidth(1),
                7: FlexColumnWidth(1),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: 
              <TableRow>[
                const TableRow(
                  children: [
                    Text('Actor Name', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Number of Shows/Movies', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Years Active', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Average IMDB Score', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Total IMDB Votes', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Average TMDB Popularity', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Average TMDB Score', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                ...(snapshot.data as List).map((item) => 
                  TableRow(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: ((context) {
                              return const ActorsIndividualPage();
                            }))
                          );
                        },
                        child: Text(item["name"] == null ? '-' : item["name"].toString()),
                      ),
                      Text(item["count"] == null ? '-' : item["count"].toString()),
                      Text('${item["min"]} - ${item["max"]}'),
                      Text(item["avg_imdb_score"] == null ? '-' : item["avg_imdb_score"].toString()),
                      Text(item["total_imdb_votes"] == null ? '-' : item["total_imdb_votes"].toString()),
                      Text(item["avg_tmdb_popularity"] == null ? '-' : item["avg_tmdb_popularity"].toString()),
                      Text(item["avg_tmdb_score"] == null ? '-' : item["avg_tmdb_score"].toString()),
                    ],
                  )
                )
              ],
            );
          }
          return const Scaffold();
        },
      )
    );
  }
}