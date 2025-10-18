import 'package:flutter/material.dart';
import 'package:game_testing/data/game_list.dart';

class TempGameScreen extends StatefulWidget {
  const TempGameScreen({super.key});

  @override
  State<TempGameScreen> createState() => _TempGameScreenState();
}

class _TempGameScreenState extends State<TempGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back, color: Colors.white,)),
        title: Text('Select the game you wanna play', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.settings, color: Colors.white,))
        ],
      ),
      body: ListView.builder(
        itemCount: dummyGames.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: ListTile(
              title: Text(dummyGames[index].name, style: Theme.of(context).textTheme.labelMedium,),
              subtitle: Text(dummyGames[index].description, style: Theme.of(context).textTheme.labelSmall),
              leading: Icon(Icons.square_rounded, color: Colors.black,),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => dummyGames[index].destination),
                );
              },
              tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
            ),
          )
      ),
    );
  }
}
