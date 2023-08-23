
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../class/function.dart';
import '../json/article.dart';

class UploadFile extends StatefulWidget{
  const UploadFile({super.key});


  @override
  State<UploadFile> createState()=> _UploadFile();
}

class _UploadFile extends State<UploadFile>{

  late VideoPlayerController _controller;
  final dio = Dio();
  var pictures ;
  var videoUrl;
  List<dynamic> images = [];
  List<String> types = ["none", "classique", "moderne"];
  String selectType = "none";

  List<int> rooms = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  int selectRoom = 0;
  List<int> showers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  int selectShowers = 0;
  List<int> parking = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  int selectParking = 0;
  List<int> kitchen = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  int selectKitchen = 0;
  List<int> livingRoom = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  int selectLivingRoom= 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.asset("images/169249 (720p).mp4");

  }

  ImagePicker picker = ImagePicker();



  // Future<void> postArticle(ArticleDto articleDto) async{
  //   try{
  //     Response response = await dio.post("http://localhost:9001/api/articles/", data: articleDto.toJson());
  //     if(response.statusCode == 200){
  //       print(response.data);
  //     }
  //   }catch(e){
  //     print(e);
  //   }
  // }


  Future<void> getVideo() async{
    try{
      final XFile? result = await picker.pickVideo(source: ImageSource.gallery);
      if(result != null){
        setState(() {
          _controller = VideoPlayerController.file(File(result.path));
        });
      }
    }catch(e){
      print(e);
    }
  }

  Future<void> getPictures() async{
    try{
      XFile? result = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if(result != null){
          pictures = result.path;
          images.add(pictures);
          print(pictures);
        }
      });
    }catch(e){
      print(e);
    }
  }



  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: customText("upload you home", size: 20),
      ),
      body: GestureDetector(

        onTap:() => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 2, right: 2),
          child: Column(
            children: [
              SizedBox(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 12,
                  child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(fit: BoxFit.cover,
                            image:AssetImage("images/house.png")
                        )
                    ),
                    child:(_controller.dataSource.isNotEmpty)?
                    AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller)) : Container(),
                  ),
                ),
              ),
              padding(top: 10),
              SizedBox(
                height: 45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: getVideo,
                        icon: customIcon(Icons.video_camera_back_outlined, colors: Colors.black38)),
                    IconButton(
                      onPressed: getPictures,
                      icon: customIcon(Icons.add_photo_alternate_outlined, colors: Colors.black38),)
                  ],
                ),
              ),
              padding(top: 40),
              SizedBox(
                height: 200,
                child: CarouselSlider.builder(
                  options: CarouselOptions(height: 200),
                  itemCount: images.length,
                  itemBuilder: (context, index, realIndex){
                    return (images.isEmpty)?
                    SizedBox(
                      child:customIcon(Icons.filter, size: 190.0, colors: Colors.black38) ,
                    ): buildImage(images[index], index);
                  },
                ),
              ),
              padding(top: 20),
              Container(
                height: 100,
                child: const TextField(
                  maxLines: 100,
                  decoration: InputDecoration(
                      hintText: "give you condition at this place",
                      labelText: "the description of the house will be here ...",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)))
                  ),
                ),
              ),
              padding(top: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                    customText("Select the types of\n you are house"),
                  SizedBox(
                    width: 90,
                    height: 52,
                    child: DropdownButtonFormField(
                        value: selectType,
                        items: types
                            .map((select) => DropdownMenuItem<String>(
                            value: select,
                            child: customText(select))).toList(),
                        onChanged: null),
                  )
                ],
              ),
              padding(top: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customText("Please choose \nthe number of rooms"),
                  SizedBox(
                    width: 90,
                    height: 52,
                    child: DropdownButtonFormField(
                        value: selectRoom,
                        items: rooms
                            .map((select) => DropdownMenuItem(
                            value: select,
                            child: customText("$select"))).toList(),
                        onChanged: null),
                  )
                ],
              ),
              padding(top: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customText("Please choose \nthe number of showers"),
                  SizedBox(
                    width: 90,
                    height: 52,
                    child: DropdownButtonFormField(
                        value: selectShowers,
                        items: showers
                            .map((select) => DropdownMenuItem(
                            value: select,
                            child: customText("$select"))).toList(),
                        onChanged: null),
                  )
                ],
              ),
              padding(top: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customText("Please choose \nthe number of kitchens"),
                  SizedBox(
                    width: 90,
                    height: 52,
                    child: DropdownButtonFormField(
                        value: selectKitchen,
                        items: kitchen
                            .map((select) => DropdownMenuItem(
                            value: select,
                            child: customText("$select"))).toList(),
                        onChanged: null),
                  )
                ],
              ),
              padding(top: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customText("Please choose \nthe number of parking"),
                  SizedBox(
                    width: 90,
                    height: 52,
                    child: DropdownButtonFormField(
                        value: selectParking,
                        items: parking
                            .map((select) => DropdownMenuItem(
                            value: select,
                            child: customText("$select"))).toList(),
                        onChanged: null),
                  )
                ],
              ),
              padding(top: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: customText("Please choose \nthe number of livingRoom"),
                  ),
                  SizedBox(
                    width: 90,
                    height: 52,
                    child: DropdownButtonFormField(
                        value: selectLivingRoom,
                        items: livingRoom
                            .map((select) => DropdownMenuItem(
                            value: select,
                            child: customText("$select"))).toList(),
                        onChanged: null),
                  )
                ],
              ),
              SizedBox(
                height: 200,
              )
            ],
          ),
        ),
      ),
    );
  }


}
