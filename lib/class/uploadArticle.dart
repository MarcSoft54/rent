
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'function.dart';
import '../json/article.dart';

class UploadFile extends StatefulWidget{
  const UploadFile({super.key});


  @override
  State<UploadFile> createState()=> _UploadFile();
}

class _UploadFile extends State<UploadFile>{

  final dio = Dio();
  // final String video = '';
  var pictures ;
  var videoUrl;
  List<dynamic> images = [];


  ImagePicker picker = ImagePicker();



  Future<void> postArticle(ArticleDto articleDto) async{
    try{
      Response response = await dio.post("http://localhost:9001/api/articles/", data: articleDto.toJson());
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
        videoUrl = result.path;
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
                    child: IconButton(
                      onPressed: (){
                        setState(() {
                            // video player edition

                        });
                      },
                      icon: const Icon(Icons.play_arrow),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed: getVideo,
                        icon: customIcon(Icons.video_camera_back_outlined, size: 40.0)),
                    IconButton(
                      onPressed: getPictures,
                      icon: customIcon(Icons.image, size: 40.0),)
                  ],
                ),
              ),
              padding(top: 40),
              SizedBox(
                child: CarouselSlider.builder(
                  options: CarouselOptions(height: 200),
                  itemCount: images.length,
                  itemBuilder: (context, index, realIndex){
                    return (images.isEmpty)? Container(height: 10,): buildImage(images[index], index);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

// _pickVideo () async { PickedFile pickedFile = await picker.getVideo (source: ImageSource.gallery);
//   _video = File (pickedFile.path);
//   _videoPlayerController = VideoPlayerController.file (_video)..initialize ().then ((_) { setState (() { });
//     _videoPlayerController.play (); }); }
}
