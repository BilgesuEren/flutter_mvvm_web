import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mvvm_web/model/get_proposals_by_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../model/get_order_list_model.dart';
import 'big_card /big_card.dart';

class BoolNotifier extends StateNotifier<bool> {
  BoolNotifier() : super(false);

  void toggle() {
    state = !state;
  }
}

final boolProvider =
    StateNotifierProvider<BoolNotifier, bool>((ref) => BoolNotifier());

final indexProvider = StateProvider<int>((ref) => 0);
const String pendingSvg = 'assets/pending2.svg';
const String newMessage = 'assets/newMessage.svg';
const String exportNotes = 'assets/exportNotes.svg';
final Widget newMessageSvg = SvgPicture.asset(
  newMessage,
  semanticsLabel: 'Acme Logo',
  width: 30.0,
  height: 35.0,
);

class SmallCard2 extends ConsumerWidget {
  final int index;
  final String id;
  final String orderStatus;
  final String demandNo;
  final String orderDate;
  final String deliveryDate;
  final String paymentDueDate;
  final String paymentType;
  final List<ProductProposal> products;
  const SmallCard2({
    Key? key,
    required this.index,
    required this.id,
    required this.orderStatus,
    required this.demandNo,
    required this.orderDate,
    required this.paymentDueDate,
    required this.paymentType,
    required this.deliveryDate,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<String, String> statusMap = {
      'pending': FlutterI18n.translate(context, "tr.proposal.pending"),
      'replied': FlutterI18n.translate(context, "tr.proposal.replied"),
      'proposal_stvs':
          FlutterI18n.translate(context, "tr.proposal.proposal_stvs"),
    };
    Map<String, String> statusIconMap = {
      'pending': pendingSvg,
      'replied': exportNotes,
      'proposal_stvs': exportNotes
    };
    final DateTime orderDateTime = DateTime.parse(orderDate);
    final Duration remaining = orderDateTime.difference(DateTime.now());

    final CountdownController _controller =
        new CountdownController(autoStart: true);

    return Padding(
      padding: const EdgeInsets.only(right: 15, bottom: 15),
      child: Card(
          elevation: 0,
          color: Theme.of(context).colorScheme.surfaceVariant,
          child: InkWell(
            onTap: () {
              // showDialog(
              //   context: context,
              //   builder: ( BuildContext context) => Dialog(
              //     child: BigCard(
              //       id: id,
              //       status: orderStatus,
              //       demandName: demandName,
              //       date: orderDate,
              //       paymentType: paymentType,
              //       demandNo: demandNo,
              //       deliveryDate: deliveryDate,
              //       paymentDueDate: paymentDueDate,
              //       products: products
              //     ),
              //   ),
              // );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 15, left: 20, bottom: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: SvgPicture.asset(
                                statusIconMap[orderStatus] ?? '',
                                semanticsLabel: 'Order Status Icon',
                                width: 30.0,
                                height: 30.0,
                              ),
                            ),
                            Expanded(
                                flex: 15,
                                child: AutoSizeText(
                                  statusMap[orderStatus] ?? '',
                                  style:
                                      Theme.of(context).textTheme.titleLarge!,
                                )),
                            Flexible(child: newMessageSvg),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                child: Text(FlutterI18n.translate(
                                        context, "tr.proposal.no") +
                                    demandNo)),
                            Flexible(
                              child: Countdown(
                                controller: _controller,
                                seconds: remaining.inSeconds,
                                build: (_, double time) {
                                  int timeInt = time.toInt();
                                  final int days = timeInt ~/ (24 * 3600);
                                  timeInt = timeInt % (24 * 3600);
                                  final int hours = timeInt ~/ 3600;
                                  timeInt %= 3600;
                                  final int minutes = timeInt ~/ 60;
                                  final int seconds = timeInt % 60;

                                  return Text(
                                      "$days G $hours:$minutes:$seconds");
                                },
                                interval: Duration(seconds: 1),
                                onFinished: () {
                                  print('Zaman doldu!');
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        bottom: 8.0, top: 8.0, left: 16.0),
                    child: Text('Acil teklif istegi')),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text('#'),
                            ),
                            Expanded(
                              flex: 2,
                              child: AutoSizeText(
                                FlutterI18n.translate(
                                    context, "tr.proposal.product"),
                                textDirection: TextDirection.ltr,
                                maxLines: 1,
                              ),
                            ),
                            const Spacer(
                              flex: 6,
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Spacer(
                            flex: 6,
                          ),
                          Expanded(
                            flex: 9,
                            child: Text(FlutterI18n.translate(
                                context, "tr.proposal.amount")),
                          ),
                          const Spacer(
                            flex: 3,
                          ),
                          Flexible(
                              flex: 4,
                              child: AutoSizeText(
                                  FlutterI18n.translate(
                                      context, "tr.proposal.price"),
                                  textDirection: TextDirection.ltr,
                                  maxLines: 1)),
                          const Spacer(
                            flex: 4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                for (int i = 0; i < products.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 16.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: AutoSizeText((i + 1).toString(),
                                      textDirection: TextDirection.ltr,
                                      maxLines: 1),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: AutoSizeText(
                                      products[i].productName.toString(),
                                      textDirection: TextDirection.ltr,
                                      maxLines: 1),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5, right: 7),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Spacer(
                                  flex: 1,
                                ),
                                Expanded(
                                  flex: 6,
                                  child: AutoSizeText(
                                      products[i].amount.toString() + ' adet',
                                      textDirection: TextDirection.ltr,
                                      maxLines: 1),
                                ),
                                const Spacer(
                                  flex: 2,
                                ),
                                Expanded(
                                    flex: 3,
                                    child: AutoSizeText(
                                        products[i].price.toString() + ' ₺',
                                        textDirection: TextDirection.ltr,
                                        maxLines: 1)),
                                const Spacer(
                                  flex: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          )),
    );
  }
}

FutureOr<void> _dialogBuilder(BuildContext context, id, status, demandName,
    date, paymentType, demandNo, deliveryDate, paymentDueDate, products) async {
  debugPrint('Before calling showDialog');
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            child: BigCard(
                id: id,
                status: status,
                demandName: demandName,
                date: date,
                paymentType: paymentType,
                demandNo: demandNo,
                deliveryDate: deliveryDate,
                paymentDueDate: paymentDueDate,
                products: products));
      });
  debugPrint('------context---------$context');
  debugPrint('------after---------$Dialog');
}
