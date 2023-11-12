import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bourse/Models/HomeModel/recommend_model.dart';
import 'package:flutter_bourse/Models/ProductIntroductionModel.dart';
import 'package:flutter_bourse/helpers/UserSharedPreferences.dart';
import 'package:flutter_bourse/http/apis.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:http/http.dart' as http;

class ProductDetailsView extends StatefulWidget {
  final RecommendRows? recommendModel;
  const ProductDetailsView({Key? key,this.recommendModel}) : super(key: key);

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {

  ProductIntroductionModel? recommendModel;
  // var htmlData = widget.recommendModel!.content!;
  var productDataList =  <ProductIntroductData?>[] ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    detailApi();
    LogUtil.e("详情 ${widget.recommendModel!.content!}");
  }
  void detailApi() async {
    productDataList.clear();
    Uri tokenurl = Uri.parse('${APIs.apiPrefix}/web/precommend/${widget.recommendModel!.recommendId}');
    final res = await http.get(tokenurl,
        headers: {
          "Content-Type": "application/json",
          "lang":UserSharedPreferences.getPrivateLang().toString(),
    });
    // var tokenData = jsonDecode(res.body);
    final Map<String, dynamic> jsonResult = jsonDecode(res.body);
    if (jsonResult['code'] == 200) {
      recommendModel = ProductIntroductionModel.fromJson(jsonResult);
      LogUtil.e('产品数据 $jsonResult');
      productDataList.add(recommendModel!.data!);
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        // height: 530,
        color: Colors.white,
        child: (productDataList.isNotEmpty) ? Html(
          data:  recommendModel!.data!.content.toString(),
          //Optional parameters:
          style: {
            "html": Style(
              backgroundColor: Colors.white,
//              color: Colors.white,
            ),
//            "h1": Style(
//              textAlign: TextAlign.center,
//            ),
            "table": Style(
              backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
            ),
            "tr": Style(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            "th": Style(
              padding: EdgeInsets.all(6),
              backgroundColor: Colors.grey,
            ),
            "td": Style(
              padding: EdgeInsets.all(6),
            ),
            "var": Style(fontFamily: 'serif'),
          },
          customRender: {
            // "flutter": (RenderContext context, Widget child, attributes, _) {
            //   return FlutterLogo(
            //     style: (attributes['horizontal'] != null)
            //         ? FlutterLogoStyle.horizontal
            //         : FlutterLogoStyle.markOnly,
            //     textColor: context.style.color,
            //     size: context.style.fontSize.size * 5,
            //   );
            // },
          },

          onImageError: (exception, stackTrace) {
            print(exception);
          },
        ) : Container(),
      ),
    );
  }
}
