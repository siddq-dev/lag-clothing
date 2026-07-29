import 'package:flutter/material.dart';

import '../../../../models/product_form_model.dart';

class ProductStatusSection extends StatefulWidget {
  const ProductStatusSection({
    super.key,
    required this.form,
  });

  final ProductFormModel form;

  @override
  State<ProductStatusSection> createState() =>
      _ProductStatusSectionState();
}

class _ProductStatusSectionState
    extends State<ProductStatusSection> {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [

          SwitchListTile(
            title: const Text("Featured"),
            value: widget.form.featured,
            onChanged: (value) {
              setState(() {
                widget.form.featured =
                    value;
              });
            },
          ),

          SwitchListTile(
            title:
                const Text("Best Seller"),
            value:
                widget.form.bestSeller,
            onChanged: (value) {
              setState(() {
                widget.form.bestSeller =
                    value;
              });
            },
          ),

          SwitchListTile(
            title:
                const Text("New Arrival"),
            value:
                widget.form.newArrival,
            onChanged: (value) {
              setState(() {
                widget.form.newArrival =
                    value;
              });
            },
          ),

          SwitchListTile(
            title: const Text("Published"),
            value: widget.form.status,
            onChanged: (value) {
              setState(() {
                widget.form.status =
                    value;
              });
            },
          ),

        ],
      ),
    );
  }
}