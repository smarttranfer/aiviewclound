import 'package:adobe_xd/pinned.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ConfirmCodeWidget extends StatelessWidget {
  const ConfirmCodeWidget({Key? key}) : super(key: key);

  onNextFocus(text, node) {
    if (text.length > 0) {
      node.nextFocus();
    } else {
      node.previousFocus();
    }
  }

  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Stack(children: [
      Pinned.fromPins(
        Pin(size: 38.0, start: 0.0),
        Pin(size: 36.0, start: 0.0),
        child:
            // Adobe XD layer: 'Rectangle 1829' (shape)
            Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: const Color(0xff2b2f33),
          ),
          child: TextField(
            maxLength: 1,
            autofocus: true,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
            onChanged: (text) {
              onNextFocus(text, node);
            },
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: const Color(0xfffd7b38), width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                counterText: '',
                contentPadding: EdgeInsets.only(
                  bottom: 15, // HERE THE IMPORTANT PART
                )),
          ),
        ),
      ),
      Pinned.fromPins(
        Pin(size: 38.0, middle: 0.2),
        Pin(size: 36.0, start: 0.0),
        child:
            // Adobe XD layer: 'Rectangle 1824' (shape)
            Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: const Color(0xff2b2f33),
          ),
          child: TextField(
            maxLength: 1,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
            onChanged: (text) {
              onNextFocus(text, node);
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: const Color(0xfffd7b38), width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                counterText: '',
                contentPadding: EdgeInsets.only(
                  bottom: 15, // HERE THE IMPORTANT PART
                )),
          ),
        ),
      ),
      Pinned.fromPins(
        Pin(size: 38.0, middle: 0.4),
        Pin(size: 36.0, start: 0.0),
        child:
            // Adobe XD layer: 'Rectangle 1825' (shape)
            Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: const Color(0xff2b2f33),
          ),
          child: TextField(
            maxLength: 1,
            textAlign: TextAlign.center,
            onChanged: (text) {
              onNextFocus(text, node);
            },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: const Color(0xfffd7b38), width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                counterText: '',
                contentPadding: EdgeInsets.only(
                  bottom: 15, // HERE THE IMPORTANT PART
                )),
          ),
        ),
      ),
      Pinned.fromPins(
        Pin(size: 38.0, middle: 0.6),
        Pin(size: 36.0, start: 0.0),
        child:
            // Adobe XD layer: 'Rectangle 1826' (shape)
            Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: const Color(0xff2b2f33),
          ),
          child: TextField(
            maxLength: 1,
            textAlign: TextAlign.center,
            onChanged: (text) {
              onNextFocus(text, node);
            },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: const Color(0xfffd7b38), width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                counterText: '',
                contentPadding: EdgeInsets.only(
                  bottom: 15, // HERE THE IMPORTANT PART
                )),
          ),
        ),
      ),
      Pinned.fromPins(
        Pin(size: 38.0, middle: 0.8),
        Pin(size: 36.0, start: 0.0),
        child:

            // Adobe XD layer: 'Rectangle 1827' (shape)
            Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: const Color(0xff2b2f33),
          ),
          child: TextField(
            maxLength: 1,
            textAlign: TextAlign.center,
            onChanged: (text) {
              onNextFocus(text, node);
            },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: const Color(0xfffd7b38), width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                counterText: '',
                contentPadding: EdgeInsets.only(
                  bottom: 15, // HERE THE IMPORTANT PART
                )),
          ),
        ),
      ),
      Pinned.fromPins(
        Pin(size: 38.0, end: 0.0),
        Pin(size: 36.0, start: 0.0),
        child:
            // Adobe XD layer: 'Rectangle 1828' (shape)
            Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: const Color(0xff2b2f33),
          ),
          child: TextField(
            maxLength: 1,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
            onChanged: (text) {
              if (text.length == 0) {
                node.previousFocus();
              }
            },
            decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: const Color(0xfffd7b38), width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                counterText: '',
                contentPadding: EdgeInsets.only(
                  bottom: 15, // HERE THE IMPORTANT PART
                )),
          ),
        ),
      )
    ]);
  }
}
