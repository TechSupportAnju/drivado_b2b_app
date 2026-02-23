import 'package:flutter/material.dart';

class CancelBottomSheet extends StatefulWidget {
  const CancelBottomSheet({super.key});

  @override
  State<CancelBottomSheet> createState() => _CancelBottomSheetState();
}

class _CancelBottomSheetState extends State<CancelBottomSheet> {
  
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Hello from BottomSheet",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          )
        ],
      ),
    );
  }
}