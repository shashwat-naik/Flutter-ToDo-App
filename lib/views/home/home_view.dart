import 'package:todo_app/utils/constants.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter/material.dart';
import 'package:todo_app/extensions/space_exs.dart';
import 'package:todo_app/utils/app_colors.dart';
import 'package:todo_app/utils/app_str.dart';
import 'package:todo_app/views/home/components/fab.dart';
import 'package:todo_app/views/home/widget/task_widget.dart';
import 'package:animate_do/animate_do.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<int> testing = [];
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,

      // FAB
      floatingActionButton: const Fab(),

      // Body
      body: _buildHomeBody(textTheme),
    );
  }

// Home Body
  Widget _buildHomeBody(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          // App Bar
          Container(
            margin: const EdgeInsets.only(top: 60),
            width: double.infinity,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Progress Circle
                const SizedBox(
                  width: 30,
                  height: 30,
                  child: const CircularProgressIndicator(
                    value: 1 / 3,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation(
                      AppColors.primaryColor,
                    ),
                  ),
                ),

                // Space
                25.w,

                // Top level task info
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStr.mainTitle,
                      style: textTheme.displayLarge,
                    ),
                    3.h,
                    Text(
                      "1 of 3 task",
                      style: textTheme.titleMedium,
                    )
                  ],
                )
              ],
            ),
          ),

          // Divider
          const Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Divider(
              thickness: 2,
              indent: 100,
            ),
          ),

          // Tasks
          SizedBox(
            width: double.infinity,
            height: 700,
            // height: 745,
            child: testing.isNotEmpty
              // Task not complete
                ? ListView.builder(
                    itemCount: testing.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          direction: DismissDirection.horizontal,
                          onDismissed: (_) {
                            // remove item from list
                          },
                          background: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                              8.w,
                              const Text(AppStr.deleteTask,
                                  style: TextStyle(color: Colors.red))
                            ],
                          ),
                          key: Key(index.toString()),
                          child: const TaskWidget());
                    })
                    // Task completed
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Lottie Animation
                      FadeIn(
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Lottie.asset(
                            lottieURL,
                            animate: testing.isNotEmpty ? false : true,
                          ),
                        ),
                      ),
                      // SubText
                      FadeInUp(
                        from: 30,
                        child: const Text(
                          AppStr.doneAllTask,
                        ),
                      )
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
