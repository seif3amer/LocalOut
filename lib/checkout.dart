import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/colors.dart';
import 'package:dotted_line/dotted_line.dart'; // تأكد من إضافة البكج في الـ pubspec.yaml
// DottedTopCard معرفة أصلاً في ملف الكارت — بنستوردها من هناك بدل ما نكررها.
// لو اسم الملف عندك مختلف، غير المسار ده بس.
import 'package:project/cart_screen.dart' show DottedTopCard;

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // -----------------------------------------------------------------
  // بيانات المنتجات — نفس فكرة الكارت، كل منتج له كميته الخاصة.
  // -----------------------------------------------------------------
  final List<_CartItem> _items = [
    _CartItem(
      image: 'images/Tshirt.png',
      name: "Men's Tie-Dye T-Shirt\nNike Sportswear",
      price: 450,
      size: 'L',
      quantity: 1,
    ),
    _CartItem(
      image: 'images/Tshirt.png',
      name: "Men's Tie-Dye T-Shirt\nNike Sportswear",
      price: 250,
      size: 'XL',
      quantity: 1,
    ),
  ];


  final TextEditingController _promoController = TextEditingController();

  // -----------------------------------------------------------------
  // Contact Information — Controllers علشان نقدر نعدل القيم ونحدث
  // العرض في الكارت بعد الحفظ. الـ bool بتحدد لو الحقل في وضع التعديل
  // (Inline) عشان الكتابة تتم في نفس مكان القيمة مباشرة.
  // -----------------------------------------------------------------
  final TextEditingController _emailController =
      TextEditingController(text: 'rumenhussen@gmail.com');
  final TextEditingController _phoneController =
      TextEditingController(text: '+88-692-764-269');
  bool _isEditingEmail = false;
  bool _isEditingPhone = false;
  final FocusNode _emailEditFocusNode = FocusNode();
  final FocusNode _phoneEditFocusNode = FocusNode();

  static const double _subtotal = 700;
  static const double _shippingCost = 100;
  static const double _promoDiscount = 60;
  static const double _walletBalance = 50;
  static const double _totalCost = _subtotal + _shippingCost;
  static const double _grandTotal = _totalCost - _promoDiscount - _walletBalance;

  @override
  void dispose() {
    _promoController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _emailEditFocusNode.dispose();
    _phoneEditFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        centerTitle: true,
        leading: const Icon(Icons.arrow_back_ios),
        title: const Text(
          'Checkout',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: AppColors.background),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _buildSectionTitle('Order Items'),
              const SizedBox(height: 8),
              ...List.generate(_items.length, (index) => _buildItemCard(index)),
              const SizedBox(height: 16),
              _buildSectionTitle('Address'),
              const SizedBox(height: 10),
              _buildAddressCard(),
              const SizedBox(height: 20),
              _buildSectionTitle('Contact Information'),
              const SizedBox(height: 10),
              _buildContactCard(),
              const SizedBox(height: 20),

              // اللوحة الرمادية اللي فيها الدفع، البرومو كود، وملخص الأوردر
              // — الكارت المنقط بيبان عايم فوقها بالظبط زي التصميم.
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                decoration: const BoxDecoration(
                  color: Color(0xFFEDEDED),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Payment Method'),
                    const SizedBox(height: 14),
                    _buildPaymentMethodCard(),
                    const SizedBox(height: 20),
                    _buildSectionTitle('Promo Code'),
                    const SizedBox(height: 10),
                    _buildPromoCodeField(),
                    const SizedBox(height: 20),
                    _buildOrderInfoCard(),
                  ],
                ),
              ),

              _buildCheckoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  // =====================================================
  // كارت منتج — المقاس ملزوز في الزاوية العلوية اليمين للكارت،
  // وسلة الزبالة ملزوزة في الزاوية السفلية اليمين، بنفس فكرة شاشة الكارت.
  // =====================================================
  Widget _buildItemCard(int index) {
    final _CartItem item = _items[index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color.fromARGB(164, 255, 255, 255),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    item.image,
                    width: 85,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black, height: 1.3),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'L.E ${item.price.toStringAsFixed(0)}',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(Icons.remove, color: Colors.grey, size: 18),
                                  onPressed: () {
                                    setState(() {
                                      if (item.quantity > 1) item.quantity--;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text('${item.quantity}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              const SizedBox(width: 16),
                              Container(
                                width: 36,
                                height: 36,
                                decoration: const BoxDecoration(color: AppColors.tealGray, shape: BoxShape.circle),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 24),
                                  onPressed: () {
                                    setState(() {
                                      item.quantity++;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // عمود يمين فاضي بس عشان يحجز المسافة؛ المقاس والزبالة
                      // بقوا Positioned فوق الكارت كله.
                      const SizedBox(width: 32, height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // المقاس ملزوز في زاوية الكارت العلوية اليمين (top:0, right:0 = حافة الكارت الحقيقية)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 32,
              height: 34,
              decoration: const BoxDecoration(
                color: AppColors.tealGray,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Center(
                child: Text(item.size, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ),
          ),

          // سلة الزبالة ملزوزة في زاوية الكارت السفلية اليمين
          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  setState(() => _items.removeAt(index));
                },
                icon: SvgPicture.asset('icons/trash.svg', width: 24, height: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // كارت العنوان + خريطة (Placeholder — استبدلها بـ Google Maps لو
  // البروجيكت عندك مربوط بيه فعلياً)
  // =====================================================
  Widget _buildAddressCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color.fromARGB(164, 255, 255, 255),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                // TODO: افتح شاشة تعديل/اختيار العنوان
              },
              child: Row(
                children: const [
                  Expanded(
                    child: Text(
                      'Newahall St 36, London, 12908 - UK',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded, color: Colors.black45),
                ],
              ),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                width: double.infinity,
                height: 130,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // خلفية الخريطة — غيّرها لصورة خريطة فعلية أو ودجت
                    // Google Maps لو متاح في البروجيكت.
                    Container(color: const Color(0xFFE4E9EC)),
                    Icon(Icons.location_on, color: AppColors.tealGray, size: 34),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // كارت معلومات التواصل
  // =====================================================
  Widget _buildContactCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color.fromARGB(164, 255, 255, 255),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            _buildContactRow(
              icon: SvgPicture.asset("icons/email.svg"),
              label: 'Email',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              isEditing: _isEditingEmail,
              editFocusNode: _emailEditFocusNode,
              onEditToggle: () => _toggleEdit(isEmail: true),
            ),
            const SizedBox(height: 16),
            _buildContactRow(
              icon: SvgPicture.asset("icons/phone.svg"),
              label: 'Phone',
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              isEditing: _isEditingPhone,
              editFocusNode: _phoneEditFocusNode,
              onEditToggle: () => _toggleEdit(isEmail: false),
            ),
          ],
        ),
      ),
    );
  }

  // ملحوظة: icon بقى Widget (SvgPicture) مش IconData. الفيلد ده بقى
  // بيدعم التعديل Inline: لما isEditing = true، مكان القيمة نفسه بيتحول
  // لـ TextField تقدر تكتب فيه مباشرة بدل ما يفتح Dialog منفصل.
  Widget _buildContactRow({
    required Widget icon,
    required String label,
    required TextEditingController controller,
    required TextInputType keyboardType,
    required bool isEditing,
    required FocusNode editFocusNode,
    required VoidCallback onEditToggle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 22, height: 22, child: icon),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
              const SizedBox(height: 2),
              isEditing
                  ? TextField(
                      controller: controller,
                      focusNode: editFocusNode,
                      keyboardType: keyboardType,
                      autofocus: true,
                      cursorColor: AppColors.tealGray,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.tealGray)),
                        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.tealGray, width: 1.5)),
                      ),
                      onSubmitted: (_) => onEditToggle(),
                    )
                  : Text(
                      controller.text,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black),
                    ),
            ],
          ),
        ),
        IconButton(
          onPressed: onEditToggle,
          icon: isEditing
              ? const Icon(Icons.check, color: AppColors.tealGray)
              : SvgPicture.asset("icons/edit.svg"),
        ),
      ],
    );
  }

  // بتفتح/تقفل وضع التعديل Inline لحقل الإيميل أو التليفون. لما تقفل
  // وضع التعديل (يعني بعد الحفظ)، الـ TextField هيرجع Text عادي بالقيمة
  // الجديدة اللي كتبتها في نفس المكان.
  void _toggleEdit({required bool isEmail}) {
    setState(() {
      if (isEmail) {
        _isEditingEmail = !_isEditingEmail;
        if (_isEditingEmail) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _emailEditFocusNode.requestFocus();
          });
        }
      } else {
        _isEditingPhone = !_isEditingPhone;
        if (_isEditingPhone) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _phoneEditFocusNode.requestFocus();
          });
        }
      }
    });
  }

  // =====================================================
  // كارت طريقة الدفع — Cash هي الطريقة الوحيدة المتاحة حالياً، فمفيش
  // أي اختيار أو Radio buttons.
  // =====================================================
  Widget _buildPaymentMethodCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color.fromARGB(164, 255, 255, 255),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const Icon(Icons.money, color: AppColors.tealGray, size: 22),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Cash',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // فيلد كود الخصم — نفس شكل فيلد الإيميل المرجعي، لكن مع كلمة
  // Apply جوه الـ TextField نفسه باستخدام suffixIcon.
  // =====================================================
  Widget _buildPromoCodeField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: TextField(
          controller: _promoController,
          cursorColor: AppColors.tealGray,
          decoration: InputDecoration(
            hintText: 'Type your Promo Code here',
            hintStyle: const TextStyle(
              color: Color(0xFFCCCCCC),
              fontSize: 14,
            ),
            filled: true,
            fillColor: const Color(0xFFF5F5F5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: AppColors.tealGray,
                width: 1.5,
              ),
            ),
            suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                widthFactor: 1,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _applyPromoCode,
                  child: const Text(
                    'Apply',
                    style: TextStyle(
                      color: AppColors.tealGray,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // لوجيك تطبيق كود الخصم — استبدلها بالتحقق الفعلي عبر الـ API لو متاح.
  void _applyPromoCode() {
    final String code = _promoController.text.trim();

    if (code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a promo code')),
      );
      return;
    }

    // TODO: نادِ هنا على الـ API/اللوجيك الفعلي للتحقق من الكود وتحديث
    // قيمة الخصم (_promoDiscount) لو مطلوب.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Promo code "$code" applied')),
    );
  }

  // =====================================================
  // كارت ملخص الأوردر — بنعيد استخدام DottedTopCard من شاشة الكارت.
  // الخطين اللي تحت السطور بقوا منقطين (DottedLine) بدل Divider عادي.
  // =====================================================
  Widget _buildOrderInfoCard() {
    return DottedTopCard(
      radius: 24,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Order Info', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 16),
            _buildInfoRow('Subtotal', 'EGP ${_subtotal.toStringAsFixed(0)}'),
            const SizedBox(height: 12),
            _buildInfoRow('Shipping cost', 'L.E ${_shippingCost.toStringAsFixed(0)}'),
            const SizedBox(height: 16),
            _buildDottedDivider(),
            const SizedBox(height: 16),
            _buildInfoRow('Total Cost', 'L.E ${_totalCost.toStringAsFixed(0)}', bold: true),
            const SizedBox(height: 12),
            _buildInfoRow('Promo code', '-EGP ${_promoDiscount.toStringAsFixed(0)}'),
            const SizedBox(height: 12),
            _buildInfoRow('Wallet Balance', '-L.E ${_walletBalance.toStringAsFixed(0)}'),
            const SizedBox(height: 16),
            _buildDottedDivider(),
            const SizedBox(height: 16),
            _buildInfoRow('Grand Total', 'L.E ${_grandTotal.toStringAsFixed(0)}', bold: true, big: true),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  // خط منقط بديل الـ Divider العادي — بنفس ستايل الخط المنقط المستخدم
  // في شاشة الكارت (dotted_line package).
  Widget _buildDottedDivider() {
    return DottedLine(
      direction: Axis.horizontal,
      lineLength: double.infinity,
      lineThickness: 1.5,
      dashLength: 4.0,
      dashColor: Colors.grey[300]!,
      dashGapLength: 4.0,
    );
  }

  Widget _buildInfoRow(String label, String value, {bool bold = false, bool big = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: bold ? 18 : 15,
            fontWeight: bold ? FontWeight.bold : FontWeight.w400,
            color: bold ? Colors.black : Colors.grey[500],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: big ? 20 : (bold ? 18 : 15),
            fontWeight: bold ? FontWeight.bold : FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  // =====================================================
  // زرار Check-Out الثابت تحت
  // =====================================================
  Widget _buildCheckoutButton() {
    return Container(
      color: const Color(0xFFEDEDED),
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 8),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.tealGray,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 0,
          ),
          onPressed: () {
            // TODO: أكشن تنفيذ الأوردر
          },
          child: const Text(
            'Check-Out',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

/// موديل بسيط لعنصر في الكارت — كل عنصر له كميته الخاصة بدل متغير واحد
/// مشترك زي الكود الأصلي.
class _CartItem {
  final String image;
  final String name;
  final double price;
  final String size;
  int quantity;

  _CartItem({
    required this.image,
    required this.name,
    required this.price,
    required this.size,
    required this.quantity,
  });
}