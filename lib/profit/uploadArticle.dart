
import 'dart:developer';

import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
// import 'package:better_player/better_player.dart';
import 'package:dismissible_carousel_viewpager/dismissible_carousel_viewpager.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rentalapp/view/profit.dart';
// import 'package:video_player/video_player.dart';


class UploadFile extends StatelessWidget{
  final id;
  const UploadFile({super.key, required this.id});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true
      ),
      color: Colors.blue,
      home: Upload(id:id),
    );
  }
}

class Upload extends StatefulWidget{
  final id;
  const Upload({super.key, required this.id});

  @override
  State<Upload> createState() => _Upload();

}
class _Upload extends State<Upload>{

  final dio = Dio();
  var pictures ;
  String video = '';
  String mapUrl = '';

  String? city;
  String? country;
  late Uint8List pict;
  // late Uint8List videoFileUrl;
  List<String> images = [];
  String? description;

  List<String> types = [
    "Modern room",
    "Classic room",
    "Studio classic",
    "Studio modern",
    "Apartment classic",
    "Apartment modern"
  ];
  String? selectType;
  int? room;
  int? shower;
  int? kitchen;
  int? living_room;
  int? parking;
  double? price;

  var list;

  // late FlickManager flickManager;
  // @override
  // void initState() {
  //   super.initState();
  //   flickManager = FlickManager(
  //       videoPlayerController: VideoPlayerController.networkUrl(Uri.parse('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
  //   );
  // }
  // @override
  // void dispose() {
  //   flickManager.dispose();
  //   super.dispose();
  // }

  // late BetterPlayerController _playerController ;

  // @override
  // void initState() {
  //   super.initState();
  //   BetterPlayerDataSource dataSource = BetterPlayerDataSource(
  //   BetterPlayerDataSourceType.network
  //   ,"https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4");
  //   _playerController = BetterPlayerController(
  //     const BetterPlayerConfiguration(),
  //     betterPlayerDataSource: dataSource
  //   );
  // }
  //
  // @override
  // void dispose() {
  //   super.dispose();
  //   _playerController.dispose();
  // }


  ImagePicker picker = ImagePicker();

