
import 'package:flutter/material.dart';
import 'package:rentalapp/view/profit.dart';

class Explore extends StatelessWidget{
  const Explore({super.key, required this.id});
  final id;

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true
      ),
      home: ExplorePage(id: id),
    );
  }
}


class ExplorePage extends StatefulWidget{
  final id;
  const ExplorePage({super.key, required this.id});

  @override
  State<ExplorePage> createState() => _ExplorePage();
}

class _ExplorePage extends State<ExplorePage>{

  @override
  Widget build(BuildContext context) {
    var style = context.theme.textTheme;
    Color colorLight = context.theme.primaryColorLight;
    Color colorDark = context.theme.primaryColorDark;
    return Scaffold(
      backgroundColor: colorLight.withOpacity(.5),
      appBar: AppBar(
        backgroundColor: colorLight,
        title: Text("Filters",
          style: style.headlineLarge,),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Text.rich(
                TextSpan(
                    text: "Price (for 1 month)",
                    style: style.titleSmall
                )
            ),
            Slider(
              thumbColor: colorLight,
              inactiveColor: colorDark,
              activeColor: colorDark.withOpacity(.5),
              label: "price",
                max: 12000,
                min: 100,
                value: 100,
                onChanged: (value){
                setState(() {

                });
                }
            ),
            Divider(color: colorDark,),
            Text.rich(
              TextSpan(
                text: "Popular filters",
                style: style.titleSmall
              )
            ),
            Container(
              color: colorDark,
              height: 100,
            ),
            Divider(color: colorDark,),
            Text.rich(
              TextSpan(
                text: "Distance from city",
                style: style.titleSmall
              )
            ),
          ],
        ),
      ),
    );
  }

}