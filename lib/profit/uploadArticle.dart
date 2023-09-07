
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../class/function.dart';
import '../json/article.dart';


class UploadFile extends StatefulWidget{
  final id;
  const UploadFile({super.key, required this.id});


  @override
  State<UploadFile> createState()=> _UploadFile();
}

class _UploadFile extends State<UploadFile>{

  var _controller;
  final dio = Dio();
  var pictures ;
  var videoUrl;
  double price = 0;
  String city = '';
  List<String> images = [];
  String description = '';
  List<String> types = [
    "none",
    "Chambre modern",
    "Chambre classic",
    "studio classic",
    "studio modern",
    "Appartement classic",
    "Appartement modern"
  ];
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
    super.initState();
    _controller = VideoPlayerController.asset("images/169249 (720p).mp4")
      ..initialize().then((_) {
        setState(() {});
      });
  }

  ImagePicker picker = ImagePicker();

  Future<void> postArticle(ArticleDto articleDto, int userIde) async{
    try{
      Response response = await dio.post("http://localhost:9001/api/articles/$userIde", data: articleDto.toJson());
      if(response.statusCode == 200){
        print(response.data);
      }
    }catch(e){
      print(e);
    }
  }


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
          images.add(pictures.toString());
          print(pictures);
        }
      });
    }catch(e){
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }



  @override
  Widget build(BuildContext context){
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: customText("upload you home", size: 20),
      ),
      body: GestureDetector(
        onTap:() => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 2, right: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      child:(_controller.value.isInitialized)?
                      AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller)
                      )
                          :Container()
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
                width: MediaQuery.of(context).size.width,
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
              TextField(
                minLines: 1,
                maxLines: 5,
                maxLength: 500,
                decoration: const InputDecoration(
                    hintText: "give you condition ...",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)))
                ),
                onChanged: (string){
                  setState(() {
                    description = string;
                  });
                },
              ),
              padding(top: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customText("types of house"),
                  SizedBox(
                    width: 200,
                    child: DropdownButtonFormField(
                        decoration: buildInputDecoration(),
                        value: selectType,
                        items: types
                            .map((select) => DropdownMenuItem<String>(
                            value: select,
                            child: customText(select))).toList(),
                        onChanged: (string){
                          setState(() {
                            selectType = string!;
                          });
                        }),
                  )
                ],
              ),
              padding(top: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customText("Price"),
                  padding(left: 2),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(width: 1, color: Colors.blue)
                          ),
                          border: OutlineInputBorder()
                      ),
                      onSubmitted: (string){
                        setState(() {
                          price = double.parse(string);
                        });
                      },
                    ),
                  )
                ],
              ),
              padding(top: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customText("Country and locality"),
                  SizedBox(
                    width: 200,
                    child: TextField(
                      minLines: 1,
                      maxLines: 2,
                      maxLength: 70,
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(width: 1, color: Colors.blue)
                          ),
                          border: OutlineInputBorder()
                      ),
                      onSubmitted: (string){
                        setState(() {
                          city = string;
                        });
                      },
                    ),
                  )
                ],
              ),
              padding(top: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customText("rooms"),
                  SizedBox(
                    width: size*.2,
                    child: DropdownButtonFormField(
                        decoration: buildInputDecoration(),
                        value: selectRoom,
                        items: rooms
                            .map((select) => DropdownMenuItem(
                            value: select,
                            child: customText("$select"))).toList(),
                        onChanged: (string){
                          setState(() {
                            selectRoom = string!;
                          });
                        }),
                  )
                ],
              ),padding(top: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customText("showers"),
                  SizedBox(
                    width: size*.2,
                    child: DropdownButtonFormField(
                        decoration: buildInputDecoration(),
                        value: selectShowers,
                        items: showers
                            .map((select) => DropdownMenuItem(
                            value: select,
                            child: customText("$select"))).toList(),
                        onChanged: (string){
                          setState(() {
                            selectShowers = string!;
                          });
                        }),
                  )
                ],
              ),padding(top: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customText("kitchens"),
                  SizedBox(
                    width: size*.2,
                    child: DropdownButtonFormField(
                        decoration: buildInputDecoration(),
                        value: selectKitchen,
                        items: kitchen
                            .map((select) => DropdownMenuItem(
                            value: select,
                            child: customText("$select"))).toList(),
                        onChanged: (string){
                          setState(() {
                            selectKitchen = string!;
                          });
                        }),
                  )
                ],
              ),
              padding(top: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customText("parking"),
                  SizedBox(
                    width: size*.2,
                    child: DropdownButtonFormField(
                        decoration: buildInputDecoration(),
                        value: selectParking,
                        items: parking
                            .map((select) => DropdownMenuItem(
                            value: select,
                            child: customText("$select"))).toList(),
                        onChanged: (string){
                          setState(() {
                            selectParking = string!;
                          });
                        }),
                  )
                ],
              ),
              padding(top: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customText("livingRoom"),
                  SizedBox(
                    width: size*.2,
                    child: DropdownButtonFormField(
                        decoration: buildInputDecoration(),
                        value: selectLivingRoom,
                        items: livingRoom
                            .map((select) => DropdownMenuItem(
                            value: select,
                            child: customText("$select"))).toList(),
                        onChanged: (string){
                          setState(() {
                            selectLivingRoom = string!;
                          });
                        }),
                  )
                ],
              ),
              padding(top: 20),

              const SizedBox(
                height: 200,
              )
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       _controller.value.isPlaying
      //           ? _controller.pause()
      //           : _controller.play();
      //     });
      //   },
      //   child: Icon(
      //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
      //   ),
      // ),
    );
  }

  InputDecoration buildInputDecoration() {
    return const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(width: 1, color: Colors.blue)
                          )
                      );
  }


}