  getMultiplePicture() async{
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      image.readAsBytes().then((value) {
        setState(() {
          pict = value;
          images.add(String.fromCharCodes(pict));
        });
      });
    }
    // log("total images : ${images.length}");
  }

  // getOneVideo() async{
  // XFile? videoByte = await picker.pickVideo(source: ImageSource.gallery);
  // log("reach");
  // if(videoByte != null){
  //   BetterPlayerDataSource dataSource = BetterPlayerDataSource(
  //       BetterPlayerDataSourceType.file
  //       , videoByte.path);
  //   _playerController = BetterPlayerController(  // getting the news intense of the video
  //       const BetterPlayerConfiguration(),
  //       betterPlayerDataSource: dataSource
  //   );
  //
  //   videoByte.readAsBytes().then((value){  // i can steel remove this after if this better_player take
  //     setState(() {
  //       list = value;  // the value of the video convert into Uint8List
  //       video = String.fromCharCodes(value); // converting the video to string before send it
  //
  //     });
  //   });
  // }
  //
  // }


  @override
  Widget build(BuildContext context) {
    final colorDark = context.theme.primaryColorDark;
    final colorLight = context.theme.primaryColorLight;
    final style = context.theme.primaryTextTheme.titleMedium;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: colorLight,
          title: Text("home upload", style: context.theme.textTheme.headlineSmall,),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      context.theme.primaryColorDark.withOpacity(.2),
                      Colors.greenAccent.withOpacity(.6)
                    ]
                )
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Stack(
                  //   alignment: Alignment.center,
                  //   children: [
                  //     DottedBorder(
                  //         dashPattern: const [15],
                  //         borderType: BorderType.RRect,
                  //         radius: const Radius.circular(12),
                  //         padding: const EdgeInsets.only(left: 6, right: 6),
                  //         color: Colors.black.withOpacity(.4),
                  //         strokeWidth: 2,
                  //         child: SizedBox(
                  //           height: 200,
                  //           width: double.infinity,
                  //           child: AspectRatio(         // video player here ...
                  //             aspectRatio: 16/9,
                  //             child: BetterPlayer(
                  //               controller: _playerController,
                  //             )
                  //           ),
                  //         )
                  //     ),
                  //     Positioned(
                  //         bottom: 0,
                  //         right: 0,
                  //         child: IconButton(                                    // video player here ...
                  //             color: colorDark,
                  //             onPressed: (){
                  //                 setState(() {
                  //                   getOneVideo();
                  //                   // flickManager = FlickManager(
                  //                   //     videoPlayerController: VideoPlayerController.file(File.fromRawPath(list))
                  //                   // );
                  //                 });
                  //             },
                  //             icon:  Icon(Icons.video_camera_back_outlined,size: 35,color: colorDark))
                  //     )
                  //   ],
                  // ),
                  Stack(
                    children: [
                      DottedBorder(
                        strokeWidth: 2.0,
                        dashPattern: [1],
                        borderType: BorderType.RRect,
                        child: Container(
                          height: 200,
                          width: double.infinity,
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          child:  Icon(
                            Icons.upload_outlined,
                            color: colorDark,
                            size: MediaQuery.of(context).size.width*.4,)
                      ),
                      // const Positioned(
                      //     child: Text.rich(
                      //       TextSpan(
                      //         text: "\t welcome \n here you have the opportunity to post "
                      //       )
                      //     ),
                      // )
                    ],
                  ),
                  const SizedBox(height: 50),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Row(
                        children: [
                          const Icon(Icons.list, color: Colors.white,size: 29),
                          const SizedBox(width: 15),
                          Expanded(
                              child: Text("Select the type of the house",
                                style: style,
                              )
                          )
                        ],
                      ),
                      items: types
                          .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                              item,
                              style: style,
                              overflow: TextOverflow.ellipsis
                          )
                      )
                      ).toList(),
                      value: selectType,
                      onChanged: (value){
                        setState(() {
                          selectType = value!;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 45,
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: colorDark.withOpacity(.9)
                        ),
                        // elevation: 2
                      ),
                      iconStyleData: IconStyleData(
                          iconSize: 22,
                          icon: Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: Colors.white.withOpacity(.6)
                          )
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                            borderRadius:  BorderRadius.circular(10),
                            color: colorDark
                        ),
                      ),
                    ),
                  ),
                  Accordion(
                    key: const ValueKey("A1"),
                      maxOpenSections: 8,
                      headerBackgroundColor: colorDark.withOpacity(.9),
                      headerBackgroundColorOpened: colorDark.withOpacity(.3),
                      headerBorderColorOpened: colorLight,
                      contentBorderWidth: 2,
                      openAndCloseAnimation: true,
                      scaleWhenAnimating: true,
                      flipRightIconIfOpen: true,
                      children: [
                        AccordionSection(
                          headerPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          sectionClosingHapticFeedback: SectionHapticFeedback.light,
                          sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                          // isOpen: true,
                          header: Text("Gallery", style: style,),
                          content: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                  height: 250,
                                  width: double.infinity,
                                  child: (images.isEmpty)?
                                  Icon(Icons.image_outlined, size: 150, color: colorDark.withOpacity(.3),)
                                      : DismissibleCarouselViewPager(
                                    itemCount: images.length,
                                    itemBuilder: (context, index){
                                      String data = images[index];
                                      List<int> list = data.codeUnits;
                                      Uint8List byte = Uint8List.fromList(list);
                                      return Container(
                                        key: Key(data),
                                        alignment: Alignment.center,
                                        color: colorDark.withOpacity(.5),
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                                height: double.infinity,
                                                width: double.infinity,
                                                child: Card(
                                                    elevation: 12,
                                                    child: images.isNotEmpty ? Image.memory(byte,
                                                      fit: BoxFit.fill,): Icon(Icons.image_outlined, size: 128, color: Colors.black.withOpacity(.0))
                                                )
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: IconButton(
                                                  onPressed: (){
                                                    setState(() {
                                                      images.remove(data);
                                                      log("apres suppression : ${images.length}");
                                                    });
                                                  },
                                                  icon: Icon(Icons.delete, color: colorDark,)
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    dismissalConfig: DismissalConfig(
                                        dismissalTypes: [
                                          DismissalType.fadeOut(),
                                          DismissalType.slideOut()
                                        ]
                                    ),
                                  )
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: IconButton.filledTonal(
                                    onPressed: getMultiplePicture,
                                    icon: const Icon(Icons.add_photo_alternate_outlined)),)
                            ],
                          ),
                          leftIcon: Icon(Icons.library_add, color: context.theme.cardColor),
                        )
                      ],

                  ),
                  Accordion(
                      key: const ValueKey("A2"),
                      maxOpenSections: 8,
                      headerBackgroundColor: colorDark.withOpacity(.9),
                      headerBackgroundColorOpened: colorDark.withOpacity(.3),
                      headerBorderColorOpened: colorLight,
                      contentBorderWidth: 2,
                      openAndCloseAnimation: true,
                      scaleWhenAnimating: true,
                      flipRightIconIfOpen: true,
                      children: [
                        AccordionSection(
                            headerPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            sectionClosingHapticFeedback: SectionHapticFeedback.light,
                            sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                            leftIcon: Icon(Icons.question_answer_rounded, color: context.theme.cardColor),
                            header: Text("Description", style: style,),
                            content: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: TextFormField(
                                        maxLength: 15,
                                        decoration: sectionDecorationInput(context, "country"),
                                        onChanged: (value){
                                          country = value;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: TextFormField(
                                        maxLength: 15,
                                        decoration: sectionDecorationInput(context, "city"),
                                        onChanged: (value){
                                          city = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                TextFormField(
                                  maxLength: 500,
                                  maxLines: 5,
                                  minLines: 2,
                                  decoration: sectionDecorationInput(context, "give you condition...", b: true,
                                      text: "the house is inside the barrier and is secure water .... so here you can say every thing that you want"
                                  ),
                                  onChanged: (value){
                                    description = value;
                                  },
                                ),
                              ],
                            )
                        ),
                  ]),
                  Accordion(
                      key: const ValueKey("A3"),
                      maxOpenSections: 8,
                      headerBackgroundColor: colorDark.withOpacity(.9),
                      headerBackgroundColorOpened: colorDark.withOpacity(.3),
                      headerBorderColorOpened: colorLight,
                      contentBorderWidth: 2,
                      openAndCloseAnimation: true,
                      scaleWhenAnimating: true,
                      flipRightIconIfOpen: true,
                      children: [
                        AccordionSection(
                            headerPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            sectionClosingHapticFeedback: SectionHapticFeedback.light,
                            sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                            header: Text("House constitution", style: style,),
                            leftIcon: Icon(Icons.home_outlined, color: context.theme.cardColor,),
                            content: SizedBox(
                                width: double.infinity,
                                height: 230,
                                child: Column(
                                  children: [
                                    Text.rich(
                                        TextSpan(
                                            text: "please full the correct information for you house",
                                            style: context.theme.textTheme.titleSmall
                                        )
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          width: 80,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            maxLength: 2,
                                            decoration: sectionDecorationInput(context, "rooms"),
                                            onChanged: (value){
                                              room = int.parse(value);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 80,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            maxLength: 2,
                                            decoration: sectionDecorationInput(context, "shower"),
                                            onChanged: (value){
                                              shower = int.parse(value);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 80,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            maxLength: 2,
                                            decoration: sectionDecorationInput(context, "kitchen"),
                                            onChanged: (value){
                                              kitchen = int.parse(value);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          width: 80,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            maxLength: 2,
                                            decoration: sectionDecorationInput(context, "parking"),
                                            onChanged: (value){
                                              parking = int.parse(value);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 80,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            maxLength: 15,
                                            decoration: sectionDecorationInput(context, "price by month"),
                                            onChanged: (value){
                                              price = double.parse(value);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 80,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            maxLength: 2,
                                            decoration: sectionDecorationInput(context, "living room"),
                                            onChanged: (value){
                                              living_room = int.parse(value);
                                            },
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                            )
                        ),
                      ]),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(colorDark),
                            ),
                            onPressed: cancel,
                            child: Text("Cancel", style: style)),
                      ),
                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(colorDark),
                            ),
                            onPressed: (){
                              log("room:$room, living_room : $living_room: shower : $shower");
                            },
                            child: Text("Post", style: style)),
                      )
                    ],
                  ),
                  const SizedBox(height: 100),
                  Text.rich(
                      TextSpan(
                          text: "Made by @marcdev",
                          style: context.theme.textTheme.titleMedium
                      )
                  )
                ],
              ),
            ),
          ),

        ));

  }

  Future<void> cancel() async{
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
          return SimpleDialog(
            elevation: 12,
            contentPadding: const EdgeInsets.all(25),
            titlePadding: const EdgeInsets.only(left: 60, right: 50, top: 50),
            title: const Text.rich(TextSpan(text: "Attention !!!",
                style: TextStyle(
                    color: Colors.redAccent
                ))),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text.rich(
                      TextSpan(
                          text: "are you sure to cancel the article"
                      )
                  ),
                  SizedBox(
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                            onPressed: (){
                              context.go("/home/${widget.id}");
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(context.theme.primaryColor.withOpacity(.2))
                            ),
                            icon: const Icon(Icons.bolt_outlined),
                            label: Text("Yes", style: context.theme.textTheme.titleMedium,)),
                        ElevatedButton.icon(
                            onPressed: (){
                              context.pop();
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(context.theme.primaryColor.withOpacity(.2))
                            ),
                            icon: const Icon(Icons.cancel_outlined),
                            label: Text("No", style: context.theme.textTheme.titleMedium,))
                      ],
                    ),
                  )
                ],
              ),

            ],
          );
        }
    );
  }


  InputDecoration sectionDecorationInput(BuildContext context, String string,
      {bool b = false ,String text = ""}) {
    return InputDecoration(
      hintText: b? text: "",
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12)
      ),
      label: Text(string, style: context.theme.textTheme.titleSmall,),

    );
  }



}


