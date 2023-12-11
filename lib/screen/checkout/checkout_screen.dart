import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/constant/decoration_constant.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/screen/checkout/sukses_checkout_scree.dart';
import 'package:koperasimobile/screen/pengiriman/list_pengiriman_screen.dart';
import 'package:koperasimobile/widget/appbar_widget.dart';
import 'package:koperasimobile/widget/checkout/alamat_widget.dart';
import 'package:koperasimobile/widget/checkout/item_cart_checkout.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(title: 'Checkout'),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //address
              SizedBox(height: 10),
              AlamatWidget(),
              //sku
              Text('Produk', style: TextConstant.medium.copyWith(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w700),),
              SizedBox(height: 20),
              Column(
                children: [
                  ItemCartCheckoutWidget()
                ],
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: ()=>Get.to(()=>ListPengiriman()),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text('Pilih Pengiriman', style: TextConstant.medium.copyWith(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w700)),
                    Expanded(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('JNE', style: TextConstant.regular,),
                            Icon(Icons.chevron_right_rounded, color: Colors.green,)
                          ],
                        ),
                      ),
                    )

                    // Text('>', style: TextConstant.medium.copyWith(color: Colors.green, fontSize: 16, fontWeight: FontWeight.w700),),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text('Ringkasan Belanja', style: TextConstant.medium.copyWith(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w700),),
              SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Harga (1 barang)', style: TextConstant.medium.copyWith(color: Colors.black87, fontSize: 13),),
                      Text('Rp 1.000.000', style: TextConstant.medium.copyWith(color: Colors.black87, fontSize: 13),),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Hemat barang', style: TextConstant.medium.copyWith(color: Colors.black87, fontSize: 13),),
                      Text('Rp 0', style: TextConstant.medium.copyWith(color: Colors.black87, fontSize: 13),),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Ongkos Kirim', style: TextConstant.medium.copyWith(color: Colors.black87, fontSize: 13),),
                      Text('Rp 0', style: TextConstant.medium.copyWith(color: Colors.black87, fontSize: 13),),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Wrap(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Bayar', style: TextConstant.medium.copyWith(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w600),),
                    SizedBox(height: 5),
                    Text('Rp 1.000.000', style: TextConstant.medium.copyWith(color: Colors.black87, fontSize: 13),),
                  ],
                ),
                Container(
                  width: size.width * 0.27,
                  child: buttonBayar(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  buttonBayar(){
    return GestureDetector(
      onTap: ()=>Get.to(()=>SuksesCheckout()),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 12),
        decoration: DecorationConstant.boxButton(radius: 8, color: Colors.green),
        child: Center(
          child: Text('Bayar', style: TextConstant.regular.copyWith(fontSize: 12, color: Colors.white)),
        ),
      ),
    );
  }
}
