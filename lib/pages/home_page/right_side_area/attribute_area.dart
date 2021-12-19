// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/providers/_providers.dart';
import 'package:ssflow/utils/_utils.dart';

class AttributeArea extends ConsumerWidget {
  const AttributeArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        _IdentityAndType(),
        _DataSettings(),
      ],
    );
  }
}

class _IdentityAndType extends ConsumerWidget {
  const _IdentityAndType({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(top: ref.watch(rightSideAreaSize).height * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _HeadingText('Identity and Type'),
          Row(
            children: const [
              _ItemText('UUID:'),
              _InfoText('uuid'),
            ],
          ),
          Row(
            children: const [
              _ItemText('Type:'),
              _InfoText('type'),
            ],
          ),
          Row(
            children: const [
              _ItemText('Parent UUID:'),
              _InfoText('parent uuid'),
            ],
          ),
          Row(
            children: const [
              _ItemText('After UUID:'),
              _InfoText('after uuid'),
            ],
          ),
          Row(
            children: const [
              _ItemText('After Type:'),
              _InfoText('after type'),
            ],
          ),
        ],
      ),
    );
  }
}

class _DataSettings extends ConsumerWidget {
  const _DataSettings({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(top: ref.watch(rightSideAreaSize).height * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _HeadingText('Data Settings'),
          (() {
            bool _typeIsTableData = true;
            if (_typeIsTableData) {
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _ItemText('Table Name:'),
                      _FormField(
                        controller: ref.watch(dbTableController),
                        onSaved: (newData) => logger.info(
                          'TODO: update element\'s data with newData: $newData',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ref.watch(rightSideAreaSize).height * 0.01),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _ItemText('Column Name:'),
                      _FormField(
                        controller: ref.watch(dbColumnController),
                        onSaved: (newData) => logger.info(
                          'TODO: update element\'s data with newData: $newData',
                        ),
                      ),
                    ],
                  ),
                ],
              );
              // ignore: dead_code
            } else {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _ItemText('Data:'),
                  _FormField(
                    controller: ref.watch(textDataController),
                    onSaved: (newData) => logger.info(
                      'TODO: update element\'s data with newData: $newData',
                    ),
                  ),
                ],
              );
            }
          }()),
        ],
      ),
    );
  }
}

class _HeadingText extends ConsumerWidget {
  final String text;
  const _HeadingText(
    this.text, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.only(left: ref.watch(rightSideAreaSize).width * 0.03),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}

class _ItemText extends ConsumerWidget {
  final String text;
  const _ItemText(
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _width = ref.watch(rightSideAreaSize).width;
    const _paddingRate = 0.03;

    return SizedBox(
      width: _width * (0.3 + _paddingRate),
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.only(right: _width * _paddingRate),
          child: Text(text),
        ),
      ),
    );
  }
}

class _InfoText extends ConsumerWidget {
  final String text;
  const _InfoText(
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: ref.watch(rightSideAreaSize).width * 0.3,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(text),
      ),
    );
  }
}

class _FormField extends ConsumerWidget {
  final TextEditingController controller;
  final Function(String?) onSaved;

  const _FormField({
    required this.controller,
    required this.onSaved,
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _form = GlobalKey<FormState>();
    return SizedBox(
      width: ref.watch(rightSideAreaSize).width * 0.6,
      child: Form(
        key: _form,
        child: Focus(
          onFocusChange: (hasFocus) {
            if (!hasFocus) {
              // 他のところをクリックしてsaveされる
              _form.currentState!.save();
            }
          },
          child: TextFormField(
            controller: controller,
            onSaved: onSaved,
            maxLines: 3,
            decoration: InputDecoration(
              fillColor: SSColor.darkGrey,
              filled: true,
            ),
          ),
        ),
      ),
    );
  }
}
