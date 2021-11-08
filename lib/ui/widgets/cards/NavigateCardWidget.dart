import 'package:clean/core/AppTheme.dart';
import 'package:clean/model/job/Address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maps_launcher/maps_launcher.dart';

class NavigateCardWidget extends StatelessWidget {
  final Address address;
  const NavigateCardWidget(this.address);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: address.coordinates != null ? (){
          MapsLauncher.launchCoordinates(
              address.coordinates!.lat, address.coordinates!.long);
        } : null,
        child: Container(
          height: kCardHeight,
          decoration: kCardBoxDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/icon_navigate.svg'),
              SizedBox(height: 2),
              Text(
                'Navigovat',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11, height: 1.36, color: kColorBlue),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}