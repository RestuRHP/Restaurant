import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:submission_fudamental_flutter/controller/detail_controller.dart';
import 'package:submission_fudamental_flutter/data/model/detail_restaurant_response.dart';
import 'package:submission_fudamental_flutter/res/res_color.dart';

class DetailRestaurantPage extends StatefulWidget {
  final String idRestaurant;
  final String idPicture;

  const DetailRestaurantPage({@required this.idRestaurant, @required this.idPicture});

  @override
  _DetailRestaurantPageState createState() => _DetailRestaurantPageState();
}

class _DetailRestaurantPageState extends State<DetailRestaurantPage> {
  final detailCtr = Get.put(DetailController());

  @override
  void initState() {
    super.initState();
    detailCtr.getDetailRestaurant(widget.idRestaurant);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                tag: widget.idPicture,
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://restaurant-api.dicoding.dev/images/large/${widget
                              .idPicture}"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                ),
              ),
              Obx((){
                if (detailCtr.isLoading.value) {
                  return Flexible(
                    // fit: FlexFit.loose,
                    child: Padding(
                      padding: const EdgeInsets.only(top:20.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                } else if (detailCtr.isError.value) {
                  Fluttertoast.showToast(
                    msg: "${detailCtr.errorMessage.value}",
                    toastLength: Toast.LENGTH_SHORT,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                  );
                  return Center(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              height:200,
                              child: Lottie.asset('assets/images/no_connection.json'),
                            ),
                          ),
                          Text(
                            "Tidak ada koneksi",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: ResColor.darkText,
                                fontSize: 22,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  );
                }else{
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${detailCtr.nameRestaurant.value}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: ResColor.darkText,
                              fontSize: 22,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              size: 15,
                              color: ResColor.lowText,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${detailCtr.addressRestaurant.value}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: ResColor.lowText,
                                  fontSize: 14,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${detailCtr.description.value}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: ResColor.lowText,
                              fontSize: 12,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          "Kategori",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: ResColor.darkText,
                              fontSize: 16,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700),
                        ),
                        Wrap(
                          spacing: 5,
                          children: List.generate(
                              detailCtr.category.length,
                                  (index) {
                                return _buildChipsCategory(
                                    detailCtr.category[index]);
                              }),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          "Makanan",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: ResColor.darkText,
                              fontSize: 16,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700),
                        ),
                        Wrap(
                          spacing: 1,
                          children: List.generate(
                              detailCtr.menu.value.foods==null?0:detailCtr.menu.value.foods.length,
                                  (index) {
                                return _buildChipsFood(detailCtr.menu.value,index);
                              }),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          "Minuman",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: ResColor.darkText,
                              fontSize: 16,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w700),
                        ),
                        Wrap(
                          spacing: 1,
                          children: List.generate(
                              detailCtr.menu.value.drinks==null?0:detailCtr.menu.value.drinks.length,
                                  (index) {
                                return _buildChipsDrinks(detailCtr.menu.value,index);
                              }),
                        ),
                      ],
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChipsCategory(Category item) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Chip(
        labelPadding: EdgeInsets.all(2.0),
        label: Text(
          item.name,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: ResColor.secondary,
        padding: EdgeInsets.all(8.0),
      ),
    );
  }

  Widget _buildChipsDrinks(Menus item,int index) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Chip(
        labelPadding: EdgeInsets.all(2.0),
        label: Text(
          item.drinks[index].name,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: ResColor.ternary,
        padding: EdgeInsets.all(8.0),
      ),
    );
  }

  Widget _buildChipsFood(Menus item,int index) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Chip(
        labelPadding: EdgeInsets.all(2.0),
        label: Text(
          item.foods[index].name,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: ResColor.primary,
        padding: EdgeInsets.all(8.0),
      ),
    );
  }
}
