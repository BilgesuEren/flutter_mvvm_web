import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_mvvm_web/view/widget/small_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../model/get_order_list_model.dart';
import '../../view_model/buyer_invoices_view_model.dart';
import '../../view_model/order_list_view_model.dart';
import '../widget/appbar.dart';
import '../widget/main_page_content.dart';
import '../widget/nav_rail.dart';


class OrderView extends ConsumerWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderListAsyncValue = ref.watch(getOrderListProvider);
    final ato = ref.watch(getInvoicesProvider);

    return orderListAsyncValue.when(
      data: (orderList) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth < 1070) {
              return Scaffold(
                drawer: const Drawer(child: NavigationRailDrawer()),
                appBar: AppbarTop(), //appbar
                body: buildBody(orderList, context, FlutterI18n.translate(context, "tr.order.orders"), "order"),
              );
            } else {
              return Scaffold(
                appBar: AppbarTop(), // appbar
                body: SafeArea(
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 3,
                        child: NavigationRailDrawer(), //drawer
                      ),
                      Expanded(
                        flex: 9,
                        child: buildBody(orderList, context, FlutterI18n.translate(context, "tr.order.orders"), "order"), //order screen body
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, '/login');
        });
        return Text('An error occurred: $error');
      },
    );
  }

  Padding buildBody(List<GetOrderlistModel> orderList, BuildContext context, String topic, String className) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: constraints.maxHeight > 300,
                child: allMainPageContent(
                  topic: topic,
                ),
              ),
              Flexible(
                child: StaggeredGridView.countBuilder(
                  crossAxisCount: getCrossAxisCount(constraints),
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  itemCount: orderList.length,
                  staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                  itemBuilder: (context, index) {
                    return SmallCard(
                      index: index,
                      id: orderList[index].id.toString(),
                      className: className,
                      status: orderList[index].state.toString(),
                      headerDate: orderList[index].orderDate.toString(),
                      bodyHeader: orderList[index].demandName.toString(),
                      paymentType: orderList[index].paymentType.toString(),
                      demandNo: orderList[index].demandNo.toString(),
                      deliveryDate: orderList[index].deliveryDate.toString(),
                      paymentDueDate: orderList[index].paymentDueDate.toString(), 
                      bodyList: orderList[index].products!,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  int getCrossAxisCount(BoxConstraints constraints) {
    if (constraints.maxWidth > 1250) {
      return 3;
    } else if (constraints.maxWidth > 600) {
      return 2;
    } else {
      return 1;
    }
  }
}
