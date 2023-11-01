import 'package:newsapi/controller/home_screen_controller.dart';
import 'package:newsapi/model/mymodel.dart';

import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:newsapi/news_detail_screen/news_detail_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 
  TextEditingController searchController = TextEditingController();
int _currentIndex = 0;
  @override
  void initState() {
    super.initState();

    Provider.of<HomeScreenController>(context, listen: false).fetchNews();
  }

 


  @override
  Widget build(BuildContext context) {
    var homeScreenProvider=Provider.of<HomeScreenController>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [Icon(Icons.notifications, color: Colors.white), SizedBox(width:15)],
        backgroundColor: Colors.red,
leading: Icon(Icons.menu),
        title: Text("NewsToday")
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RefreshIndicator(
            onRefresh: () async {
              
            },
            child: Column(
              children: [
                TextField(
            controller: searchController,
            onChanged: (value) {
              Provider.of<HomeScreenController>(context, listen: false).fetchNews(searchQuery: searchController.text);
            },
            decoration: InputDecoration(
              hintText: 'Search News...',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              suffixIcon: IconButton(
                onPressed: () {
                  searchController.clear();
                
                },
                icon: Icon(Icons.clear),
              ),
            ),
                  ),
                  homeScreenProvider.isLoading?Center(child: CircularProgressIndicator(),):
                  SizedBox(height:10),
               CarouselSlider.builder(
                itemCount: homeScreenProvider.responseData?.articles?.length ?? 0,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  // Get the imageUrl based on the current index
                  String? imageUrl = homeScreenProvider.responseData?.articles?[index].urlToImage;
          
                  return imageUrl != null
              ? Image.network(imageUrl, fit: BoxFit.cover)
              : Placeholder(); // Placeholder if imageUrl is null
                },
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 14/9,
             
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
            setState(() {
              _currentIndex = index;
            });
                  },
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
            padding: const EdgeInsets.only(left: 8, top: 10),
            child: Text("Latest News", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ],
              ),
          
                Expanded(
                  child: ListView.builder(
                    itemCount: homeScreenProvider.responseData?.articles?.length??0,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewsDetailScreen(
                                      newArticle: homeScreenProvider.responseData?.articles?[index],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 130,
                                width: 130,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      homeScreenProvider.responseData?.articles?[index].urlToImage ??
                                          "https://www.themodestman.com/wp-content/uploads/2023/02/Best-Menswear-Brands.jpg",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: Text(
                                homeScreenProvider.responseData?.articles?[index].description ?? "",
                                softWrap: true,
                                maxLines: 5,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}
