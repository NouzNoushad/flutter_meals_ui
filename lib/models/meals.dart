import 'package:flutter_meals_ui/models/meals_data.dart';

class Meals {
  final String title;
  List<MealsData> meals;

  Meals({
    required this.title,
    required this.meals,
  });
}

final MealsList = [
  Meals(
    title: "First Meal",
    meals: [
      MealsData(
        image: "meal_one.png",
        name: "Tasty Meal",
        type: "first meal",
        price: 20,
        isFavorite: false,
      ),
      MealsData(
        image: "meal_two.png",
        name: "Premium Meal",
        type: "first meal",
        price: 40,
        isFavorite: false,
      ),
      MealsData(
        image: "meal_three.png",
        name: "Vegetable Recipe",
        type: "first meal",
        price: 15,
        isFavorite: false,
      ),
    ],
  ),
  Meals(
    title: "Hot Meal",
    meals: [
      MealsData(
        image: "meal_four.png",
        name: "Tasty Meal",
        type: "hot meal",
        price: 25,
        isFavorite: false,
      ),
      MealsData(
        image: "meal_five.png",
        name: "Premium Meal",
        type: "hot meal",
        price: 42,
        isFavorite: false,
      ),
      MealsData(
        image: "meal_six.png",
        name: "Vegetable Recipe",
        type: "hot meal",
        price: 18,
        isFavorite: false,
      ),
    ],
  ),
  Meals(
    title: "Lunch Meal",
    meals: [
      MealsData(
        image: "meal_seven.png",
        name: "Tasty Meal",
        type: "lunch meal",
        price: 30,
        isFavorite: false,
      ),
      MealsData(
        image: "meal_eight.png",
        name: "Premium Meal",
        type: "lunch meal",
        price: 45,
        isFavorite: false,
      ),
      MealsData(
        image: "meal_nine.png",
        name: "Vegetable Recipe",
        type: "lunch meal",
        price: 16,
        isFavorite: false,
      ),
    ],
  ),
];
