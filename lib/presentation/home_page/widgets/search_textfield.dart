import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/bloc/users_bloc.dart';

// ignore: must_be_immutable
class HomeSearchField extends StatelessWidget {
  final TextEditingController controller;
  const HomeSearchField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 30,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "search users",
              hintStyle: TextStyle(color: Colors.purple.shade100),
              contentPadding: const EdgeInsets.only(bottom: 13),
              prefixIcon: Icon(Icons.search, color: Colors.purple.shade100),
              // cancel
              suffixIcon: IconButton(
                onPressed: () {
                  controller.clear();
                  // calling search event
                  BlocProvider.of<UsersBloc>(context)
                      .add(LoadOtherUsers(searchQuery: controller.text.trim()));
                },
                icon:
                    Icon(Icons.cancel_outlined, color: Colors.purple.shade100),
                padding: const EdgeInsets.only(bottom: 0.7),
              ),
            ),
            // logics section
            onChanged: (typing) {
              // calling search event
              BlocProvider.of<UsersBloc>(context)
                  .add(LoadOtherUsers(searchQuery: controller.text));
            },
          ),
        ),
      ),
    );
  }
}
