import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/view/widget/big_card/product_table.dart';

import '../../../model/get_order_list_model.dart';
import 'header.dart';
import 'info.dart';

class BigCard extends ConsumerWidget {
  final String id;
  final String status;
  final String demandName;
  final String date;
  final String paymentType;
  final String demandNo;
  final String deliveryDate;
  final String paymentDueDate;
  final List<Product>  products;

  const BigCard({
    Key? key,
    required this.id,
    required this.status,
    required this.demandName,
    required this.date,
    required this.paymentType,
    required this.demandNo,
    required this.deliveryDate,
    required this.paymentDueDate,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final DateTime parsedDate = DateTime.parse(date);
    // final DateTime parsedDeliveryDate = DateTime.parse(deliveryDate ?? '43.45.456778');
    //formating dateTime object
    String formattedDate =
        "${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}";
    // String formattedDeliveryDate =
    //   "${parsedDate.year}-${parsedDeliveryDate.month.toString().padLeft(2, '0')}-${parsedDeliveryDate.day.toString().padLeft(2, '0')}";
    return Container(
      width: width * 0.9,
      height: height * 0.6,
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Column(
        children: [
          Expanded(  //header
            flex: 2, 
            child: Header(id: id, status: status)
            ),  // header sonu
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
                          demandName: demandName,
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
                            decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onPrimary,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary ,
                              width: 0.1,
                            ),
                            borderRadius:  const BorderRadius.all(Radius.circular(10)),
                            ),
                            // 
                            child: ProductListTable(productList: products),
                          ),
                        ),
                      ),
                      // )
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () {
                          }, 
                          child: const Text('Teslim Al', style: TextStyle(color: Colors.white)),
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
    );
  }
}