
import 'package:flutter/material.dart';

import '../../moduls/webView/web_view.dart';

Widget defultItemDesign( item ,context){
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) => WebViewScreen(url: item['url']),));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            child:  Image(
                fit: BoxFit.cover,
                image: item['urlToImage'] == null ? NetworkImage("https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg"):NetworkImage("${item['urlToImage']}")),
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(child: Text("${item['title']}",
                    maxLines: 3 ,
                    textDirection: TextDirection.rtl,
                    overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleLarge,)),
                  Text("${item['publishedAt']}",style: Theme.of(context).textTheme.titleSmall,),
                ],),
            ),
          )
        ],
      ),
    ),
  );
}