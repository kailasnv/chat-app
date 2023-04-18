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
          // calling search event
          onChanged: (value) {
            print(value);

            BlocProvider.of<SearchBloc>(context).add(
              SearchOtherUsersEvent(searchQuery: value),
            );
          },
        ),
        // cancel button
        actions: [
          IconButton(
              onPressed: () {
                searchController.text = "";
              },
              icon: const Icon(Icons.cancel_outlined, color: Colors.teal)),
        ],
      ),

      /*
        search result will br shown below here
       */
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.usersList != null) {
            return ListView.separated(
              separatorBuilder: (context, index) =>
                  Divider(color: Colors.grey.shade700),
              itemCount: state.usersList!.length,
              itemBuilder: (context, index) => UserTile(
                userName: state.usersList![index]['name'] ?? "NO NAME",
                userImage: state.usersList![index]['image'],
              ),
            );
          } else {
            return const Center(child: Text("NO USERS !"));
          }
        },
      ),
    );
  }
}
