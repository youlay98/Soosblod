import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Skaltone extends StatelessWidget {
  const Skaltone({super.key});

  @override
  Widget build(BuildContext context) {
    double widthsize = MediaQuery.of(context).size.width;
    double heightsize = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.01),
                  offset: const Offset(0.0, 4.0), //(x,y)
                  blurRadius: 12,
                ),
              ],
              color: Colors.black.withOpacity(0.02),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          height: heightsize / 10,
          child: Row(
            children: [
              const Spacer(
                flex: 1,
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  width: widthsize / 8,
                  height: widthsize / 8,
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      width: widthsize / 2,
                      height: widthsize / 20,
                    ),
                  ),
                  SizedBox(
                    height: heightsize * 0.01,
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      width: widthsize / 3,
                      height: widthsize / 20,
                    ),
                  ),
                ],
              ),
              const Spacer(
                flex: 8,
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
