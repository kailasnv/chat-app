import 'package:chat_app/presentation/widgets_common/users_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/bloc_search/search_bloc.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* textfield  for search  */
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // when pops from this screen ,
            // same time i clears the controller and  call the event once more to clear the ,
            // already searched results .
            searchController.text = "";
            BlocProvider.of<SearchBloc>(context).add(
              SearchOtherUsersEvent(searchController: searchController),
            );
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        // search feild
        title: TextField(
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          controller: searchController,
          autofocus: true,

          decoration: const InputDecoration(
            hintText: "Search users..",
            hintStyle: TextStyle(color: Colors.teal),
            border: InputBorder.none,
          ),
          // calling search event - and passing the text same time
          onChanged: (value) {
            BlocProvider.of<SearchBloc>(context).add(
              SearchOtherUsersEvent(searchController: searchController),
            );
          },
        ),
        // cancel button - clears the controller & results
        actions: [
          IconButton(
              onPressed: () {
                searchController.text = "";
                BlocProvider.of<SearchBloc>(context).add(
                    SearchOtherUsersEvent(searchController: searchController));
              },
              icon: const Icon(Icons.cancel_outlined, color: Colors.teal)),
        ],
      ),

      /*
        search result will br shown below here
       */
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          // loading indicator
          if (state.isLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ));
          }
          // show list of results
          if (state.otherUsersList != null) {
            // print(state.otherUsersList.toString());
            return ListView.separated(
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.grey.shade700),
              itemCount: state.otherUsersList!.length,
              itemBuilder: (context, index) => UserTile(
                friendName: state.otherUsersList![index]['name'] ?? "NO NAME",
                friendImage: state.otherUsersList![index]['image'],
                friendID: state.otherUsersList![index]['uid'],
              ),
            );
          } else {
            return const Center(
                child: Text("Search with username",
                    style: TextStyle(color: Colors.grey)));
          }
        },
      ),
    );
  }
}
