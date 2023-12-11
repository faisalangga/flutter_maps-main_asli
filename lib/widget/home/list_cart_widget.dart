import 'package:flutter/material.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/widget/cart/item_cart_widget.dart';

class ListCartWidget extends StatelessWidget {
  String? title;
  Function? onItemClick;
  ListCartWidget({Key? key, this.title, this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title!, style: TextConstant.medium.copyWith(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w600),),
          Container(
            height:size.height * 0.23,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (BuildContext context, int index){
                return GestureDetector(
                  onTap: ()=>onItemClick!(),
                  child: ItemCartWidget(fullwidth: false,)
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
