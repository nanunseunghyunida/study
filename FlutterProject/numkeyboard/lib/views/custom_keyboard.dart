import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:numkeyboard/views/custom_key.dart';

class CustomKeyboard extends StatefulWidget {
  const CustomKeyboard({super.key});

  @override
  State<CustomKeyboard> createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {
  late List<List<String>> keys;
  late String amount;

  @override
  void initState() {
    super.initState();

    keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['00', '0', 'DEL'],
    ];
    amount = '';
  }

  onKeyTap(String val) {
    if ((val == '00' || val == '0') && amount.isEmpty) return;

    if (amount.length == 10) {
      return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: Row(
            children: const [
              Text('더 이상의 금액은 송금하실 수 없습니다.'),
              SizedBox(height: 40),
            ],
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text(
                      '확인',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    setState(() {
      amount = amount + val;
    });
  }

  onDeletePress() {
    if (amount.isEmpty) return;
    setState(() {
      amount = amount.substring(0, amount.length - 1);
    });
  }

  onDeleteLongPress() {
    if (amount.isEmpty) return;
    setState(() {
      amount = '';
    });
  }

  renderAmount() {
    String display = '보낼금액';
    TextStyle style = const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
    );

    if (amount.isNotEmpty) {
      NumberFormat f = NumberFormat('#,###');

      display = '${f.format(int.parse(amount))} 원';
      style = style.copyWith(
        color: Colors.black,
      );
    }

    return Expanded(
      child: Center(
        child: Text(
          display,
          style: style,
        ),
      ),
    );
  }

  renderKeyboard() {
    return keys
        .map(
          (x) => Row(
            children: x.map(
              (y) {
                return Expanded(
                  child: CustomKey(
                    label: y,
                    value: y,
                    onTap: (val) {
                      if ('DEL' == val) {
                        onDeletePress();
                      } else {
                        onKeyTap(val);
                      }
                    },
                    onLongPress: (val) {
                      if ('DEL' == val) {
                        onDeleteLongPress();
                      }
                    },
                  ),
                );
              },
            ).toList(),
          ),
        )
        .toList();
  }

  renderConfirmButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    amount.isEmpty ? Colors.grey.shade300 : Colors.orange),
              ),
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  '확인',
                  style: TextStyle(
                    color: amount.isEmpty ? Colors.grey : Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            renderAmount(),
            ...renderKeyboard(),
            const SizedBox(height: 5),
            renderConfirmButton(),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
