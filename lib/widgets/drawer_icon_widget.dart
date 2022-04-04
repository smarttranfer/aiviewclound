import 'package:adobe_xd/pinned.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DrawerIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 48,
        height: 48,
        alignment: Alignment.topRight,
        color: Colors.transparent,
        // margin: EdgeInsets.only(top: 30),
        child: Pinned.fromPins(
          Pin(size: 20.0, start: 16.0),
          Pin(size: 12.0, middle: 0.5),
          child:
              // Adobe XD layer: 'Group 6420' (group)
              Stack(
            children: <Widget>[
              Pinned.fromPins(
                Pin(size: 13.3, start: 0.0),
                Pin(size: 1.6, start: 0.0),
                child:
                    // Adobe XD layer: 'Rectangle 1988' (shape)
                    Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                  ),
                ),
              ),
              Pinned.fromPins(
                Pin(start: 0.0, end: 0.0),
                Pin(size: 1.6, middle: 0.5),
                child:
                    // Adobe XD layer: 'Rectangle 1989' (shape)
                    Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                  ),
                ),
              ),
              Pinned.fromPins(
                Pin(size: 13.3, start: 0.0),
                Pin(size: 1.6, end: 0.0),
                child:
                    // Adobe XD layer: 'Rectangle 1990' (shape)
                    Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
