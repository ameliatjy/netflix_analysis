import 'package:flutter/material.dart';
import 'package:netflix_analysis/individual_page.dart';
import 'package:netflix_analysis/services/service.dart';

class DirectorsTablePage extends StatelessWidget {
  const DirectorsTablePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ListTile(
          title:
            Text("Top 10 Directors", style: TextStyle(color:Colors.white)),
          subtitle:
            Text("Ordered by Average TMDB Popularity", style: TextStyle(color:Colors.white)),
        )
      ),
      body: 
      FutureBuilder(
        future: HttpService.getAllDirectorsData(),
        builder:(context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text("Loading Data..."),);
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
                5: FlexColumnWidth(1),
                6: FlexColumnWidth(1),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: 
              <TableRow>[
                const TableRow(
                  children: [
                    Text('Director Name', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
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
                              return IndividualPage(personId: item["person_id"], name: item['name'], type: "DIRECTOR",);
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
            );
          }
          return const Scaffold();
        },
      )    );
  }
}