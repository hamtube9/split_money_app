import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:split_money/blocs/home_bloc/home_bloc.dart';
import 'package:split_money/commons/build_list_item.dart';
import 'package:split_money/commons/circle_avatar.dart';
import 'package:split_money/commons/home/home_stats_card.dart';
import 'package:split_money/cores/dependency_injection.dart';
import 'package:split_money/models/user/user.dart';
import 'package:split_money/models/user/user_stat.dart';
import 'package:split_money/utils/shared_preference.dart';

class HomeScreen extends StatefulWidget {
  final bool refreshToken;

  const HomeScreen({super.key, required this.refreshToken});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferencesService sP = getIt.get<SharedPreferencesService>();
  late User user;
  late HomeBloc bloc;
  UserStat? stat;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = BlocProvider.of(context);
    bloc.add(GetUserStatEvent());
    _initUser();
  }

  void _initUser() async {
    var user = await sP.user;
    if (user != null) {
      setState(() {
        this.user = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (BuildContext context, HomeState state) {
        if (state is GetUserStatSuccessState) {
          setState(() {
            stat = state.stat;
          });
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.transparent,
              pinned: true,
              // or false for a disappearing app bar
              floating: true,
              // or false for reappearing only at the top
              snap: true,
              // works with floating: true for snapping animation
              expandedHeight: 80.0,
              // height when expanded
              flexibleSpace: FlexibleSpaceBar(),
              actions: [CircleAvatarCommon(), const SizedBox(width: 16)],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Example of the "You Owe" card
                    Expanded(
                      child: HomeStatsCard(
                        title: "You Owe",
                        value: stat != null ? stat!.userOwe!.userOwe! : 0.0,
                        isOwe: true,
                      ),
                    ),
                    SizedBox(width: 20),
                    // Example of the "Owes you" card
                    Expanded(
                      child: HomeStatsCard(
                        title: "Owes you",
                        value: stat != null ? stat!.userOwe!.own! : 0.0,
                        isOwe: false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (stat == null) {
                    return Center(child: CircularProgressIndicator());
                  }else{
                    final bills = [
                      {
                        'title': 'Birthday House',
                        'date': 'Mar 24, 2023',
                        'amount': '\$4508.32',
                        'color': Colors.green,
                      },
                      {
                        'title': 'Shopping',
                        'date': 'Mar 24, 2023',
                        'amount': '\$505.00',
                        'color': Colors.red,
                      },
                      {
                        'title': 'Shopping',
                        'date': 'Mar 24, 2023',
                        'amount': '\$505.00',
                        'color': Colors.red,
                      },
                      {
                        'title': 'Shopping',
                        'date': 'Mar 24, 2023',
                        'amount': '\$505.00',
                        'color': Colors.red,
                      },
                    ];
                    final bill = bills[index];

                    return BillListItem(
                      title: bill['title'] as String,
                      date: bill['date'] as String,
                      amount: bill['amount'] as String,
                      color: bill['color'] as Color,
                    );
                  }


                },
                childCount: stat != null ? stat!.orders!.length : 1, // Number of items in the list
              ),
            ),
          ],
        ),
      ),
    );
  }
}
