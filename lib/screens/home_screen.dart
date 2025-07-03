import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:to_do/cubits/task_cubit/task_cubit.dart';
import 'package:to_do/screens/history_screen.dart';
import 'package:to_do/screens/tasks_screen.dart';
import 'package:to_do/utils/constants/app_icons.dart';
import 'package:to_do/utils/enums/enums.dart';
import 'package:to_do/widgets/create_task_bottomsheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () async {
          final result = await showCreateTaskBottomSheet(context);
          if (result == StateStatus.success) {
            context.read<TaskCubit>().getTask();
          }
        },
        child: SvgPicture.asset(AppIcons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 150),
              curve: Curves.ease,
            );
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 0 ? AppIcons.toDoActive : AppIcons.toDo,
            ),
            label: "To do",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _currentIndex == 1 ? AppIcons.historyActive : AppIcons.history,
            ),
            label: "Hisotry",
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: [TaskScreen(), HistoryScreen()],
      ),
    );
  }
}
