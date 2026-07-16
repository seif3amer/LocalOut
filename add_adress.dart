import 'package:flutter/material.dart';
import 'package:project/colors.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final _nameController = TextEditingController();
  final _countryController = TextEditingController();
  final _cityController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  bool _saveAsPrimary = true;

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _countryFocusNode = FocusNode();
  final FocusNode _cityFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _addressFocusNode = FocusNode();

  static const Color _teal = AppColors.tealGray;
  static const Color _labelColor = Colors.black;

  @override
  void initState() {
    super.initState();
    for (final node in [
      _nameFocusNode,
      _countryFocusNode,
      _cityFocusNode,
      _phoneFocusNode,
      _addressFocusNode,
    ]) {
      node.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    _addressController.dispose();

    _nameFocusNode.dispose();
    _countryFocusNode.dispose();
    _cityFocusNode.dispose();
    _phoneFocusNode.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 2),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500, // Medium weights match the design
          color: _labelColor,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 52, // Accurate elevation matching height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        cursorColor: _teal,
        style: const TextStyle(fontSize: 15, color: Colors.black87),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color(0xFF9E9E9E),
            fontSize: 15,
          ),
          filled: true,
          fillColor: Colors.white, // Solid clean white backgrounds inside mockup
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFDCDCDC), width: 1.2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFDCDCDC), width: 1.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: _teal, width: 1.5),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB), // Matches image background tint
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBFBFB),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 22),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Address',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),

                // Name
                _buildLabel('Name'),
                _buildTextField(
                  controller: _nameController,
                  focusNode: _nameFocusNode,
                  hint: 'EX: Ahmed mohamed',
                ),
                const SizedBox(height: 24),

                // Country + City
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('Country'),
                          _buildTextField(
                            controller: _countryController,
                            focusNode: _countryFocusNode,
                            hint: 'Egypt',
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildLabel('City'),
                          _buildTextField(
                            controller: _cityController,
                            focusNode: _cityFocusNode,
                            hint: 'Cairo',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Phone Number
                _buildLabel('Phone Number'),
                _buildTextField(
                  controller: _phoneController,
                  focusNode: _phoneFocusNode,
                  hint: 'EX: +02 010*****874',
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 24),

                // Address
                _buildLabel('Address'),
                _buildTextField(
                  controller: _addressController,
                  focusNode: _addressFocusNode,
                  hint: 'EX: 1st street Zamalek',
                ),
                const SizedBox(height: 28),

                // Save as primary address toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Save as primary address',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                    Transform.scale(
                      scale: 0.9,
                      child: Switch(
                        value: _saveAsPrimary,
                        onChanged: (val) => setState(() => _saveAsPrimary = val),
                        activeColor: Colors.white,
                        activeTrackColor: _teal,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: const Color(0xFFE0E0E0),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Add Button
                Center(
                  child: SizedBox(
                    width: 165,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _teal,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}