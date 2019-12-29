import 'package:flutter/material.dart';

class Search extends SearchDelegate<String>{

  List<String> recentSearch = ['sfdsfsd','zaeazeaze','lplplplp'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          close(context, null);
        },
        )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){},
      
      );
    
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    print(query);
    return Center(
        child:Text(query)
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final recent = query.isEmpty ? recentSearch : recentSearch.where((p) => p.startsWith(query)).toList();
    return ListView.builder(
      itemCount: recent.length,
      itemBuilder: (context,i){
        return ListTile(
          onTap: (){
            query = recent[i];
            showResults(context);
          },
          leading: Icon(Icons.refresh),
          title: Text(recent[i]),
        );
      },
    );
  }
  
}