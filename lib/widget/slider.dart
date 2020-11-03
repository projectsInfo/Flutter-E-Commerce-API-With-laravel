import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';


class SliderWidget extends StatefulWidget {
  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {

  // Slider Code
  int _current = 0;
  List imgList = [
//    'http://flutterapisup.achilles-store.com/uploads/698627-icon-111-search-512_1596374798.png',
//    'http://flutterapisup.achilles-store.com/uploads/find-vector-icon-png_260845_1596374790.jpg',
//    'http://flutterapisup.achilles-store.com/uploads/image_picker-1909854966.jpg',
//    'http://flutterapisup.achilles-store.com/uploads/image_picker-2023676167.jpg',
    'http://flutterapisup.achilles-store.com/uploads/image_picker-2132300484.jpg',
    'http://flutterapisup.achilles-store.com/uploads/image_picker-2132300484.jpg',
    'http://flutterapisup.achilles-store.com/uploads/image_picker-2132300484.jpg',
    'http://flutterapisup.achilles-store.com/uploads/image_picker-2132300484.jpg',
    'http://flutterapisup.achilles-store.com/uploads/image_picker-2132300484.jpg',
  ];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }


  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Column(
        children: <Widget>[
          CarouselSlider(
            options: CarouselOptions(
                height: 150.0,
                autoPlay: true,
                initialPage: 0,
                autoPlayInterval: Duration(seconds: 3),
                pauseAutoPlayOnTouch: true,
//                          scrollDirection: Axis.vertical
//                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
            items: imgList.map((imgUrl) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(color: Colors.blue),
                    child: Image.network(imgUrl, fit: BoxFit.fill),
                  );
                },
              );
            }).toList(),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: map<Widget>(imgList, (index, url) {
              return Container(
                width: 10.0,
                height: 10.0,
                margin: EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                  _current == index ? Colors.grey : Colors.blue,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
