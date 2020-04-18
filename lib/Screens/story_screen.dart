import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:story_view/story_controller.dart';
import 'package:story_view/story_view.dart';
import 'package:http/http.dart' as http;

class StoryPageView extends StatefulWidget {
  List<String> storyItems;
  //int numberOfStories;


  StoryPageView(this.storyItems);

  @override
  _StoryPageViewState createState() => _StoryPageViewState();
}

class _StoryPageViewState extends State<StoryPageView> {
  //String userName = 'nasa';
  final controller = StoryController();

  List<StoryItem> pageVideos = new List<StoryItem>(3);

  List<StoryItem> tempStoryList = [
    StoryItem.pageVideo(
        'https://scontent-sjc3-1.cdninstagram.com/v/t50.12441-16/80549810_2640090626072077_9070999709648710594_n.mp4?_nc_ht=scontent-sjc3-1.cdninstagram.com&_nc_cat=101&oe=5DFCFE65&oh=20e7db9fb282a2f61cabe2363ebc090c'),
    StoryItem.pageVideo(
        'https://scontent-sjc3-1.cdninstagram.com/v/t50.12441-16/81352777_2399543333491447_8566035913777393946_n.mp4?_nc_ht=scontent-sjc3-1.cdninstagram.com&_nc_cat=107&_nc_ohc=gIxvNGrHyrQAX87F-lA&oe=5DFD9147&oh=e4dcc83c740fbed1bcf98a13c8a5fc0f')
  ];

  /*Future<List<StoryItem>> getStories(String userName) async {
    List<StoryItem> storyList;
    String link = 'https://api.storiesig.com/stories/$userName';
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "stories/json"});
    print(res.body);
    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      var story = data['items'] as List;
      for (int i = 0; i < story.length; i++) {
        storyList[i] =
            StoryItem.pageVideo(story[i]["video_versions"][0]['url']);
      }
    }
    return storyList;
  }*/

  List<StoryItem> convertTo(List<String> storyItem){

    for(int i = 0;i<storyItem.length;i++)
      pageVideos[i] = StoryItem.pageVideo(storyItem[i]);
    return pageVideos;

    //storyItem.forEach((x)=>pageVideos.add(StoryItem.pageVideo(x)));
  }





  @override
  Widget build(BuildContext context) {
    pageVideos = convertTo(widget.storyItems);


    return Material(
      child: StoryView(
        pageVideos,
        controller: controller,
        inline: false,repeat: true,

      ),
    );
  }
}
