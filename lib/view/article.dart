
import 'package:flutter/material.dart';
import 'package:rentalapp/class/function.dart';
import 'package:rentalapp/view/profit.dart';

import 'lecture.dart';

class ArticleView extends StatefulWidget{
  const ArticleView({super.key, required this.id});
  final id;
  @override
  State<ArticleView> createState() => _ArticlePage();

}

class _ArticlePage extends State<ArticleView>{


  @override
  Widget build(BuildContext context) {
    var style = context.theme.textTheme;
    Color colorDark = context.theme.primaryColorDark;
    Color colorLight = context.theme.primaryColorLight;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: colorLight.withOpacity(.5),
      appBar: AppBar(
          backgroundColor: colorLight,
          title: Text.rich(
              TextSpan(
                  text: "RentApp",
                  style: style.headlineLarge
              )
          ),
        actions: [
          IconButton(
              onPressed: (){
                passForget(context);
          },
              icon: const Icon(Icons.search, size: 30,)
          ),
          IconButton(
              onPressed: (){
                passForget(context);
              },
              icon: const Icon(Icons.account_circle_outlined, size: 30,)
          )
        ],
      ),
      body: GestureDetector(
        onTap:() => FocusScope.of(context).requestFocus(FocusNode()),
        child: SingleChildScrollView(
          child: SizedBox(
            height: height,
            child: Column(
              children:[
                Expanded(
                  child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (BuildContext context, index){
                        return InkWell(
                          onTap: (){        // function to load in another page
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext conte){
                              return Lecture(id: index);
                            }));
                          },
                          child: Card(
                            elevation: 12,
                            child: Column(
                              children: [
                                Container(
                                    height: 250,
                                    width: double.infinity,
                                    color:colorDark.withOpacity(.5)
                                ),
                                ListTile(
                                  title: const Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("marc dev"),
                                      Text("duplex simple...")
                                    ],
                                  ),
                                  leading: const Icon(
                                      Icons.account_circle_outlined,
                                    size: 40.0,
                                  ),
                                  trailing: IconButton(
                                    onPressed: (){
                                      passForget(context);
                                    },
                                    icon: const Icon(Icons.favorite),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                padding(top: 5),
                const SizedBox(height: 160,)
              ],
            ),
          ),
        ),
      ),
    );
  }




}