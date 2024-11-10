import 'package:flutter/material.dart';
import 'package:lab1/components/buy-ticket-page/TicketCountItem.dart';

class TicketsCountSelector extends StatefulWidget {
  const TicketsCountSelector({super.key});

  @override
  State<TicketsCountSelector> createState() => _TicketsCountSelectorState();
}

class _TicketsCountSelectorState extends State<TicketsCountSelector> {
  int selectedCount = 1;
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (_focus.hasFocus) {
      setState(() {
        selectedCount = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.white,
        ),
        child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TicketCountItem(
                  onTap: () {
                    setState(() {
                      selectedCount = 1;
                    });
                  },
                  border: selectedCount == 1
                      ? Border.all(color: Colors.blueAccent, width: 2)
                      : null,
                  buttonText: '1',
                ),
                TicketCountItem(
                  onTap: () {
                    setState(() {
                      selectedCount = 2;
                    });
                  },
                  border: selectedCount == 2
                      ? Border.all(color: Colors.blueAccent, width: 2)
                      : null,
                  buttonText: '2',
                ),
                TicketCountItem(
                  onTap: () {
                    setState(() {
                      selectedCount = 3;
                    });
                  },
                  border: selectedCount == 3
                      ? Border.all(color: Colors.blueAccent, width: 2)
                      : null,
                  buttonText: '3',
                ),
                Flexible(
                  flex: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: 80,
                    height: 44,
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      focusNode: _focus,
                      maxLength: 2,
                      decoration: InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                        hintText: 'Other',
                        hintStyle:
                            TextStyle(fontSize: 12, color: Colors.grey[400]),
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
