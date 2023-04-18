import 'package:chat_app/presentation/home_page/widgets/custom_appbar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/bloc_current_user/current_user_bloc.dart';
import '../widgets_common/users_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    /*  calling events */
    BlocProvider.of<CurrentUserBloc>(context).add(GetCurrentUserDataEvent());

    return Scaffold(
      /* appbar section */
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 55),
        child: CustomAppbar(),
      ),
      /* List of messaged  users */
      body: SafeArea(
        child: ListView.separated(
          separatorBuilder: (context, index) =>
              Divider(color: Colors.grey.shade700),
          itemCount: 6,
          itemBuilder: (context, index) {
            return const UserTile(userName: "Kailas");
          },
        ),
      ),
    );
  }
}
