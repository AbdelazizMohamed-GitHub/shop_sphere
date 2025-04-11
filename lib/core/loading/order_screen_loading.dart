import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OrderScreenLoading extends StatelessWidget {
  const OrderScreenLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shrinkWrap: true,
        itemCount: 5,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return Container(
              padding: const EdgeInsets.all(10),
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                children: [
                  Row(children: [
                    Text(
                      'Order # 19470',
                    ),
                    Spacer(),
                    Text(
                      'Date: 2023-10-01',
                     
                    ),
                  ]),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        'Tracking Number:',
                      
                      ),
                      Spacer(),
                      Text(
                        'Status: ',
                       
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        'Quantity: ',
                       
                      ),
                      Spacer(),
                      Text(
                        'Total: ',
                       
                      ),
                    ],
                  )
                ],
              ));
        },
      ),
    );
  }
}
