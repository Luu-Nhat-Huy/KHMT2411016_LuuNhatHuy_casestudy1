import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.menu,
                            color: Color(0xFF14213D),
                            size: 25,
                          ),
                        ),
                        const SizedBox(width: 14),
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
                            const Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.notifications_none,
                                size: 28,
                                color: Color(0xFF14213D),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFF4D5E),
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Text(
                                    '3',
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
                      ],
                    ),

                    const SizedBox(height: 16),

                    Container(
                      width: double.infinity,
                      height: 158,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF4388F5),
                            Color(0xFF1768E5),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'SỐ DƯ HIỆN TẠI',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
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
                              ),
                              const SizedBox(height: 8),
                              const Center(
                                child: Text(
                                  '5.000.000 ₫',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              const Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
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
                            amount: '8.000.000 ₫',
                            color: const Color(0xFFE8F7EA),
                            iconColor: const Color(0xFF55B866),
                            icon: Icons.arrow_downward,
                            amountColor: const Color(0xFF19A43A),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _MoneyCard(
                            title: 'TỔNG CHI TIÊU',
                            amount: '3.000.000 ₫',
                            color: const Color(0xFFFFEDEF),
                            iconColor: const Color(0xFFFF5964),
                            icon: Icons.arrow_upward,
                            amountColor: const Color(0xFFFF2938),
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
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF14213D),
                            ),
                          ),
                        ),
                        Text(
                          'Xem tất cả',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF2475E5),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: const Color(0xFFE8EBF0),
                        ),
                      ),
                      child: Column(
                        children: [
                          _TransactionItem(
                            icon: Icons.restaurant,
                            iconColor: const Color(0xFFFF6B22),
                            title: 'Ăn trưa',
                            category: 'Ăn uống',
                            date: '03/09/2024',
                            amount: '-50.000 ₫',
                            amountColor: const Color(0xFFFF2938),
                          ),
                          _TransactionItem(
                            icon: Icons.directions_car,
                            iconColor: const Color(0xFF2295F2),
                            title: 'Xăng xe',
                            category: 'Di chuyển',
                            date: '03/09/2024',
                            amount: '-100.000 ₫',
                            amountColor: const Color(0xFFFF2938),
                          ),
                          _TransactionItem(
                            icon: Icons.attach_money,
                            iconColor: const Color(0xFF20AA43),
                            title: 'Lương tháng 9',
                            category: 'Thu nhập',
                            date: '01/09/2024',
                            amount: '+8.000.000 ₫',
                            amountColor: const Color(0xFF19A43A),
                          ),
                          _TransactionItem(
                            icon: Icons.shopping_cart,
                            iconColor: const Color(0xFFA03EF2),
                            title: 'Mua sắm',
                            category: 'Mua sắm',
                            date: '31/08/2024',
                            amount: '-300.000 ₫',
                            amountColor: const Color(0xFFFF2938),
                          ),
                          _TransactionItem(
                            icon: Icons.school,
                            iconColor: const Color(0xFF0B9B9B),
                            title: 'Học phí',
                            category: 'Giáo dục',
                            date: '30/08/2024',
                            amount: '-500.000 ₫',
                            amountColor: const Color(0xFFFF2938),
                            showDivider: false,
                          ),
                        ],
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
          onPressed: () {},
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
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 25,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 9,
                    color: Color(0xFF65748B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  amount,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
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
  final IconData icon;
  final Color iconColor;
  final String title;
  final String category;
  final String date;
  final String amount;
  final Color amountColor;
  final bool showDivider;

  const _TransactionItem({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.category,
    required this.date,
    required this.amount,
    required this.amountColor,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(
          bottom: BorderSide(
            color: Color(0xFFE9ECF1),
          ),
        )
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 23,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF14213D),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  category,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF8290A6),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                date,
                style: const TextStyle(
                  fontSize: 9,
                  color: Color(0xFF8290A6),
                ),
              ),
              const SizedBox(height: 7),
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
        mainAxisAlignment: MainAxisAlignment.center,
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
              fontWeight:
              active ? FontWeight.w600 : FontWeight.w400,
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
                borderRadius: BorderRadius.circular(5),
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
                borderRadius: BorderRadius.circular(10),
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
                borderRadius: BorderRadius.circular(9),
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