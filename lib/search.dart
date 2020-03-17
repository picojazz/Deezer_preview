import 'package:flutter/material.dart';
import 'package:picojazz_deezer_preview/Database.dart';
import 'package:picojazz_deezer_preview/searchView.dart';

class Search extends SearchDelegate<String> {
  List<String> recentSearch = [];
  MyDatabase db = MyDatabase();
  List<MySearch> listSearch;

  getAllSearch() async {
    //recentSearch.clear();
    listSearch = await db.getAllSearch();
    
    for (var item in listSearch) {
      recentSearch.add(item.search);
    }
  }

  insert(search) async {
    await db.insert(search);
  }

  Search(){
    getAllSearch();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions

    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          recentSearch.clear();
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
      onPressed: () {
          close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    if (!recentSearch.contains(query)) {
      MySearch search = MySearch(query);
      insert(search);
    }
    return SearchView(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    
    //getAllSearch();

    final recent = query.isEmpty
        ? recentSearch
        : recentSearch.where((p) => p.startsWith(query)).toList();
      //final recent = recentSearch;   

    return ListView.builder(
      itemCount: recent.length,
      itemBuilder: (context, i) {
        return ListTile(
          onTap: () {
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
