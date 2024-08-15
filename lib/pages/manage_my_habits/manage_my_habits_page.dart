import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/pages/home/home_page_view_model.dart';
import 'package:goodplace_habbit_tracker/widgets/Drawer.dart';
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
    _homeModel = Provider.of<HomePageViewModel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _homeModel.getUserInformation(context);
      await _homeModel.fetchHabits(context);
    });
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
        child: _buildGridView(),
      ),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      itemCount: 10,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 15,
        childAspectRatio: 1 / 0.9,
      ),
      itemBuilder: (context, index) {
        return _buildGridItem(index);
      },
    );
  }

  Widget _buildGridItem(int index) {
    // İndexe göre farklı metinler ve değerler ayarlayabilirsiniz
    String habitTitle = 'Su İç'; // Şimdilik tüm kartlar için sabit değer
    String habitDescription = 'Günlük en az 3Lt su içmemiz gerekmektedir.';
    String habitStreak = '4';

    return Stack(
      children: [
       Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: Colors.white,
    image:  DecorationImage(
      image: const AssetImage('assets/images/asset_habit.jpeg'),
      fit: BoxFit.cover,
      colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.4), // Adjust opacity to make it more transparent
        BlendMode.darken,
      ),
    ),
  ),
  child: Padding(
    padding: const EdgeInsets.all(8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          habitTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          habitDescription,
          style: const TextStyle(
            color: Color.fromARGB(255, 101, 101, 101),
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  ),
),
        Positioned(
          top: 8,
          right: 8,
          child: Row(
            children: [
              const Text(
                '🔥',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(width: 4),
              Text(
                habitStreak,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
