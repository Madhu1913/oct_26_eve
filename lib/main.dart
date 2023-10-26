

import 'package:flutter/material.dart';
import 'package:oct_26_eve/MovieProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => MoviesProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  Widget build(BuildContext context) {
    var num = context.watch<MoviesProvider>().data;
    var fav = context.watch<MoviesProvider>().myFav;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>MyFavList()));
          }, child: Text('Favourites')),
          Expanded(
            child: ListView.builder(
                itemCount: num.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text('${num[i]}',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    leading: IconButton(
                      onPressed: () {
                        if (!fav.contains(num[i])) {
                          context.read<MoviesProvider>().addNum(num[i]);
                        } else {
                          context.read<MoviesProvider>().removeNum(num[i]);
                        }
                      },
                      icon: Icon(Icons.favorite,color: fav.contains(num[i])
                          ? Colors.red
                          : Colors.grey,
                      size: 30,),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class MyFavList extends StatefulWidget {
  const MyFavList({super.key});

  @override
  State<MyFavList> createState() => _MyFavListState();
}

class _MyFavListState extends State<MyFavList> {
  @override
  Widget build(BuildContext context) {
    final myFav = context.watch<MoviesProvider>().myFav;
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: myFav.length,
          itemBuilder: (context, i) {
            return ListTile(
              title: Text('${myFav[i]}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              trailing: ElevatedButton(
                onPressed: () {
                  context.read<MoviesProvider>().removeNum(myFav[i]);
                },
                child: Text('Remove'),
              ),
            );
          }),
    );
  }
}
