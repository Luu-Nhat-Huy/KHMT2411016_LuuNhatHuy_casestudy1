import 'package:flutter/material.dart';
import 'add_transaction.dart';
import 'edit_transaction.dart';
import 'database/database_helper.dart';
import 'models/transaction_model.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Transaction> transactions = [];

  bool isLoading = true;

  double totalIncome = 0;
  double totalExpense = 0;
  double balance = 0;

  @override
  void initState() {
    super.initState();
    loadTransactions();
  }

  Future<void> loadTransactions() async {
    setState(() {
      isLoading = true;
    });

    final data =
    await DatabaseHelper.instance.getTransactions();

    double income = 0;
    double expense = 0;

    for (final transaction in data) {
      if (transaction.type == 'Thu nhập') {
        income += transaction.amount;
      } else {
        expense += transaction.amount;
      }
    }

    if (!mounted) return;

    setState(() {
      transactions = data;
      totalIncome = income;
      totalExpense = expense;
      balance = income - expense;
      isLoading = false;
    });
  }

  Future<void> addTransaction() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
        const AddTransactionScreen(),
      ),
    );

    if (result == true) {
      await loadTransactions();
    }
  }

  Future<void> editTransaction(
      Transaction transaction,
      ) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditTransactionScreen(
              transaction: transaction,
            ),
      ),
    );

    if (result == true) {
      await loadTransactions();
    }
  }

  Future<void> deleteTransaction(
      Transaction transaction,
      ) async {
    if (transaction.id == null) return;

    await DatabaseHelper.instance.deleteTransaction(
      transaction.id!,
    );

    await loadTransactions();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Đã xóa giao dịch'),
      ),
    );
  }

  String formatMoney(double value) {
    final text = value
        .round()
        .toString()
        .replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]}.',
    );

    return '$text ₫';
  }

  String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  IconData getCategoryIcon(String category) {
    switch (category) {
      case 'Ăn uống':
        return Icons.restaurant;
      case 'Di chuyển':
        return Icons.directions_car;
      case 'Mua sắm':
        return Icons.shopping_cart;
      case 'Giải trí':
        return Icons.movie;
      case 'Hóa đơn':
        return Icons.receipt_long;
      default:
        return Icons.category;
    }
  }

  Color getCategoryColor(String category) {
    switch (category) {
      case 'Ăn uống':
        return const Color(0xFFFF6B22);
      case 'Di chuyển':
        return const Color(0xFF2295F2);
      case 'Mua sắm':
        return const Color(0xFFA03EF2);
      case 'Giải trí':
        return const Color(0xFFFFB020);
      case 'Hóa đơn':
        return const Color(0xFFE53935);
      default:
        return const Color(0xFF0B9B9B);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: loadTransactions,
                child: ListView(
                  padding:
                  const EdgeInsets.fromLTRB(
                    20,
                    16,
                    20,
                    100,
                  ),
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.menu,
                            color: Color(0xFF14213D),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Quản lý thu chi',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF14213D),
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            const Icon(
                              Icons.notifications_none,
                              size: 29,
                              color: Color(0xFF14213D),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration:
                                const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Text(
                                    '3',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 9,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Container(
                      width: double.infinity,
                      height: 158,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient:
                        const LinearGradient(
                          colors: [
                            Color(0xFF4388F5),
                            Color(0xFF1768E5),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius:
                        BorderRadius.circular(18),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              const Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'SỐ DƯ HIỆN TẠI',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(
                                    Icons.visibility,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                formatMoney(balance),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 34,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              const Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                  SizedBox(width: 6),
                                  Icon(
                                    Icons.circle,
                                    color: Color(0xFF9BBDF5),
                                    size: 6,
                                  ),
                                  SizedBox(width: 6),
                                  Icon(
                                    Icons.circle,
                                    color: Color(0xFF9BBDF5),
                                    size: 6,
                                  ),
                                  SizedBox(width: 6),
                                  Icon(
                                    Icons.circle,
                                    color: Color(0xFF9BBDF5),
                                    size: 6,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Positioned(
                            right: 0,
                            bottom: 5,
                            child: _WalletImage(),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    Row(
                      children: [
                        Expanded(
                          child: _MoneyCard(
                            title: 'TỔNG THU NHẬP',
                            amount:
                            formatMoney(totalIncome),
                            color:
                            const Color(0xFFE8F7EA),
                            iconColor:
                            const Color(0xFF55B866),
                            icon:
                            Icons.arrow_downward,
                            amountColor:
                            const Color(0xFF19A43A),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _MoneyCard(
                            title: 'TỔNG CHI TIÊU',
                            amount:
                            formatMoney(totalExpense),
                            color:
                            const Color(0xFFFFEDEF),
                            iconColor:
                            const Color(0xFFFF5964),
                            icon:
                            Icons.arrow_upward,
                            amountColor:
                            const Color(0xFFFF2938),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Giao dịch gần đây',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight:
                              FontWeight.bold,
                              color: Color(0xFF14213D),
                            ),
                          ),
                        ),
                        Text(
                          'Xem tất cả',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight:
                            FontWeight.w600,
                            color:
                            const Color(0xFF2475E5),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    if (isLoading)
                      const SizedBox(
                        height: 200,
                        child: Center(
                          child:
                          CircularProgressIndicator(),
                        ),
                      )
                    else if (transactions.isEmpty)
                      Container(
                        height: 180,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(14),
                          border: Border.all(
                            color:
                            const Color(0xFFE8EBF0),
                          ),
                        ),
                        child: const Text(
                          'Chưa có giao dịch nào',
                          style: TextStyle(
                            color: Color(0xFF7D8DA6),
                            fontSize: 15,
                          ),
                        ),
                      )
                    else
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(14),
                          border: Border.all(
                            color:
                            const Color(0xFFE8EBF0),
                          ),
                        ),
                        child: Column(
                          children: transactions
                              .take(5)
                              .map(
                                (transaction) =>
                                Dismissible(
                                  key: Key(
                                    'transaction_${transaction.id}',
                                  ),
                                  direction:
                                  DismissDirection
                                      .endToStart,
                                  background: Container(
                                    alignment:
                                    Alignment.centerRight,
                                    padding:
                                    const EdgeInsets
                                        .only(
                                      right: 20,
                                    ),
                                    decoration:
                                    BoxDecoration(
                                      color: Colors.red,
                                      borderRadius:
                                      BorderRadius
                                          .circular(
                                          14),
                                    ),
                                    child: const Icon(
                                      Icons.delete,
                                      color:
                                      Colors.white,
                                    ),
                                  ),
                                  onDismissed: (_) {
                                    deleteTransaction(
                                      transaction,
                                    );
                                  },
                                  child: InkWell(
                                    onTap: () {
                                      editTransaction(
                                        transaction,
                                      );
                                    },
                                    child:
                                    _TransactionItem(
                                      transaction:
                                      transaction,
                                      icon:
                                      getCategoryIcon(
                                        transaction
                                            .category,
                                      ),
                                      iconColor:
                                      getCategoryColor(
                                        transaction
                                            .category,
                                      ),
                                      formatDate:
                                      formatDate,
                                      formatMoney:
                                      formatMoney,
                                      showDivider:
                                      transaction !=
                                          transactions
                                              .take(5)
                                              .last,
                                    ),
                                  ),
                                ),
                          )
                              .toList(),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: SizedBox(
        width: 58,
        height: 58,
        child: FloatingActionButton(
          onPressed: addTransaction,
          backgroundColor: const Color(0xFF2878E5),
          elevation: 5,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 34,
          ),
        ),
      ),

      floatingActionButtonLocation:
      FloatingActionButtonLocation.endDocked,

      bottomNavigationBar: Container(
        height: 78,
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Color(0xFFE6E8ED),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: _BottomNavigationItem(
                icon: Icons.home,
                title: 'Trang chủ',
                active: true,
                onTap: () {},
              ),
            ),
            Expanded(
              child: _BottomNavigationItem(
                icon: Icons.receipt_long_outlined,
                title: 'Giao dịch',
                onTap: () {},
              ),
            ),
            Expanded(
              child: _BottomNavigationItem(
                icon: Icons.pie_chart_outline,
                title: 'Thống kê',
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoneyCard extends StatelessWidget {
  final String title;
  final String amount;
  final Color color;
  final Color iconColor;
  final IconData icon;
  final Color amountColor;

  const _MoneyCard({
    required this.title,
    required this.amount,
    required this.color,
    required this.iconColor,
    required this.icon,
    required this.amountColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 9,
                    color: Color(0xFF637083),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  amount,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: amountColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final IconData icon;
  final Color iconColor;
  final String Function(DateTime) formatDate;
  final String Function(double) formatMoney;
  final bool showDivider;

  const _TransactionItem({
    required this.transaction,
    required this.icon,
    required this.iconColor,
    required this.formatDate,
    required this.formatMoney,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    final bool isIncome =
        transaction.type == 'Thu nhập';

    final Color amountColor = isIncome
        ? const Color(0xFF19A43A)
        : const Color(0xFFFF2938);

    final String amount =
        '${isIncome ? '+' : '-'}${formatMoney(transaction.amount)}';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(
          bottom: BorderSide(
            color: Color(0xFFE8EBF0),
          ),
        )
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 21,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.note.isEmpty
                      ? transaction.category
                      : transaction.note,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF14213D),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  transaction.category,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF8B96A8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment:
            CrossAxisAlignment.end,
            children: [
              Text(
                formatDate(transaction.date),
                style: const TextStyle(
                  fontSize: 9,
                  color: Color(0xFF8B96A8),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                amount,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: amountColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BottomNavigationItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool active;
  final VoidCallback onTap;

  const _BottomNavigationItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = active
        ? const Color(0xFF2475E5)
        : const Color(0xFF1E293B);

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: active
                  ? FontWeight.w600
                  : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _WalletImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 82,
      height: 82,
      child: Stack(
        children: [
          Positioned(
            left: 17,
            top: 5,
            child: Container(
              width: 40,
              height: 30,
              decoration: BoxDecoration(
                color: const Color(0xFF62BF6A),
                borderRadius:
                BorderRadius.circular(5),
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 20,
            child: Container(
              width: 56,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF2464A9),
                borderRadius:
                BorderRadius.circular(10),
              ),
            ),
          ),
          Positioned(
            left: 10,
            top: 40,
            child: Container(
              width: 59,
              height: 34,
              decoration: BoxDecoration(
                color: const Color(0xFF2D78C9),
                borderRadius:
                BorderRadius.circular(9),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 8,
            child: Container(
              width: 18,
              height: 18,
              decoration: const BoxDecoration(
                color: Color(0xFFFFC52B),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  '\$',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
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
}