import 'package:flutter/material.dart';

class Pr extends StatefulWidget {
  const Pr({Key? key}) : super(key: key);

  @override
  State<Pr> createState() => _PrState();
}

class _PrState extends State<Pr> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          //2
          SliverAppBar(
            expandedHeight: 150.0,
            leading: Icon(Icons.arrow_left),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Goa', textScaleFactor: 1),
              background: Image.asset(
                'assets/image/03.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          //3
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) {
                return ListTile(
                  leading: Container(
                      padding: EdgeInsets.all(8),
                      width: 100,
                      child: Placeholder()),
                  title: Text('Place ${index + 1}', textScaleFactor: 2),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
