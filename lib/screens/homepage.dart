import 'package:canteeno/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:canteeno/datasets/cart.dart';
import 'package:provider/provider.dart';
import 'package:canteeno/models/adding_removing.dart';
import 'package:canteeno/segments/slideup_cart.dart';

class SnackOrderScreen extends StatelessWidget {
  const SnackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AddingRemoving addremove =
        Provider.of<AddingRemoving>(context, listen: false);

    dynamic count = addremove.count;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 100,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const profilescreen(),
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  shape: BoxShape.circle,
                ),
                height: 50,
                width: 50,
                child: Icon(Icons.person),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order From The Best Of",
              style: GoogleFonts.poppins(fontSize: 24, color: Colors.black),
            ),
            Text(
              "Food",
              style: GoogleFonts.poppins(
                  fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Categories List
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CategoryChip(label: "All", isSelected: true),
                  CategoryChip(label: "Thai"),
                  CategoryChip(label: "snacks"),
                  CategoryChip(label: "Beverages"),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Choco Collections",
              style: GoogleFonts.poppins(fontSize: 20),
            ),
            const SizedBox(height: 16),
            // Snack Items Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount:
                    dummyMenuItems.length, // Replace with the number of items
                itemBuilder: (context, index) {
                  int quantity = 0; // Initial quantity for each item

                  return StatefulBuilder(
                    builder: (context, setState) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      dummyMenuItems[index].imageUrl,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dummyMenuItems[index].name,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    dummyMenuItems[index].description,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "\$${dummyMenuItems[index].price.toString()}",
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.remove),
                                            onPressed: quantity > 0
                                                ? () {
                                                    setState(() {
                                                      quantity--;
                                                    });
                                                  }
                                                : null,
                                          ),
                                          Text(
                                            quantity.toString(),
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.add),
                                            onPressed: () {
                                              setState(() {
                                                quantity++;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  // Add to Cart Button
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.orange,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      onPressed: quantity > 0
                                          ? () {
                                              addremove.Add(
                                                dummyMenuItems[index].name,
                                                dummyMenuItems[index]
                                                    .price
                                                    .toString(),
                                                quantity.toString(),
                                              );
                                              // Reset quantity after adding to cart if desired
                                              setState(() {
                                                quantity = 0;
                                              });
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    "${dummyMenuItems[index].name} added to cart",
                                                  ),
                                                ),
                                              );
                                            }
                                          : null,
                                      child: Text(
                                        "Add to Cart",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60, // Adjust this value as needed
        child: BottomAppBar(
          color: Colors.orange[500],
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 0), // Adjust padding if needed
            child: Row(
              children: [
                StreamBuilder<int>(
                  stream: addremove.cartItemCount,
                  builder: (context, snapshot) {
                    int count = snapshot.data ?? 0;
                    return CircleAvatar(
                      backgroundColor: Colors.orange[100],
                      child: Text(
                        count.toString(),
                        style: GoogleFonts.poppins(color: Colors.black),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 16),
                Text(
                  'Items in cart',
                  style: GoogleFonts.poppins(fontSize: 18),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_up,
                    size: 25,
                  ),
                  onPressed: () {
                    // addremove.fetchAllDocuments();
                    showCartBottomSheet(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const CategoryChip({super.key, required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        label: Text(
          label,
          style: GoogleFonts.poppins(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: isSelected ? Colors.black : Colors.grey[200],
      ),
    );
  }
}

// class SnackItemCard extends StatefulWidget {
//   @override
//   State<SnackItemCard> createState() => _SnackItemCardState();
// }

// class _SnackItemCardState extends State<SnackItemCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.orange[100],
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 image: DecorationImage(
//                   image: AssetImage(
//                       'assets/snack.png'), // Replace with your image path
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Good Source",
//                   style: GoogleFonts.poppins(
//                       fontSize: 16, fontWeight: FontWeight.w600),
//                 ),
//                 Text(
//                   "Chocolates",
//                   style:
//                       GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
//                 ),
//                 SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "\$08.00",
//                       style: GoogleFonts.poppins(
//                           fontSize: 16, fontWeight: FontWeight.bold),
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.add),
//                       onPressed: () {},
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
