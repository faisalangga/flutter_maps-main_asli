import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/constant/decoration_constant.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/controller/produk/product_controller.dart';
import 'package:koperasimobile/model/sku/model_sku.dart';
import 'package:koperasimobile/screen/checkout/checkout_screen.dart';
import 'package:koperasimobile/widget/appbar_widget.dart';

class DetailProductScreen extends StatefulWidget {
  const DetailProductScreen({Key? key}) : super(key: key);

  @override
  State<DetailProductScreen> createState() => _DetailProductScreenState();
}

class _DetailProductScreenState extends State<DetailProductScreen> {

  ProductController controller = Get.put(ProductController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.loadCart();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(title: 'Adidas Forum Low CL'),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: 'https://assets.adidas.com/images/w_600,f_auto,q_auto/dd5856ece5894f9987e9ae890026a723_9366/Forum_Low_CL_Shoes_White_HQ6874_01_standard.jpg',
                imageBuilder: (context, imageProvider) => Container(
                  width: double.infinity,
                  height: size.height * 0.35,
                  decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text('Adidas Forum Low CL', style: TextConstant.medium.copyWith(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w500),),
                    SizedBox(height: 5),
                    Text('Rp 1.000.000', style: TextConstant.medium.copyWith(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w500),),
                    SizedBox(height: 25),
                    Text('Keterangan Produk', style: TextConstant.medium.copyWith(color: Colors.black87, fontSize: 15, fontWeight: FontWeight.w500),),
                    SizedBox(height: 5),
                    Text('ini merupakan keterangan produk', style: TextConstant.medium.copyWith(color: Colors.black87,),),

                  ],
                ),
              )

            ],
          ),
        ),
      ),
      bottomNavigationBar: Wrap(
        children: [
          Obx(()=>Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(child: Container(
                  child: Stack(children: [
                    Icon(CupertinoIcons.cart, size: 30,),
                    controller.dataCart.value.length > 0 ? Positioned(
                      left: 20,
                      child: Container(
                        height: 13, width: 13,
                        decoration: DecorationConstant.boxCircle(color: Colors.redAccent),
                      ),
                    ):SizedBox()
                  ]),
                )),
                // SizedBox(width: size.width * 0.15),
                Container(
                  width: size.width * 0.27,
                  child: buttonBuy(),
                ),
                SizedBox(width: 10),
                Container(
                  width: size.width * 0.35,
                  child: buttonCart(),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }

  buttonBuy(){
    return GestureDetector(
      onTap: ()=>Get.to(()=>CheckOutScreen()),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 12),
        decoration: DecorationConstant.boxButton(radius: 8, color: Colors.green),
        child: Center(
          child: Text('Beli Sekarang', style: TextConstant.regular.copyWith(fontSize: 12, color: Colors.white)),
        ),
      ),
    );
  }

  buttonCart(){
    return GestureDetector(
      onTap: () async {
        ModelSKU model = ModelSKU();
        model.id=1;
        model.sku_name = ' Adidas Forum Low CL';
        model.detail = 'test';
        model.category_id = 1;
        model.dicount = 0;
        model.price = 1000000;
        model.qty = 1;
        controller.saveToCart(model);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 12),
        decoration: DecorationConstant.boxButtonBorder(radius: 8, color: Colors.white, colorBorder: Colors.green, widthBorder: 1),
        child: Center(
          child: Text('Masukkan ke Keranjang', style: TextConstant.regular.copyWith(fontSize: 12, color: Colors.green)),
        ),
      ),
    );
  }
}
