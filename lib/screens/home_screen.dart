import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_ui/data/data.dart';
import 'package:flutter_food_delivery_ui/screens/cart_screen.dart';
import 'package:flutter_food_delivery_ui/screens/restaurant_screen.dart';
import 'package:flutter_food_delivery_ui/widgets/rating_stars.dart';
import 'package:flutter_food_delivery_ui/widgets/recent_order.dart';
import 'package:flutter_food_delivery_ui/models/restaurant.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> restaurantList = [];

  _buildRestaurants() {
    restaurants.forEach((Restaurant restaurant) {
      restaurantList.add(GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => RestaurantScreen(restaurant: restaurant)));
        },
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: Colors.grey[200], width: 1.0)),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Hero(
                    tag: restaurant.imageUrl,
                    child: Image(
                        image: AssetImage(restaurant.imageUrl),
                        height: 150.0,
                        width: 150,
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          restaurant.name,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        RatingStars(restaurant.rating),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          restaurant.address,
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          '0.2 miles away',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ))
              ],
            )),
      ));
    });
    return Column(children: restaurantList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.account_circle),
              iconSize: 30.0,
            ),
            title: Text('Food Delivery'),
            centerTitle: true,
            actions: [
              FlatButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CartScreen())),
                  child: Text(
                    'Cart(${currentUser.cart.length})',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ))
            ]),
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(width: 0.3)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                            width: 0.3, color: Theme.of(context).primaryColor)),
                    hintText: 'Search Food or Restaurants',
                    prefixIcon: Icon(
                      Icons.search,
                      size: 30,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.clear),
                    ))),
          ),
          RecentOrders(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Nearby Restaurants',
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.3),
                ),
              ),
              _buildRestaurants()
            ],
          ),
        ]));
  }
}
