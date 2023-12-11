import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:koperasimobile/constant/decoration_constant.dart';
import 'package:koperasimobile/constant/text_constant.dart';

class ItemCartWidget extends StatelessWidget {
  bool? fullwidth;
  ItemCartWidget({Key? key, this.fullwidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: DecorationConstant.boxRadiusShadowOnly(
        color: Colors.white,
        topRight: 8, topLeft: 8, bottomRight: 8, bottomLeft: 8,
        spreadRadius: 0.5, offset: Offset(0, 0), blurRadius: 3, colorShadow: Colors.grey.shade300
      ),
      // width: size.width * 0.36,
      margin: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: 'https://assets.adidas.com/images/w_600,f_auto,q_auto/dd5856ece5894f9987e9ae890026a723_9366/Forum_Low_CL_Shoes_White_HQ6874_01_standard.jpg',
            imageBuilder: (context, imageProvider) => Container(
              width: fullwidth! ? null:size.width * 0.36,
              height:size.height * 0.14,
              decoration: BoxDecoration(
                // shape: BoxShape.circle,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text('Adidas Forum Low CL', style: TextConstant.medium.copyWith(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.w600),)
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text('Rp 1.000.000', style: TextConstant.medium.copyWith(color: Colors.black87, fontSize: 12),)
          ),
          SizedBox(height: 10,)
        ],
      ),
    );
  }
}
