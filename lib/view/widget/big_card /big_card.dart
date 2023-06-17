import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'product_table.dart';

import '../../../model/get_order_list_model.dart';
import 'header.dart';
import 'info.dart';

class BigCard extends ConsumerWidget {
  final String id; //header_no
  final String className;
  final String status;
  final String topic; //body_header
  final String date; //header_date info_1
  final String paymentType; //info_2 (column1)
  final String demandNo; //info_3 (column1)
  final String deliveryDate; //info_1 (column2)
  final String paymentDueDate; //info_2 (column2)
  final List tableList; //body_table

  const BigCard({
    Key? key,
    required this.id,
    required this.className,
    required this.status,
    required this.topic,
    required this.date,
    required this.paymentType,
    required this.demandNo,
    required this.deliveryDate,
    required this.paymentDueDate,
    required this.tableList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    const surfaceDim = Color(0xFFD8DBD8);
    final DateTime parsedDate = DateTime.parse(date);
    // final DateTime parsedDeliveryDate = DateTime.parse(deliveryDate ?? '43.45.456778');
    //formating dateTime object
    String formattedDate =
        "${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}";
    // String formattedDeliveryDate =
    //   "${parsedDate.year}-${parsedDeliveryDate.month.toString().padLeft(2, '0')}-${parsedDeliveryDate.day.toString().padLeft(2, '0')}";
    return Card(
      elevation: 3,
      color: surfaceDim,
      child: Container(
        // color: Theme.of(context).colorScheme.surfaceVariant,
        width: width * 0.7,
        height: height * 0.8,
        constraints: BoxConstraints.tightFor(width: width * 0.7, height: height * 0.8),
        child: Column(
          children: [
            Header(id: id, status: status),  // header sonu
            Expanded(
              flex: 10,                    //body
              child: Row(
                children: [
                  SizedBox(        // left-side
                    width: width * 0.7 * 0.7,
                    height: height * 0.7,
                    child: Column(  
                      crossAxisAlignment: CrossAxisAlignment.start,         
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 60.0),
                          child: Info(
                            demandName: topic,
                            orderDate: formattedDate,
                            paymentType: paymentType,
                            demandNo: demandNo,
                            deliveryDate: deliveryDate,
                            paymentDueDate: paymentDueDate,                        
                          ),
                        ),  //info
        
                        Flexible(
                          flex: 4,
                          fit: FlexFit.loose,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              alignment: Alignment.topLeft,
                              decoration: const BoxDecoration(
                                borderRadius:  BorderRadius.all(Radius.circular(10)),
                              ),
                              // 
                              child: ProductListTable(productList: tableList),
                            ),
                          ),
                        ),
                        // )
                        Padding(
                          padding: const EdgeInsets.only(left: 16, bottom: 10),
                          child: ElevatedButton(
                            onPressed: () {
                            }, 
                            child: const Text('Teslim Al', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10,top: 10),
                            child: Container(
                              // width: width * 0.7 * 0.7 * 0.6,
                              // height: 390,
                              // constraints: BoxConstraints.tightFor(width: width * 0.7 * 0.7 * 0.6, height: 500),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.all(10),
                              child: Align(
                                alignment: (id == "receiver"?Alignment.topLeft:Alignment.topRight),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: ( topic.isEmpty ? Colors.grey.shade200 :Colors.blue[200]),
                                  ),
                                  padding: EdgeInsets.all(16),
                                  child: Text(topic, style: TextStyle(fontSize: 15),),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10)),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(                            
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              constraints: BoxConstraints.tightFor(width: width * 0.7 * 0.7 * 0.6, height: 30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}