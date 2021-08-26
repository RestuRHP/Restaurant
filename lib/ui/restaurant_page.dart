import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:submission_fudamental_flutter/controller/home_controller.dart';
import 'package:submission_fudamental_flutter/data/model/restaurant_list_response.dart';
import 'package:submission_fudamental_flutter/res/res_color.dart';
import 'package:submission_fudamental_flutter/ui/detail_restaurant_page.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({Key key}) : super(key: key);

  @override
  _RestaurantPageState createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  final homeCtr = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ResColor.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ResColor.bgContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: homeCtr.search,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    hintText: 'Cari restaurant disini..',
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500),
                    contentPadding: EdgeInsets.all(15),
                    border: InputBorder.none,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        homeCtr.searchRestaurant(homeCtr.search.text);
                      },
                      child: Icon(
                        Icons.search,
                        color: ResColor.lowText,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Obx(() {
                  if (homeCtr.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (homeCtr.listRestaurant.value.restaurants==null) {
                    return Container(
                      height: 0,
                      width: 0,
                    );
                  }else if(homeCtr.isError.value){
                    Fluttertoast.showToast(
                      msg: "${homeCtr.errorMessage.value}",
                      toastLength: Toast.LENGTH_SHORT,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                    );
                    return Container(
                      height: 0,
                      width: 0,
                    );
                  } else {
                    return ListView.separated(
                      padding: EdgeInsets.only(bottom: 10.0),
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 16,
                        );
                      },
                      itemCount: homeCtr.listRestaurant.value.restaurants.length,
                      itemBuilder: (context, index) {
                        return _buildItemRestaurant(
                            homeCtr.listRestaurant.value.restaurants[index]);
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemRestaurant(Restaurant item) {
    return InkWell(
      onTap: (){
        Get.to(DetailRestaurantPage(idRestaurant: item.id, idPicture: item.pictureId));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Hero(
            tag: item.pictureId,
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://restaurant-api.dicoding.dev/images/large/${item.pictureId}"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            "${item.name}",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: ResColor.darkText,
                fontSize: 22,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_on_rounded,
                size: 12,
                color: ResColor.lowText,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "${item.city}",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: ResColor.lowText,
                    fontSize: 14,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, size: 12, color: ResColor.lowText),
              SizedBox(
                width: 5,
              ),
              Text(
                "${item.rating}",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: ResColor.lowText,
                    fontSize: 14,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
