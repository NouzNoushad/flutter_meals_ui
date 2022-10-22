import 'package:flutter/material.dart';
import 'package:flutter_meals_ui/database/db.dart';
import 'package:flutter_meals_ui/meals_checkout.dart';
import 'package:flutter_meals_ui/models/meals.dart';
import 'package:flutter_meals_ui/models/meals_data.dart';

class MealsDetails extends StatefulWidget {
  final MealsData meals;
  const MealsDetails({super.key, required this.meals});

  @override
  State<MealsDetails> createState() => _MealsDetailsState();
}

class _MealsDetailsState extends State<MealsDetails> {
  List<Meals> mealsList = MealsList;
  Db database = Db();
  @override
  void initState() {
    database.open();
    super.initState();
  }

  @override
  void dispose() {
    database.db!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 34, 39, 43),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  mealsDetailsAppBar(),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.meals.isFavorite = !widget.meals.isFavorite!;
                      });
                    },
                    child: widget.meals.isFavorite!
                        ? const Icon(Icons.favorite, color: Colors.red)
                        : const Icon(Icons.favorite_outline),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.meals.name!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "\$ ${widget.meals.price!}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.schedule,
                            size: 18,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("10 min"),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.local_fire_department,
                            size: 18,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("80 kalories"),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.set_meal,
                            size: 18,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("400 gram"),
                        ],
                      ),
                    ],
                  ),
                  const Text(
                    "Lorem ipsum dolor sit amet, consectetur, adipisicing elit. Mangnam reprehenderit atque ab quisquam laudantium eligendi quos iure nobis laboriosam debitis? Suscipit laborum laboriosam ad nisi, soluta libero fugiat officiis. Impedit",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Related Orders",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 120,
                        width: double.infinity,
                        // color: Colors.red,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: mealsList.length,
                          itemBuilder: (context, index) {
                            // we need to filter meals
                            var meals;
                            var relatedList = mealsList
                                .where((meals) =>
                                    meals.title.toLowerCase() ==
                                    widget.meals.type!.toLowerCase())
                                .toList();
                            // loop through
                            for (var meal in relatedList) {
                              meals = meal.meals[index];
                            }
                            print(meals);
                            return Container(
                              width: 100,
                              // color: Colors.red,
                              margin: const EdgeInsets.only(right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Image.asset(
                                      "assets/${meals.image}",
                                      height: 70,
                                      width: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    "${meals.name}",
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                  Text(
                                    "\$ ${meals.price}",
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 100,
              right: 10,
              child: Image.asset(
                "assets/${widget.meals.image}",
                height: 220,
                width: 220,
                fit: BoxFit.cover,
              ),
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
                    onPressed: () async {
                      await database.db!.rawInsert(
                          'INSERT INTO meals (name, image, price) VALUES (?, ?, ?);',
                          [
                            widget.meals.name,
                            widget.meals.image,
                            widget.meals.price,
                          ]);
                      // pop up message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            backgroundColor: Color.fromARGB(255, 34, 39, 43),
                            content: Text(
                              "New meal added to Checkout Order",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )),
                      );
                      // navigate to checkout order page
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const MealsCheckout()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 21, 17),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.circular(20),
                        ),
                      ),
                    ),
                    child: const Text("Add to order"),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mealsDetailsAppBar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back, size: 18)),
          const Text(
            "Menu",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Icon(Icons.shopping_bag_outlined, size: 18),
        ],
      );
}
