import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/colors.dart';

const Color kTeal = AppColors.tealGray;
const Color kGrey = AppColors.gray;
const Color kLightDivider = Color(0xFFEFEFEF);
const Color kDarkText = Color(0xFF1A1A1A);

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Checkout',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'SFProDisplay', // Falls back to system font if not bundled.
        colorScheme: ColorScheme.fromSeed(
          seedColor: kTeal,
          primary: kTeal,
          background: Colors.white,
        ),
      ),
      home: const CheckoutScreen(),
    );
  }
}

// ---------------------------------------------------------------------------
// MODELS
// ---------------------------------------------------------------------------

class OrderItemModel {
  OrderItemModel({
    required this.name,
    required this.price,
    required this.size,
    required this.sizeIsBadge,
    required this.imageUrl,
    this.quantity = 1,
  });

  final String name;
  final double price;
  final String size;
  final bool sizeIsBadge; // true -> teal rounded badge, false -> plain text
  final String imageUrl;
  int quantity;
}

enum PaymentMethod { creditCard, cash }

// ---------------------------------------------------------------------------
// SCREEN
// ---------------------------------------------------------------------------

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final List<OrderItemModel> _items = [
    OrderItemModel(
      name: "Men's Tie-Dye T-Shirt",
      price: 450,
      size: 'L',
      sizeIsBadge: false,
      imageUrl: 'images/Tshirt.png',),
    OrderItemModel(
      name: 'Nike Sportswear',
      price: 250,
      size: 'XL',
      sizeIsBadge: true,
      imageUrl: 'images/Tshirt.png',),
  ];

  PaymentMethod _paymentMethod = PaymentMethod.creditCard;
  bool _useWallet = true;
  final double _walletBalance = 50;

  final TextEditingController _promoController = TextEditingController();
  double _promoDiscount = 0;
  String? _promoMessage;

  final double _shippingCost = 100;

  // ------------------------- Inline-edit state (Email / Phone) ------------
  // Separate controller + boolean per editable field, as required.
  final TextEditingController _emailController =
      TextEditingController(text: 'johndoe@example.com');
  bool _isEditingEmail = false;

  final TextEditingController _phoneController =
      TextEditingController(text: '+20 100 123 4567');
  bool _isEditingPhone = false;

  @override
  void dispose() {
    _promoController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // ------------------------- Derived / dynamic values ---------------------

  double get _subtotal =>
      _items.fold(0, (sum, item) => sum + item.price * item.quantity);

  double get _totalCost => _subtotal + _shippingCost;

  double get _walletDeduction => _useWallet ? _walletBalance : 0;

  double get _grandTotal {
    final total = _totalCost - _promoDiscount - _walletDeduction;
    return total < 0 ? 0 : total;
  }

  void _incrementQty(int index) {
    setState(() => _items[index].quantity++);
  }

  void _decrementQty(int index) {
    setState(() {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      }
    });
  }

  void _removeItem(int index) {
    setState(() => _items.removeAt(index));
  }

  void _applyPromo() {
    final code = _promoController.text.trim().toUpperCase();
    setState(() {
      if (code.isEmpty) {
        _promoDiscount = 0;
        _promoMessage = null;
      } else if (code == 'SAVE60') {
        _promoDiscount = 60;
        _promoMessage = 'Promo code applied!';
      } else {
        _promoDiscount = 0;
        _promoMessage = 'Invalid promo code';
      }
    });
    FocusScope.of(context).unfocus();
  }

  // Toggles Email editing. When switching from editing -> not editing,
  // the new value (already written into _emailController by the TextField)
  // is saved simply by rebuilding the Text widget with it via setState().
  void _toggleEmailEdit() {
    setState(() {
      _isEditingEmail = !_isEditingEmail;
    });
  }

  // Toggles Phone editing, same behavior as email.
  void _togglePhoneEdit() {
    setState(() {
      _isEditingPhone = !_isEditingPhone;
    });
  }

  String _egp(double value, {String prefix = 'L.E'}) {
    final isNegative = value < 0;
    final abs = value.abs();
    final formatted = abs == abs.roundToDouble()
        ? abs.toStringAsFixed(0)
        : abs.toStringAsFixed(2);
    return '${isNegative ? '-' : ''}$prefix $formatted';
  }

  // ---------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final hPad = width < 360 ? 16.0 : (width > 600 ? 32.0 : 20.0);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 12),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: constraints.maxWidth > 600 ? 600 : constraints.maxWidth,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle('Order Items'),
                    const SizedBox(height: 12),
                    _buildOrderItemsList(),
                    const SizedBox(height: 24),
                    _sectionTitle('Address'),
                    const SizedBox(height: 12),
                    _buildAddressSection(),
                    const SizedBox(height: 24),
                    _sectionTitle('Contact Information'),
                    const SizedBox(height: 12),
                    _buildContactRow(
                      icon: Icons.mail_outline_rounded,
                      label: 'Email',
                      controller: _emailController,
                      isEditing: _isEditingEmail,
                      onEditToggle: _toggleEmailEdit,
                    ),
                    const SizedBox(height: 12),
                    _buildContactRow(
                      icon: Icons.call_outlined,
                      label: 'Phone',
                      controller: _phoneController,
                      isEditing: _isEditingPhone,
                      onEditToggle: _togglePhoneEdit,
                    ),
                    const SizedBox(height: 24),
                    _sectionTitle('Payment Method'),
                    const SizedBox(height: 12),
                    _buildPaymentSection(),
                    const SizedBox(height: 24),
                    _sectionTitle('Promo Code'),
                    const SizedBox(height: 12),
                    _buildPromoField(),
                    const SizedBox(height: 24),
                    _buildOrderSummaryCard(),
                    const SizedBox(height: 24),
                    _buildCheckoutButton(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ------------------------------- APP BAR --------------------------------

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.white,
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.maybePop(context),
      ),
      title: const Text(
        'Checkout',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }

  // ---------------------------- SECTION TITLE ------------------------------

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: kDarkText,
      ),
    );
  }

  // ---------------------------- ORDER ITEMS --------------------------------

  Widget _buildOrderItemsList() {
    return Column(
      children: List.generate(_items.length, (index) {
        final item = _items[index];
        return Column(
          children: [
            _ProductCard(
              item: item,
              onIncrement: () => _incrementQty(index),
              onDecrement: () => _decrementQty(index),
              onDelete: () => _removeItem(index),
              egpFormatter: _egp,
            ),
            if (index != _items.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Divider(height: 1, thickness: 1, color: kLightDivider),
              ),
          ],
        );
      }),
    );
  }

  // ------------------------------ ADDRESS ----------------------------------

  Widget _buildAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {},
          child: Row(
            children: [
              const Expanded(
                child: Text(
                  'Newhall St 36, London, 12908 - UK',
                  style: TextStyle(
                    fontSize: 14,
                    color: kDarkText,
                    height: 1.4,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: kGrey, size: 22),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            height: 140,
            width: double.infinity,
            color: const Color(0xFFE9ECEF),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Fake map grid lines for a "google-style" look.
                CustomPaint(
                  size: const Size(double.infinity, 140),
                  painter: _MapGridPainter(),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: Color(0xFF3B82F6),
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  
  Widget _buildContactRow({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    required bool isEditing,
    required VoidCallback onEditToggle,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: const Color.fromARGB(255, 0, 0, 0), size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: kGrey),
              ),
              const SizedBox(height: 2),
              isEditing
                  ? TextField(
                      controller: controller,
                      autofocus: true,
                      keyboardType: label == 'Email'
                          ? TextInputType.emailAddress
                          : TextInputType.phone,
                      onSubmitted: (_) => onEditToggle(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: kDarkText,
                      ),
                      decoration: const InputDecoration(
                        isDense: true,
                        isCollapsed: true,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    )
                  : Text(
                      controller.text,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: kDarkText,
                      ),
                    ),
            ],
          ),
        ),
        IconButton(
          onPressed: onEditToggle,
          icon: Icon(
            isEditing ? Icons.check : Icons.edit_outlined,
            color: isEditing ? kTeal : kGrey,
            size: 18,
          ),
        ),
      ],
    );
  }

  // ---------------------------- PAYMENT METHOD ------------------------------

  Widget _buildPaymentSection() {
    return Column(
      children: [
        _PaymentOptionRow(
          label: 'Credit Card',
          selected: _paymentMethod == PaymentMethod.creditCard,
          onTap: () => setState(() => _paymentMethod = PaymentMethod.creditCard),
          trailing: TextButton.icon(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            icon: const Icon(Icons.add_circle, color: kTeal, size: 18),
            label: const Text(
              'Add new Card',
              style: TextStyle(
                color: kTeal,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        _PaymentOptionRow(
          label: 'Cash',
          selected: _paymentMethod == PaymentMethod.cash,
          onTap: () => setState(() => _paymentMethod = PaymentMethod.cash),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Use My Wallet',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: kDarkText,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Wallet balance: EGP ${_walletBalance.toStringAsFixed(0)}',
                    style: const TextStyle(fontSize: 12, color: kGrey),
                  ),
                ],
              ),
            ),
            Switch.adaptive(
              value: _useWallet,
              activeColor: kTeal,
              onChanged: (val) => setState(() => _useWallet = val),
            ),
          ],
        ),
      ],
    );
  }

  // ----------------------------- PROMO CODE ---------------------------------

  Widget _buildPromoField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: kLightDivider),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _promoController,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _applyPromo(),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Type your Promo Code here',
                    hintStyle: TextStyle(color: kGrey, fontSize: 13),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _applyPromo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kTeal,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                child: const Text(
                  'Apply',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
        if (_promoMessage != null) ...[
          const SizedBox(height: 6),
          Text(
            _promoMessage!,
            style: TextStyle(
              fontSize: 12,
              color: _promoDiscount > 0 ? kTeal : Colors.redAccent,
            ),
          ),
        ],
      ],
    );
  }

  // --------------------------- ORDER SUMMARY CARD ---------------------------

  Widget _buildOrderSummaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Info',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: kDarkText,
            ),
          ),
          const SizedBox(height: 16),
          _summaryRow('Subtotal', _egp(_subtotal, prefix: 'EGP')),
          const SizedBox(height: 10),
          _summaryRow('Shipping Cost', _egp(_shippingCost)),
          const SizedBox(height: 14),
          Divider(height: 1, thickness: 1, color: kLightDivider),
          const SizedBox(height: 14),
          //_summaryRow('Total Cost', _egp(_totalCost)),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text(
                    'Total Cost',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: kDarkText,
                    ),
                  ),
                  Text(
                _egp(_grandTotal),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kDarkText,
                ),
              ),
             ],
           ),
              
          const SizedBox(height: 10),
          _summaryRow('Promo Code', _egp(-_promoDiscount, prefix: 'EGP')),
          const SizedBox(height: 10),
          _summaryRow('Wallet Balance', _egp(-_walletDeduction)),
          const SizedBox(height: 14),
          Divider(height: 1, thickness: 1, color: kLightDivider),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Grand Total',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: kDarkText,
                ),
              ),
              Text(
                _egp(_grandTotal),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kDarkText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, color: kGrey)),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            color: kDarkText,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // ---------------------------- CHECKOUT BUTTON -----------------------------

  Widget _buildCheckoutButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          HapticFeedback.lightImpact();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Order placed • ${_egp(_grandTotal)}'),
              backgroundColor: kTeal,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: kTeal,
          foregroundColor: Colors.white,
          elevation: 4,
          shadowColor: kTeal.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(
          'Check-Out',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// PRODUCT CARD WIDGET
// ---------------------------------------------------------------------------

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
    required this.egpFormatter,
  });

  final OrderItemModel item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onDelete;
  final String Function(double, {String prefix}) egpFormatter;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.network(
            item.imageUrl,
            width: 84,
            height: 84,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              width: 84,
              height: 84,
              color: const Color(0xFFF1F1F1),
              child: const Icon(Icons.image_outlined, color: kGrey),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name + Size row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: kDarkText,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  item.sizeIsBadge
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: kTeal,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            item.size,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : Text(
                          item.size,
                          style: const TextStyle(
                            color: kGrey,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                egpFormatter(item.price),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: kDarkText,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _qtyIconButton(
                    icon: Icons.remove,
                    background: const Color(0xFFF1F1F1),
                    iconColor: kGrey,
                    onTap: onDecrement,
                  ),
                  SizedBox(
                    width: 30,
                    child: Text(
                      '${item.quantity}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: kDarkText,
                      ),
                    ),
                  ),
                  _qtyIconButton(
                    icon: Icons.keyboard_arrow_up_rounded,
                    background: kTeal,
                    iconColor: Colors.white,
                    onTap: onIncrement,
                  ),
                  const Spacer(),
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: onDelete,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        border: Border.all(color: kLightDivider),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.delete_outline,
                        size: 16,
                        color: kGrey,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _qtyIconButton({
    required IconData icon,
    required Color background,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16, color: iconColor),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// PAYMENT OPTION ROW (custom radio row)
// ---------------------------------------------------------------------------

class _PaymentOptionRow extends StatelessWidget {
  const _PaymentOptionRow({
    required this.label,
    required this.selected,
    required this.onTap,
    this.trailing,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            _RadioDot(selected: selected),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: kDarkText,
              ),
            ),
            const Spacer(),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

class _RadioDot extends StatelessWidget {
  const _RadioDot({required this.selected});
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? kTeal : kGrey.withOpacity(0.6),
          width: 2,
        ),
      ),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          width: selected ? 10 : 0,
          height: selected ? 10 : 0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: kTeal,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// FAKE MAP GRID PAINTER (decorative, no external map dependency needed)
// ---------------------------------------------------------------------------

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..strokeWidth = 1;

    const gap = 24.0;
    for (double x = 0; x < size.width; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += gap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // A couple of faux "roads"
    final roadPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(0, size.height * 0.35),
      Offset(size.width, size.height * 0.55),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.65, 0),
      Offset(size.width * 0.4, size.height),
      roadPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}