import 'package:flutter/material.dart';

class Transaction {
  String type;
  String category;
  double amount;
  DateTime date;
  String note;

  Transaction({
    required this.type,
    required this.category,
    required this.amount,
    required this.date,
    required this.note,
  });
}

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() =>
      _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  String selectedType = 'Chi tiêu';
  String selectedCategory = 'Ăn uống';
  DateTime selectedDate = DateTime.now();

  final TextEditingController amountController =
  TextEditingController();

  final TextEditingController noteController =
  TextEditingController();

  final List<String> categories = [
    'Ăn uống',
    'Di chuyển',
    'Mua sắm',
    'Giải trí',
    'Hóa đơn',
    'Khác',
  ];

  @override
  void dispose() {
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  Future<void> selectDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  void saveTransaction() {
    final String input =
    amountController.text.replaceAll('.', '').trim();

    final double? amount = double.tryParse(input);

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập số tiền hợp lệ'),
        ),
      );
      return;
    }

    final transaction = Transaction(
      type: selectedType,
      category: selectedCategory,
      amount: amount,
      date: selectedDate,
      note: noteController.text.trim(),
    );

    Navigator.pop(context, transaction);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF172033),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Thêm giao dịch',
          style: TextStyle(
            color: Color(0xFF172033),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTypeSelector(),
              const SizedBox(height: 20),
              const Text(
                'Danh mục',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF172033),
                ),
              ),
              const SizedBox(height: 8),
              buildCategoryDropdown(),
              const SizedBox(height: 20),
              const Text(
                'Số tiền',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF172033),
                ),
              ),
              const SizedBox(height: 8),
              buildAmountField(),
              const SizedBox(height: 20),
              const Text(
                'Ngày giao dịch',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF172033),
                ),
              ),
              const SizedBox(height: 8),
              buildDateField(),
              const SizedBox(height: 20),
              const Text(
                'Ghi chú',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF172033),
                ),
              ),
              const SizedBox(height: 8),
              buildNoteField(),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: saveTransaction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2176C7),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Lưu',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTypeSelector() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFE1E5EB),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedType = 'Chi tiêu';
                });
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selectedType == 'Chi tiêu'
                      ? const Color(0xFFFF5B61)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Text(
                  'Chi tiêu',
                  style: TextStyle(
                    color: selectedType == 'Chi tiêu'
                        ? Colors.white
                        : const Color(0xFF4B5565),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedType = 'Thu nhập';
                });
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selectedType == 'Thu nhập'
                      ? const Color(0xFF20B26B)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Text(
                  'Thu nhập',
                  style: TextStyle(
                    color: selectedType == 'Thu nhập'
                        ? Colors.white
                        : const Color(0xFF4B5565),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryDropdown() {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFDDE2E9),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCategory,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color(0xFF637083),
          ),
          items: categories.map((category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEEF0),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.restaurant_rounded,
                      size: 18,
                      color: Color(0xFFFF5B61),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    category,
                    style: const TextStyle(
                      color: Color(0xFF4B5565),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                selectedCategory = value;
              });
            }
          },
        ),
      ),
    );
  }

  Widget buildAmountField() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFDDE2E9),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Nhập số tiền',
                hintStyle: TextStyle(
                  color: Color(0xFFA0A8B6),
                  fontSize: 14,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: Text(
              'đ',
              style: TextStyle(
                color: Color(0xFF637083),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDateField() {
    return GestureDetector(
      onTap: selectDate,
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFDDE2E9),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                formatDate(selectedDate),
                style: const TextStyle(
                  color: Color(0xFF4B5565),
                  fontSize: 14,
                ),
              ),
            ),
            const Icon(
              Icons.calendar_month_outlined,
              color: Color(0xFF637083),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNoteField() {
    return Container(
      height: 75,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFDDE2E9),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: noteController,
        maxLines: 3,
        decoration: const InputDecoration(
          hintText: 'Nhập ghi chú (tùy chọn)',
          hintStyle: TextStyle(
            color: Color(0xFFA0A8B6),
            fontSize: 14,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(12),
        ),
      ),
    );
  }
}