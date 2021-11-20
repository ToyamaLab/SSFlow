import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ssflow/providers/_providers.dart';
import 'package:ssflow/utils/constants/_constants.dart';

class SSFlowLogo extends ConsumerWidget {
  const SSFlowLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: ref.watch(windowSize).height / 10,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: SSColor.grey,
            width: 1.0,
          ),
        ),
        color: SSColor.black,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: ref.watch(windowSize).width * 0.01),
              RichText(
                text: TextSpan(
                  text: 'S',
                  style: TextStyle(
                    color: SSColor.primary,
                    fontSize: 32,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'SFlow',
                      style: TextStyle(
                        color: SSColor.white,
                        fontSize: 32,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
