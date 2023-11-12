import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

import '../Pages/colors.dart';

class FaqWidget extends StatefulWidget {
  FaqWidget({Key? key}) : super(key: key);

  @override
  State<FaqWidget> createState() => _FaqWidgetState();
}

class _FaqWidgetState extends State<FaqWidget> {
  final _headerStyle = const TextStyle(
      color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          )),
      child: Column(
        children: [

          faqTile(translate('home.Safe'),
              translate('home.WhenPlatform')),

          faqTile(translate('home.IsBlockchain'),
              translate('home.WeAdopt')),
        ],
      ),
    );
  }

  Widget faqTile(String title, String description) {
    return Accordion(
      disableScrolling: true,
      initialOpeningSequenceDelay: 0,
      maxOpenSections: 2,
      headerBackgroundColorOpened: Colors.black54,
      scaleWhenAnimating: true,
      openAndCloseAnimation: true,
      paddingListTop: 0,

      paddingListBottom: 0,
      //  headerPadding:
      //     const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
      sectionClosingHapticFeedback: SectionHapticFeedback.light,
      children: [
        AccordionSection(
          contentBackgroundColor: Colors.white,
          contentBorderWidth: 0,
          contentBorderColor: Colors.white,
          headerBackgroundColor: Colors.white,
          isOpen: false,
          flipRightIconIfOpen: true,
          rightIcon: Row(
            children: [
              SizedBox(
                width: 4,
              ),
              const Icon(Icons.arrow_drop_down,
                  color: ColorConstants.AppGreyColor),
            ],
          ),
          header: Container(
              margin: EdgeInsets.only(top: 8, right: 4),
              child: Text(title, style: _headerStyle)),
          content: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  description,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
