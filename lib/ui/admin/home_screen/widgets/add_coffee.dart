import 'package:coffee_shop/bloc/coffee_bloc/coffee_bloc.dart';
import 'package:coffee_shop/data/models/coffee_fields.dart';
import 'package:coffee_shop/ui/admin/home_screen/widgets/custom_textfield.dart';
import 'package:coffee_shop/ui/admin/home_screen/widgets/image_dialog.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AddCoffeeScreen extends StatefulWidget {
  const AddCoffeeScreen({Key? key}) : super(key: key);

  @override
  State<AddCoffeeScreen> createState() => _AddCoffeeScreenState();
}

class _AddCoffeeScreenState extends State<AddCoffeeScreen> {
  List<String> coffeeList = [
    "Americano",
    "Latte",
    "Cappuccino",
    "Espresso",
    "Flat White",
  ];
  String coffeeType = "Choose Coffee Type";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryBg,
        title: const Text("Add Coffee"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            CustomTextField(
              hintText: "Name of Coffee",
              onChanged: (value) {
                context.read<CoffeeBloc>().add(UpdateCoffeeField(
                    value: value, fieldKey: CoffeeFields.name));
              },
              inputType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              hintText: "Price of Coffee",
              onChanged: (value) {
                context.read<CoffeeBloc>().add(UpdateCoffeeField(
                    value: double.parse(value), fieldKey: CoffeeFields.price));
              },
              inputType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              hintText: "Description of Coffee",
              onChanged: (value) {
                context.read<CoffeeBloc>().add(UpdateCoffeeField(
                    value: value, fieldKey: CoffeeFields.description));
              },
              maxLines: 5,
              inputType: TextInputType.text,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.itemColor, // Use the desired background color
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                underline: const SizedBox(),
                dropdownColor: AppColors.itemColor,
                icon: const Icon(Icons.arrow_downward),
                borderRadius: BorderRadius.circular(12),
                items: coffeeList.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: const TextStyle(color: Colors.white38),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    coffeeType = newValue!;
                  });
                  context.read<CoffeeBloc>().add(UpdateCoffeeField(
                      value: newValue, fieldKey: CoffeeFields.type));
                },
                hint: Text(
                  coffeeType,
                  style: const TextStyle(color: Colors.white38),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.itemColor,
                ),
                onPressed: () {
                  showImageDialog(
                    context: context,
                    picker: ImagePicker(),
                    valueChanged: (value) {},
                  );
                },
                child: const Text("Choose Picture"),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                ),
                onPressed: () {
                  var state = context.read<CoffeeBloc>().state.coffeeModel;
                  if (state.name.isNotEmpty &&
                      state.type.isNotEmpty &&
                      state.price != 0 &&
                      state.imageUrl.isNotEmpty) {
                    context.read<CoffeeBloc>().add(AddCoffeeEvent());
                    Navigator.pop(context);
                  } else {
                    debugPrint("Errorr");
                  }
                },
                child: const Text(
                  "Add Coffee",
                  style: TextStyle(color: AppColors.primaryBg),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
