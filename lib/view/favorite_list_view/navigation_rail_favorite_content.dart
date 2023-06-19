import 'package:flutter/material.dart';

import 'favorite_list.dart';


class navigationRailFavoriteContent extends StatelessWidget {
  const navigationRailFavoriteContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 400),
      width: MediaQuery.of(context).size.width * 0.25,
      child: ListView.builder(
        itemCount: 25,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return favoriteList();
                    },
                  );
                },
                child: Column(
                  children: const [
                    ListTile(
                      title: Text('One-line ListTile'),
                    ),
                  ],
                ),
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}
