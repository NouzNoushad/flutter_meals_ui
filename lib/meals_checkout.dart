import 'package:flutter/material.dart';
import 'package:flutter_meals_ui/database/db.dart';
import 'package:flutter_meals_ui/home_page.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MealsCheckout extends StatefulWidget {
  const MealsCheckout({super.key});

  @override
  State<MealsCheckout> createState() => _MealsCheckoutState();
}

class _MealsCheckoutState extends State<MealsCheckout> {
  Db database = Db();
  List<Map> mealsDataList = [];
  @override
  void initState() {
    database.open();
    getMealsData();
    super.initState();
  }

  void getMealsData() {
    Future.delayed(const Duration(seconds: 2), () async {
      mealsDataList = await database.db!.rawQuery('SELECT * FROM meals');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    num total = mealsDataList.fold(0, (prev, value) => prev + value["price"]);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 34, 39, 43),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Column(
              children: [
                mealsCheckoutAppBar(),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView(
                    children: mealsDataList.map((meal) {
                      return Slidable(
                        endActionPane: ActionPane(
                          motion: const StretchMotion(),
                          extentRatio: 0.2,
                          children: [
                            SlidableAction(
                              onPressed: (context) async {
                                // delete from checkout order
                                await database.db!.rawDelete(
                                    "DELETE FROM meals WHERE id = ?",
                                    [meal["id"]]);
                                // pop up message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor:
                                          Color.fromARGB(255, 34, 39, 43),
                                      content: Text(
                                        "meal deleted from the Checkout Order",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      )),
                                );
                                getMealsData();
                              },
                              icon: Icons.delete,
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ],
                        ),
                        child: Container(
                          height: 85,
                          width: double.infinity,
                          // color: Colors.red,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Stack(
                            children: [
                              Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(70, 10, 12, 10),
                                  child: Card(
                                    elevation: 10,
                                    color: Color.fromARGB(255, 46, 53, 58),
                                    child: Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            child: Text(
                                              meal["name"],
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "\$ ${meal["price"]}",
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 12,
                                child: Image.asset(
                                  "assets/${meal["image"]}",
                                  height: 85,
                                  width: 85,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(12),
                color: Colors.black.withOpacity(0.5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Amount",
                        ),
                        Text(
                          "\$ $total",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 255, 21, 17),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 21, 17),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(20),
                                right: Radius.circular(20),
                              ),
                            ),
                          ),
                          child: const Text("Checkout"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mealsCheckoutAppBar() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: const Icon(Icons.arrow_back, size: 18)),
            const Text(
              "Checkout Order",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              width: 18,
            ),
          ],
        ),
      );
}
