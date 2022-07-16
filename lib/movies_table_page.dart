import 'package:flutter/material.dart';

class MoviesTablePage extends StatelessWidget {
  const MoviesTablePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies Analysis')
      ),
      body: Table(
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
        children: <TableRow>[
          TableRow(
            children: [
              GestureDetector(
                onTap: () {
                  print("tap!");
                },
                child: const Text('Director Name', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              // Text('Director Name', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('Number of Shows/Movies', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('Years Active', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('Average IMDB Score', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('Total IMDB Votes', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('Average TMDB Popularity', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              const Text('Average TMDB Score', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const TableRow(
            children: [
              Text('Leonard Harris', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              Text('50', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              Text('2007 - 2022', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              Text('7', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              Text('1972634342', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              Text('4', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
              Text('4', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      )
    );
  }
}