
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartAddedItems extends StatelessWidget {
  const CartAddedItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 450,
      padding: const EdgeInsets.only(top: 25),
      child: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            background: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.red,
              ),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
            },
            child: Card(
              color: AppColors.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Latte',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Flavor
                        Text(
                          'Vanilla',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
    
                        /// Size
                        Text(
                          'Medium',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
    
                        /// Price
                        Text(
                          'Price: 10\$',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove, size: 30),
                          onPressed: () {
                            /// Decrease item count
                          },
                        ),
                        const Text('3', style: TextStyle(fontSize: 15)),
                        IconButton(
                          icon: const Icon(Icons.add, size: 30,),
                          onPressed: () {
                            /// Increase item count
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}