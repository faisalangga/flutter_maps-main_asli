import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koperasimobile/constant/decoration_constant.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/utils/local_data.dart';

class HeaderHomeWidget extends StatelessWidget {
  Function? onSearch;
  HeaderHomeWidget({Key? key, this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      color: Colors.green,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          SizedBox(height: size.height * 0.035,),
          Row(
            children: [
              FutureBuilder(
                future: LocalData.getData('user'),
                builder: (context, snapshot) {
                  return Text('Hi, '+snapshot.data.toString(), style: TextConstant.medium.copyWith(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),);
                }
              ),
              Expanded(child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(CupertinoIcons.cart, color: Colors.white,),
                  SizedBox(width: 10),
                  CachedNetworkImage(
                    imageUrl: 'https://cdn.pixabay.com/photo/2016/11/18/23/38/child-1837375__340.png',
                    imageBuilder: (context, imageProvider) => Container(
                      width: 35.0,
                      height: 35.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  )
                ],
              ))
            ],
          ),
          SizedBox(height: 15),
          GestureDetector(
            onTap: ()=>onSearch!(),
            child: Container(
              decoration: DecorationConstant.boxButton(radius: 8, color: Colors.white),
              height: 40,
              width: double.infinity,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Icon(CupertinoIcons.search, color: Colors.grey.shade300,),
                  SizedBox(width: 10),
                  Text('Cari barang disini...', style: TextConstant.medium.copyWith(color:Colors.grey.shade300, fontSize: 13),)
                ],
              ),
              // child: TextField(
              //   enabled: false,
              //   decoration: InputDecoration(
              //     prefixIcon: Icon(CupertinoIcons.search, color: Colors.grey.shade300,),
              //     border: InputBorder.none,
              //     contentPadding: EdgeInsets.only(top: 7),
              //   ),
              // ),
            ),
          )
        ],
      ),
    );
  }
}
