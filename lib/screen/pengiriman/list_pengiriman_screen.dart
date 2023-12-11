import 'package:flutter/material.dart';
import 'package:koperasimobile/widget/appbar_widget.dart';
import 'package:koperasimobile/widget/pengiriman/pengiriman_item.dart';

class ListPengiriman extends StatelessWidget {
  const ListPengiriman({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'List Pengiriman'),
      body: Container(
        child: ListView.builder(
          itemCount: 2,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          itemBuilder: (context, index){
            return PengirimanItem();
          },
        ),
      ),
    );
  }
}
