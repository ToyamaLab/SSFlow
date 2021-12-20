// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Project imports:
import 'package:ssflow/enum/_enum.dart';
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
    final _selectedElementProvider = selectedSSElementProvider(ref.watch);
    final _selectedElement = ref.watch(_selectedElementProvider);
    final _parent = _selectedElement.parentUuid != null
        ? ref.watch(ssElementProviders(_selectedElement.parentUuid!))
        : null;
    final _after = _selectedElement.afterUuid != null
        ? ref.watch(ssElementProviders(_selectedElement.afterUuid!))
        : null;

    return Container(
      width: ref.watch(rightSideAreaSize).width,
      padding: EdgeInsets.only(top: ref.watch(rightSideAreaSize).height * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _HeadingText('Identity and Type'),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _ItemText('UUID:'),
              _InfoText(_selectedElement.uuid),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _ItemText('Type:'),
              _InfoText(_selectedElement.layoutType),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _ItemText('Parent UUID:'),
              _InfoText(_parent != null ? _parent.uuid : 'Root'),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _ItemText('Parent Type:'),
              _InfoText(_parent != null ? _parent.layoutType : 'Root'),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _ItemText('After UUID:'),
              _InfoText(_after != null ? _after.uuid : 'No'),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _ItemText('After Type:'),
              _InfoText(_after != null ? _after.layoutType : 'No'),
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
    List<Widget> _children = [const _HeadingText('Data Settings')];
    final _selectedElementProvider = selectedSSElementProvider(ref.watch);
    final _selectedElement = ref.watch(_selectedElementProvider);
    final _type = _selectedElement.layoutType.toLayoutType!;
    final _dataController = ref.watch(textDataController);
    final _tableController = ref.watch(dbTableController);
    final _columnController = ref.watch(dbColumnController);
    switch (_type) {
      case L.text:
      case L.function:
        _children = [
          const _HeadingText('Data Settings'),
          Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              const _ItemText('Data:'),
              _FormField(
                controller: _dataController,
                onSaved: (newData) => ref
                    .read(_selectedElementProvider.notifier)
                    .updateData(newData ??= ''),
              ),
            ],
          ),
        ];
        break;
      case L.tableData:
        _children = [
          const _HeadingText('Data Settings'),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _ItemText('Table Name:'),
                      _FormField(
                controller: _tableController,
                onSaved: (newTable) =>
                    ref.read(_selectedElementProvider.notifier).updateTableData(
                          table: newTable ??= '',
                          column: _columnController.text,
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
                controller: _columnController,
                onSaved: (newColumn) =>
                    ref.read(_selectedElementProvider.notifier).updateTableData(
                          table: _tableController.text,
                          column: newColumn ??= '',
                        ),
                      ),
                    ],
                  ),
        ];
        break;
      default:
        _children = [
          const _HeadingText('Data Settings'),
          const _ItemText('準備中'),
        ];
        break;
    }

    return Container(
      width: ref.watch(rightSideAreaSize).width,
      padding: EdgeInsets.only(top: ref.watch(rightSideAreaSize).height * 0.01),
      child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
        children: _children,
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
      width: ref.watch(rightSideAreaSize).width * 0.6,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(text, maxLines: 3),
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
