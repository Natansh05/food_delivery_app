import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myapp/src/common%20widgets/my_button.dart';

import '../models/food.dart';

class FoodPage extends StatefulWidget {
  final Map<AddOn,bool> selectedAddons = {};
  final Food food;

  FoodPage({
    required this.food,
    super.key}){
     for(AddOn addOn in food.availableAddOn){
       selectedAddons[addOn] = false;
     }
  }

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // food image
                ClipRRect(
                    child: Image.asset(widget.food.imagePath),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.food.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
            
                    // food price
                    Text('\₹'+" "+ (widget.food.price).toString(),
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
            
                    const SizedBox(
                      height: 10.0,
                    ),
            
            
                    // food description
                    Text(widget.food.description,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
            
                    const SizedBox(
                      height: 10.0,
                    ),
                     Divider(
                       color: Theme.of(context).colorScheme.secondary,
                     ),
            
                     Text("Add-Ons",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
            
                    // available addons
                    Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.zero,
                      child: ListView.builder(
                          shrinkWrap: true,
                         physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.food.availableAddOn.length,
                          itemBuilder: (context,index){
                            // get individual addon first
                            AddOn addon = widget.food.availableAddOn[index];
                            return CheckboxListTile(
                                title: Text(addon.name),
                                subtitle: Text('\₹'+" "+(addon.price).toString()),
                                value: widget.selectedAddons[addon],
                                onChanged: (value){
                                  setState(() {
                                    widget.selectedAddons[addon]=value!;
                                  });
                                });
                          }),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    MyButton(
                        onTap: (){},
                        text: "Add to cart"),
                    const SizedBox(
                      height: 25.0,
                    )
                  ],

                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
