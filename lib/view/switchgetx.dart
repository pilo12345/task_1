import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_1/api_services/switch_controller.dart';

class RRR extends StatefulWidget {
  @override
  _RRRState createState() => _RRRState();
}

class _RRRState extends State<RRR> {
  SwitchController switchController = Get.put(SwitchController());
  @override
  Widget build(BuildContext context) {
    print("ok");
    return Scaffold(
      body: Center(
        child: Obx(
          () => Switch(
            value: switchController.rr.value,
            onChanged: (Value) {
              switchController.isSwitchOn(Value);
            },
          ),
        ),
      ),
    );
  }
}
