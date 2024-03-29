import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix_analysis/screens/individual_page.dart';
import 'package:netflix_analysis/services/service.dart';

class ActorsTablePage extends ConsumerWidget {
  const ActorsTablePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final data = ref.watch(actorsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const ListTile(
          title:
            Text("Top 10 Actors", style: TextStyle(color:Colors.white)),
          subtitle:
            Text("Ordered by Average TMDB Popularity", style: TextStyle(color:Colors.white)),
        )
      ),
      body: data.when(
        data: (data) {
          return Column(
            children: [
              const SizedBox(height: 10),
              const Text('Click on any actor name to view more details.', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
                  4: FlexColumnWidth(1),
                  5: FlexColumnWidth(1),
                  6: FlexColumnWidth(1),
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
                  ...(data as List).map((item) => 
                    TableRow(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: ((context) {
                                return IndividualPage(personId: item["person_id"], name: item['name'], type: "ACTOR",);
                              }))
                            );
                          },
                          child: Text(item["name"] == null ? '-' : item["name"].toString(), textAlign: TextAlign.center),
                        ),
                        Text(item["count"] == null ? '-' : item["count"].toString(), textAlign: TextAlign.center),
                        Text('${item["min"]} - ${item["max"]}', textAlign: TextAlign.center),
                        Text(item["avg_imdb_score"] == null ? '-' : (double.parse(item["avg_imdb_score"])).toStringAsFixed(3), textAlign: TextAlign.center),
                        Text(item["total_imdb_votes"] == null ? '-' : item["total_imdb_votes"].toString(), textAlign: TextAlign.center),
                        Text(item["avg_tmdb_popularity"] == null ? '-' : (double.parse(item["avg_tmdb_popularity"])).toStringAsFixed(3), textAlign: TextAlign.center),
                        Text(item["avg_tmdb_score"] == null ? '-' : (double.parse(item["avg_tmdb_score"])).toStringAsFixed(3), textAlign: TextAlign.center),
                      ],
                    )
                  )
                ],
              )
            ]
          );
        },
        error: (err, s) => Text(err.toString()),
        loading: () => const Center(child: Text("Loading Data..."))
      )
    );
  }
}