import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';



const String pendingSvg = 'assets/pending2.svg';
const String orderApprovedSvg = 'assets/exportNotes.svg';
const String orderConfirmedSvg = 'assets/conveyor.svg';
const String orderPrepared = 'assets/trolley.svg';
const String orderOnTheWay = 'assets/shipment.svg';
const String orderDelivered = 'assets/warehouse.svg';
const String newMessage = 'assets/newMessage.svg';
const String exportNotes = 'assets/exportNotes.svg';

class Header extends ConsumerWidget {
  final String id;
  final String status;

  const Header({
    Key? key,
    required this.id,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const surfaceDim = Color(0xFFD8DBD8);
    // same method in small_card. refactor later
     Map<String, String> orderStatusMap = {
      'pending': FlutterI18n.translate(context, "tr.order.pending"),
      'order_approved': FlutterI18n.translate(context, "tr.order.order_approved"),
      'order_confirmed': FlutterI18n.translate(context, "tr.order.order_confirmed"),
      'order_prepared' : FlutterI18n.translate(context, "tr.order.order_prepared"),
      'order_on_the_way' : FlutterI18n.translate(context, "tr.order.order_on_the_way"),
      'order_delivered' : FlutterI18n.translate(context, "tr.order.order_delivered"),
    };

    Map<String, String> statusIconMap = {
      'pending': pendingSvg,
      'order_approved': orderApprovedSvg,
      'order_confirmed': orderConfirmedSvg,
      'order_prepared': orderPrepared,
      'order_on_the_way': orderOnTheWay,
      'order_delivered': orderDelivered
    };
    return Container(
      color: surfaceDim,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: ListTile(
              title: Text(orderStatusMap[status] ?? '',
              style: Theme.of(context).textTheme.titleLarge),
              subtitle: Text("${FlutterI18n.translate(context, "tr.order.order_no")}:  $id", style: Theme.of(context).textTheme.titleMedium),
              leading: SvgPicture.asset(
                statusIconMap[status] ?? '',
                semanticsLabel: 'Order Status Icon',
                width: 30.0,
                height: 30.0,
              ),
            ),
          ),
          Flexible(
            child: IconButton(
              onPressed: () {
                Navigator.pop(context); // close the big card
              },
              alignment: Alignment.topRight,
              padding: const EdgeInsets.only(top: 0.0, right: 8.0, bottom: 0.0, left: 8.0),
              iconSize: 36.0,
              icon: Icon(
                Icons.close,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                // opticalSize: 36,
              ),
            ),
          ),
        ],
      ),
    );
  }
}