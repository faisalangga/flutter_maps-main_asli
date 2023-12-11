import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koperasimobile/constant/decoration_constant.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/widget/cart/item_cart_widget.dart';

class SearchProductScreen extends StatelessWidget {
  const SearchProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: DecorationConstant.boxButton(radius: 8, color: Colors.white),
          height: 38,
          width: double.infinity,
          alignment: Alignment.centerLeft,
          // padding: EdgeInsets.symmetric(horizontal: 8),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(CupertinoIcons.search, color: Colors.grey.shade300, size: 20,),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 5),
              hintText: 'Ketik barang yang kamu cari...',
              hintStyle: TextConstant.regular.copyWith(fontSize: 12)
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 5
            ),
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return ItemCartWidget(fullwidth: true);
            }
        ),
      ),
    );
  }
}
