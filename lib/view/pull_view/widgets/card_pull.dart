import 'package:flutter/material.dart';
import 'package:ios_challenge/model/entitys/pull.dart';

class CardPull extends StatelessWidget {
  Pull pull;
  CardPull({Key? key, required this.pull}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        tilePadding: EdgeInsets.all(20),
        textColor: Colors.black,
        iconColor: Colors.black,
        backgroundColor: Colors.white,
        leading: Image.asset(
          "images/pull.png",
          width: 20,
          height: 20,
        ),
        title: Row(children: [
          Expanded(
              child: Text(
            pull.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          SizedBox(
            width: 10,
          ),
          Text(
            labelLastUpdate,
            maxLines: 1,
          ),
        ]),
        children: [
          Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade200,
              ),
              child: Text(pull.body))
        ],
      ),
    );
  }

  /*
  método responsável por obter a última atualização,
  de maneira formatada.
  */
  String get labelLastUpdate {
    int difference = DateTime.now().difference(pull.createdAt).inMinutes;

    if (difference < 60) {
      return "${difference}m";
    } else if (difference < 1440) {
      return "${(difference / 60).toStringAsFixed(0)}h";
    } else {
      return "${(difference / 1440).toStringAsFixed(0)}d";
    }
  }
}
