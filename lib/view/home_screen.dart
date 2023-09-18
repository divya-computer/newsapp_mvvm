// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp_mvvm/model/news_channel_headlines_model.dart';
import 'package:newsapp_mvvm/view_model/news_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum FilterList { bbcNews, aryNews, independent, reuters, cnn, alJazeera }

class _HomePageState extends State<HomePage> {
  NewsViewModel newsViewModel = new NewsViewModel();
  final format = DateFormat('MMMM dd, yyyy');
  FilterList? selectedMenu;
  String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            'images/category_icon.png',
            height: 30,
            width: 30,
          ),
        ),
        title: Text(
          'News',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        actions: [
          PopupMenuButton<FilterList>(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onSelected: (FilterList items) {
              if (FilterList.bbcNews.name == items.name) {
                name = 'bbc-news';
              }

              if (FilterList.aryNews.name == items.name) {
                name = 'ary-news';
              }

              if (FilterList.alJazeera.name == items.name) {
                name = 'al-jazeera-english';
              }

              setState(() {
                selectedMenu = items;
                print('Name : $selectedMenu');
              });
              newsViewModel.fetchNewChannelHeadlinesApi(name);
            },
            initialValue: selectedMenu,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<FilterList>>[
              PopupMenuItem<FilterList>(
                value: FilterList.bbcNews,
                child: Text('BBC News'),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.aryNews,
                child: Text('Ary News'),
              ),
              PopupMenuItem<FilterList>(
                value: FilterList.alJazeera,
                child: Text('Al Jazeera News'),
              ),
            ],
          )
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * 0.55,
            width: width,
            child: FutureBuilder<NewsChannelsHeadlinesModel>(
              future: newsViewModel.fetchNewsChannelHeadlinesApi(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.blue,
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      scrollDirection: Axis.horizontal,
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
                                  horizontal: height * 0.02,
                                ),
                                height: height * 0.6,
                                width: width * 0.9,
                                child: ClipRRect(
                                  // borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        Container(child: spinkit2),
                                    errorWidget: (context, url, index) => Icon(
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
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(15.0),
                                    alignment: Alignment.bottomCenter,
                                    height: height * 0.22,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: width * 0.7,
                                          child: Text(
                                            snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: width * 0.7,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index]
                                                    .source!.name
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                format.format(dateTime),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

const spinkit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
