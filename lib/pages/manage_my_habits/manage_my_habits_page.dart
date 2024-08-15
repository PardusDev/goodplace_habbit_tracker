import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/pages/home/home_page_view_model.dart';
import 'package:goodplace_habbit_tracker/pages/manage_my_habits/manage_my_habits_view_model.dart';
import 'package:goodplace_habbit_tracker/widgets/Drawer.dart';
import 'package:goodplace_habbit_tracker/widgets/HabitCardWithImageBackground.dart';
import 'package:provider/provider.dart';


class ManageMyHabitsPage extends StatefulWidget {
  const ManageMyHabitsPage({super.key});

  @override
  State<ManageMyHabitsPage> createState() => _ManageMyHabitsPageState();
}

class _ManageMyHabitsPageState extends State<ManageMyHabitsPage> {
  late HomePageViewModel _homeModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _homeModel = Provider.of<HomePageViewModel>(context, listen: true);
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 77, 87, 200),
      appBar: AppBar(
        title: const Text(
          'Manage My Habits',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarHeight: 100,
      ),
      drawer: MyDrawer(mainModel: _homeModel, currentPage: "Manage My Habits",),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: 20),
        child: Consumer<ManageMyHabitsViewModel>(
          builder: (context, viewModel, child) {
            return GridView.builder(
              itemCount: viewModel.habits.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 15,
                childAspectRatio: 1 / 0.9,
              ),
              itemBuilder: (context, index) {
                return HabitCardWithImageBackground(
                    onTap: () {
                      viewModel.navigateToManageMyHabits(viewModel.habits[index]);
                    },
                    imageUrl: viewModel.habits[index].imagePath,
                    userHabit: viewModel.habits[index]
                );
              },
            );
          }
        ),
      ),
    );
  }
}
