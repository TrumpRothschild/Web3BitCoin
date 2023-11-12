import 'package:countup/countup.dart';
import 'package:flutter/material.dart';

class GridViewWidget extends StatefulWidget {
  GridViewWidget({Key? key}) : super(key: key);

  @override
  State<GridViewWidget> createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<GridViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      margin: EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          )),
      child: GridView(
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 90,
          childAspectRatio: 1 / 2,
        ),
        children: [
          getGrid(),
          getGrid(),
          getGrid(),
          getGrid(),
          getGrid(),
          getGrid(),
          getGrid(),
        ],
      ),
    );
  }

  Widget getGrid() {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 16,
      ),
      //  color: Colors.black54,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: ClipRect(
              child: SizedBox.fromSize(
                size: Size.fromRadius(12), // Image radius
                child: Image.asset('assets/images/totaldeal.png',
                    fit: BoxFit.contain),
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Deal',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                    fontWeight: FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Countup(
                    begin: 184.45,
                    end: 1860411.64,
                    prefix: '\$ ',
                    duration: Duration(milliseconds: 1500),
                    separator: ',',
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
