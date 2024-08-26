import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/views/product/viewmodel/product_view_model.dart';
import 'package:coffee_shop/views/product/viewmodel/syrup_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SyrupDropdown extends StatelessWidget {
  SyrupDropdown({super.key});
  final List<String> syrups = [
    'None',
    'Vanilla',
    'Caramel',
    'Hazelnut',
  ];

  @override
  Widget build(BuildContext context) {
    final syrupProvider = Provider.of<SyrupModel>(context);
    final productProvider = Provider.of<ProductViewModel>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: MediaQuery.of(context).size.height * 0.04,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary),
        color: AppColors.surface,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          elevation: 8,
          isExpanded: false,
          underline: Container(
            height: 2,
            color: Colors.black,
          ),
          value: syrupProvider.selectedSyrup,
          items: syrups.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newSyrup) {
            if (newSyrup != null) {
              syrupProvider.selectSyrup(newSyrup);
              productProvider.updateProductSyrup(newSyrup);
            }
          },
        ),
      ),
    );
  }
}
