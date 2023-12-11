import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget{
  const DropdownWidget ({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          DropdownSearch<String>(
            // key: Mode.values,
            onChanged: (value) => print(value),
            onSaved: (text) async{
              var http;
              var response= await http.get(Uri.parse("http://192.168.100.206/tokool/cari_prov.php"));
              List allProvince = (json.decode(response.body) as Map<String, dynamic>)["data"];
              List<String> allNameProvince=[];
              allProvince.forEach((element) {
                allNameProvince.add(element["cPropinsi"]);
              });
              // return allNameProvince;
            },
          )
        ],
      )
    );
  }
}