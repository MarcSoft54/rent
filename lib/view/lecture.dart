import 'package:carousel_slider/carousel_slider.dart';
import 'package:dismissible_carousel_viewpager/dismissible_carousel_viewpager.dart';
import 'package:flutter/material.dart';
import 'package:rentalapp/class/function.dart';
import 'package:rentalapp/json/article.dart';
import 'package:rentalapp/view/profit.dart';

class Lecture extends StatelessWidget{
  final id;
  const Lecture({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.blue,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true
      ),
      home: _Lecture(id:id),
    );
  }
}

class _Lecture extends StatefulWidget{
  final id;
  const _Lecture({this.id});

  @override
  _LectureState createState() => _LectureState();
}

class _LectureState extends State<_Lecture>{

  Article article = Article(
      id: 0,
      typeArticle: "typeArticle",
      country: "country",
      city: "city",
      mapUrl: "mapUrl",
      pictureUrl: ["pictureUrl"],
      videoUrl: "videoUrl",
      description: "description",
      room: 0,
      shower: 0,
      parking: 0,
      kitchen: 0,
      livingRoom: 0
  );

  @override
  Widget build(BuildContext context) {
    var style = context.theme.textTheme;
    Color colorLight = context.theme.primaryColorLight;
    Color colorDark = context.theme.primaryColorDark;
    return Scaffold(
      backgroundColor: colorLight,
      appBar: AppBar(
        backgroundColor: colorLight,
        title: Text.rich(
            TextSpan(
                text: "RentApp",
                style: style.headlineLarge
            )
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.black26,
              ),
              padding(top: 5),
              ListTile(
                title: Row(
                  children: [
                    TextButton(
                        onPressed: (){      // post like and must be authenticated
                          passForget(context);
                        },
                        child: Icon(Icons.thumb_up_alt_outlined)
                    ),
                    TextButton(
                        onPressed: (){      // post dislike ans must be authenticated
                          passForget(context);
                        },
                        child: Icon(Icons.thumb_down_alt_outlined)
                    ),
                    IconButton(onPressed: (){
                      passForget(context);
                    },
                        icon: Icon(Icons.share)
                    )
                  ],
                ),
                leading: const Icon(Icons.account_circle_outlined, size: 40.0,),
              ),
              Container(
                height: 120,
                width: double.infinity,
                color: Colors.black26,
                child: Text.rich(
                    TextSpan(
                        text: "description",
                        style: style.titleSmall
                    )
                ),
              ),
              padding(top: 10),
              Container(
                height: 200,
                width: double.infinity,
                child: DismissibleCarouselViewPager(
                  itemCount: 5,
                  itemBuilder: (content, index){
                    return Card(
                      elevation: 12,
                      child: Image.asset("images/house.png"),
                    );
                  },
                )
              ),
              const SizedBox(height: 10,),
              TextFormField(
                minLines: 1,
                maxLines: 5,
                maxLength: 200,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hoverColor: colorLight,
                  contentPadding: const EdgeInsets.only(left: 10, right: 10),
                    hintText: "commentaire ...",
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                  child: TextButton.icon(
                      onPressed: (){

                      },
                      icon: Icon(Icons.send_rounded),
                      label: Text.rich(
                        TextSpan(
                          text: "submit",
                          style: style.titleSmall
                        )
                      ))
              ),
              const SizedBox(height: 10,),
              const SizedBox(
                height: 200,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: Icon(Icons.messenger, color: colorDark),
      ),
    );
  }
}