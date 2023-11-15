import 'package:flutter/material.dart';
import '../colors/color.dart';

class LoadingPage extends StatelessWidget {
  final statusLoading;
  LoadingPage({required this.statusLoading});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Visibility(
      visible: statusLoading == true ? true : false,
      child: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              width: size.width,
              height: size.height,
              color: Colors.white10,
            ),
            Positioned(
              child: Container(
                width: size.width * 0.25,
                height: size.height * 0.12,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                    child: CircularProgressIndicator(color: primaryColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
