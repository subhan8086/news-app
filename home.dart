import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/NewsChannelHeadlineModel.dart';
import 'package:news_app/model/caterogy_news_model.dart';
import 'package:news_app/screen/category_screen.dart';

import 'package:news_app/screen/view/news_view_model.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

enum FilterList { bbcNews, aryNews, independent, reuters, cnn, alJazeera }

class _home_screenState extends State<home_screen> {
  NewsViewModel newsViewModel = NewsViewModel();

  final format = DateFormat('MMM dd, yyyy'); // Use 'yyyy' to display the year
  FilterList? SelectedMenu;
  String name = 'bbc-news';
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final Width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        //automaticallyImplyLeading: false,   we use this pushReplacement in splash screen
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => categoryscreen()));
          },
          icon: Image.network(
            'https://cdn-icons-png.flaticon.com/512/5665/5665189.png',
            color: Colors.black,
            height: 80,
            width: 30,
            //  Size: .5,
          ),
        ),
        title: Center(
            child: Text(
          'News',
          style: GoogleFonts.poppins(
              fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black),
        )),
        actions: [
          PopupMenuButton<FilterList>(
              initialValue: SelectedMenu,
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onSelected: (FilterList item) {
                if (FilterList.bbcNews.name == item.name) {
                  name = 'bbc-news';
                }
                // if (FilterList.cnn.name == item.name) {
                //   name = 'cnn';
                // }
                if (FilterList.aryNews.name == item.name) {
                  name = 'ary-news';
                }
                if (FilterList.cnn.name == item.name) {
                  name = 'CNN';
                }
                setState(() {
                  SelectedMenu = item;
                });
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<FilterList>>[
                    PopupMenuItem<FilterList>(
                        value: FilterList.bbcNews, child: Text('BBC News')),
                    PopupMenuItem<FilterList>(
                        value: FilterList.aryNews, child: Text('Ary News')),
                    // PopupMenuItem<FilterList>(
                    //     value: FilterList.alJazeera,
                    //     child: Text('Al-Jazeera News')),
                    PopupMenuItem<FilterList>(
                        value: FilterList.cnn, child: Text('Cnn News')),
                  ]),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
              height: height * .55,
              width: Width * .50,
              child: FutureBuilder<NewschannelHeadlinemodel>(
                  future: newsViewModel.FetchNewsChannelApi(name),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKitCircle(
                          size: 40,
                          color: Colors.blue,
                        ),
                      );
                    } else {
                      return ListView.builder(
                          // scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.articles!.length,
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt
                                .toString());
                            return SizedBox(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: height * 0.02),
                                    height: height * 0.6,
                                    width: Width * 0.9,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            SpinKitFadingCircle(
                                          color: Colors.amber,
                                          size: 50,
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    child: Card(
                                      elevation: 5,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Container(
                                        padding: EdgeInsets.all(15),
                                        alignment: Alignment.bottomCenter,
                                        height: height * 0.22,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: Width * 0.7,
                                              child: Text(
                                                snapshot.data!.articles![index]
                                                    .title
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              width: Width * 0.7,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .source!
                                                        .name
                                                        .toString(),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    format.format(dateTime),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    }
                  })),
        ],
      ),
    );
  }
}
