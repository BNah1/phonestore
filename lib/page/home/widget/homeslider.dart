import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:onlineappstore/providers/slider_provider.dart';
import 'package:provider/provider.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({Key? key}) : super(key: key);

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  late Future sliderFuture;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    sliderFuture = Provider.of<SliderProvider>(context).getSlider();
    super.didChangeDependencies();
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   sliderFuture = Provider.of<SliderProvider>(context).getSlider();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: FutureBuilder(
          future: sliderFuture,
          initialData: const [],
          builder: (context, asyncData) {
            var sliderData = [];
            if (asyncData.hasData) {
              sliderData = asyncData.data! as List;
            } else {
              Container(child: const Text('nodata'));
            }
            return asyncData.hasData
                ? CarouselSlider(
                    options: CarouselOptions(autoPlay: true),
                    items: sliderData.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(i.image))),
                          );
                        },
                      );
                    }).toList(),
                  )
                : Container(
                    child: Text('no data'),
                  );
          }),
    );
  }
}
