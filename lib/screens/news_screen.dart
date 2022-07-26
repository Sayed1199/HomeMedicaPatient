import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:homemedica_patient/controllers/news_controller.dart';
import 'package:homemedica_patient/models/news_model.dart';

import 'package:url_launcher/url_launcher.dart';
class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {

  NewsController newsController = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          newsController.getNews();
          return Obx(()=>
          newsController.newsList.value.isNotEmpty?
             NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
                return [
                  SliverToBoxAdapter(
                    child:newsController.strToday.value!=null? SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(onPressed: (){
                              Get.back();
                            }, icon: Icon(CupertinoIcons.left_chevron)),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: AutoSizeText(newsController.strToday.value!,style:GoogleFonts.aBeeZee(
                                  fontSize: 20,
                                  color: Colors.grey
                              ),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ):Container(),)

                ];
              },
               body: Padding(
                 padding: const EdgeInsets.symmetric(vertical: 10),
                 child: ListView.separated(
                     itemBuilder: (context,index){
                       return NewsItems(article: newsController.newsList.value[index]);
                     },
                     separatorBuilder: (context,index){
                       return SizedBox(
                         height: 30,
                       );
                     },
                     itemCount: newsController.newsList.value.length),
               ),
            ):Center(
            child: CircularProgressIndicator(),
          ),
          );
        }
      ),
    );
  }
}

class NewsItems extends StatelessWidget {
  final Articles article;
   NewsItems({Key? key,required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return GestureDetector(
      onTap: () async {

      },
      child: Center(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width*0.9,
              height: MediaQuery.of(context).size.height*0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child:article.urlToImage!=null? CachedNetworkImage(
                  imageUrl: article.urlToImage!,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        ),
                  ),
                ),
                errorWidget: (context,url,err)=>Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(CupertinoIcons.nosign),
                ),
              ):Container(),
            ),
       Positioned(
         bottom: 0,
         child: Container(
           width: MediaQuery.of(context).size.width*0.8,
           height: MediaQuery.of(context).size.height*0.2,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(8.0),
             gradient: LinearGradient(
               begin: Alignment.bottomCenter,
               end: Alignment.topCenter,
               colors: [
                 Colors.black,
                 Colors.black.withOpacity(0.0),
               ],
               stops: [
                 0.0,
                 1.0,
               ],
             ),
           ),
         ),
       ),
                GestureDetector(
                  onTap: ()async{
                    print('url');
                    if (await canLaunch(article.url!)) {
                      await launch(article.url!);
                    } else {
                      Fluttertoast.showToast(
                          msg: "Couldn't load this url...",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.blue,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Container(
                    decoration: BoxDecoration(
                      color: Colors.pink.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(48),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 14,
                    ),
                    child: Text(
                      'See More',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
              ),
                  ),
                ),

            Positioned(
              bottom: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.8,
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: AutoSizeText(
                        article.title != null? article.title!:'' ,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                      maxLines: 2,
                      ),
                    ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        article.publishedAt != null?article.publishedAt!:'',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        ' | ',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        article.source!=null?
                        article.source!.name!:'',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
