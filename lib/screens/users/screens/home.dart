import 'package:flutter/material.dart';
import 'package:foodie_app/constants/constant.dart';
import 'package:foodie_app/screens/users/screens/category_screen.dart';

class Home extends StatelessWidget {
  Home({super.key});
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    width: 2,
                    color: Colors.black26,
                  ),
                ),
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search_rounded),
                    hintText: "Search ...",
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage("assets/dine.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text("Dine In"),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage("assets/take.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text("Take Away"),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Cuisines",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 80,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cuisines.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(
                          right: 10,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            cuisines[index],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }),
              ),

              //Category
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Categories",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 80,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: category.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CategoryScreen(category: category[index]),
                              ));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            right: 10,
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              category[index],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),

              //Promotions
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Promotions",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 120,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: promotion.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 120,
                        margin: const EdgeInsets.only(
                          right: 10,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(
                              10,
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "${promotion[index]['percentage']}%",
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(promotion[index]['label'].toString()),
                            Text("Code: ${promotion[index]['code']}"),
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
