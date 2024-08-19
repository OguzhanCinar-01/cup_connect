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
    return DropdownButton<String>(
      elevation: 16,
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
        }
        print(syrupProvider.selectedSyrup);
      },
    );
  }
}
