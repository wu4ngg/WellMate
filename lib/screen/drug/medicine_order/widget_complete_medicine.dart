import 'package:flutter/material.dart';

class WidgetCompleteMedicine extends StatefulWidget {
  const WidgetCompleteMedicine({super.key});

  @override
  State<WidgetCompleteMedicine> createState() => _WidgetCompleteMedicine();
}

class _WidgetCompleteMedicine extends State<WidgetCompleteMedicine> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    final sizeWight = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.ac_unit_outlined),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      "Đơn thuốc đang được chuẩn bị bởi nhà thuốc",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 24),
                    ),
                  ),
                )
              ],
            ),
            Container(
              height: sizeHeight * 0.40,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: isChecked,
                                    activeColor: Colors.blue,
                                    onChanged: (value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    },
                                  ),
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                        'https://i.giphy.com/BSx6mzbW1ew7K.webp'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Panadol Extra",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge),
                                        Text("3 vỉ _ 8.000 đ / vỉ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall),
                                        Text("25.000 đ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Icon(Icons.more_horiz)
                            ],
                          ),
                          const Divider(),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const Text("Phương thức thanh toán"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGxsoe7iPccCnGraliGFCLCvbg3bO3PDtELQ&s"),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Visa",
                            style: Theme.of(context).textTheme.titleMedium),
                        Text("******12"),
                      ],
                    )
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz),
                )
              ],
            ),
            Text("Địa chỉ giao hàng"),
            Container(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: sizeWight * 1.9 / 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "100 đường Example, Thành phố Hồ Chí Minh, Việt Nam",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.more_horiz),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}