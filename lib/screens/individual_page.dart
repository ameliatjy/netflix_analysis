import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix_analysis/services/service.dart';
import 'package:tuple/tuple.dart';

class IndividualPage extends ConsumerWidget {
  final String personId;
  final String name;
  final String type;
  const IndividualPage({
    Key? key,
    required this.personId,
    required this.name,
    required this.type
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    Tuple2<String, String> person = Tuple2(type, personId);
    final data = ref.watch(personProvider(person));
    return Scaffold(
      appBar: AppBar(
        title: Text("$name's Statistics"),
      ),
      body: data.when(
        data: (data) {
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
              7: FlexColumnWidth(1),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: 
            <TableRow>[
              const TableRow(
                children: [
                  Text('Title', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Release Year', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Type', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Description', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('IMDB Score', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('IMDB Votes', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('TMDB Popularity', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('TMDB Score', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              ...(data as List).map((item) => 
                TableRow(
                  children: [
                    Text(item["title"] == null ? '-' : item["title"].toString(), textAlign: TextAlign.center),
                    Text(item["release_year"] == null ? '-' : item["release_year"].toString(), textAlign: TextAlign.center),
                    Text(item["type"] == null ? '-' : item["type"].toString(), textAlign: TextAlign.center),
                    Text(item["description"] == null ? '-' : item["description"].toString(), textAlign: TextAlign.center),
                    Text(item["imdb_score"] == null ? '-' : item["imdb_score"].toString(), textAlign: TextAlign.center),
                    Text(item["imdb_votes"] == null ? '-' : item["imdb_votes"].toString(), textAlign: TextAlign.center),
                    Text(item["tmdb_popularity"] == null ? '-' : item["tmdb_popularity"].toString(), textAlign: TextAlign.center),
                    Text(item["tmdb_score"] == null ? '-' : item["tmdb_score"].toString(), textAlign: TextAlign.center),
                  ],
                )
              )
            ],
          );
        },
        error: (err, s) => Text(err.toString()),
        loading: () => const Center(child: Text("Loading Data..."))
      )
    );
  }
}