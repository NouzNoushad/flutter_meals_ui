import 'package:flutter/material.dart';
import 'package:flutter_meals_ui/meals_checkout.dart';
import 'package:flutter_meals_ui/meals_details.dart';
import 'package:flutter_meals_ui/models/meals.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 4, vsync: this);

  List<Meals> mealsList = MealsList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 34, 39, 43),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Column(
              children: [
                mealsAppBar(),
                TabBar(
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Colors.red,
                  labelColor: Colors.red,
                  unselectedLabelColor: Colors.white,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  controller: _tabController,
                  tabs: const [
                    Text(
                      "Food",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Hot Drinks",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Desert",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Lunch",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      mealsMenu(),
                      const Center(
                        child: Text("Hot Drinks"),
                      ),
                      const Center(
                        child: Text("Desert"),
                      ),
                      const Center(
                        child: Text("Lunch"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(12),
                color: Colors.black.withOpacity(0.5),
                child: Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 21, 17),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.circular(20),
                        ),
                      ),
                    ),
                    child: const Text("Checkout order"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mealsMenu() => ListView.builder(
        itemCount: mealsList.length,
        itemBuilder: (context, index) {
          final mealsMenu = mealsList[index];
          return Container(
            height: 220,
            width: double.infinity,
            // color: Colors.red,
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.only(left: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mealsMenu.title,
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: mealsMenu.meals.length,
                    itemBuilder: (context, index) {
                      final meals = mealsMenu.meals[index];
                      return Container(
                        width: 130,
                        child: Card(
                          color: const Color.fromARGB(255, 46, 53, 58),
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: Stack(
                              children: [
                                Image.asset(
                                  "assets/${meals.image}",
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          meals.isFavorite = !meals.isFavorite!;
                                        });
                                      },
                                      child: meals.isFavorite!
                                          ? const Icon(Icons.favorite,
                                              size: 14, color: Colors.red)
                                          : const Icon(Icons.favorite_outline,
                                              size: 14),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MealsDetails(meals: meals)),
                                        );
                                      },
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              meals.name!,
                                              style: const TextStyle(
                                                fontSize: 11,
                                              ),
                                            ),
                                            Text(
                                              "\$ ${meals.price}",
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const Text(
                                              "Lorem Ipsum is simply a dummy text.",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white60,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );

  Widget mealsAppBar() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.arrow_back, size: 18),
            const Text(
              "Menu",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const MealsCheckout()),
                  );
                },
                child: const Icon(Icons.shopping_bag_outlined, size: 18)),
          ],
        ),
      );
}
