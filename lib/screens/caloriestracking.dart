import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:canteeno/models/changeprovider.dart'; // Import the provider

class Caloriestracking extends StatelessWidget {
  Caloriestracking({super.key});

  final TextEditingController searchController = TextEditingController();
  final TextEditingController pageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CaloriesProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search TextField
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            const SizedBox(height: 10),

            // Page TextField and Search Button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: pageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Page',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    final page = int.tryParse(pageController.text) ?? 1;
                    provider.fetchData(searchController.text, page); // Call fetchData in provider
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Display API Results
            if (provider.isLoading)
              const Center(child: CircularProgressIndicator(color: Colors.amber))
            else if (provider.errorMessage != null)
              Center(
                child: Text(
                  'Error: ${provider.errorMessage}',
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.red),
                ),
              )
            else if (provider.items != null && provider.items!.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: provider.items!.length,
                  itemBuilder: (context, index) {
                    final item = provider.items![index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text(
                          item.name ?? 'Unknown Name',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          'Calories: ${item.Calories ?? 'Unknown Calories'}',
                          style: GoogleFonts.poppins(fontSize: 14, color: Colors.black54),
                        ),
                      ),
                    );
                  },
                ),
              )
            else
              Center(
                child: Text(
                  'No data found.',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
