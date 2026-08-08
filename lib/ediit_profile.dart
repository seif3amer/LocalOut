import 'package:flutter/material.dart';
import 'package:project/colors.dart';

class EdiitProfile extends StatefulWidget {
  const EdiitProfile({super.key});

  @override
  State<EdiitProfile> createState() => _EdiitProfileState();
}

class _EdiitProfileState extends State<EdiitProfile> {
  static const Color _backgroundColor = Color(0xFFF5F5F7);
  static const Color _borderColor = Color(0xFFD9D9D9);
  static const TextStyle _labelStyle = TextStyle(
    fontSize: 13,
    color: Colors.grey,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle _valueStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  // -----------------------------------------------------------------
  // FocusNode لكل فيلد عشان نعرف وقت الكتابة (focus) ونغيّر لون
  // الخلفية زي فيلد الإيميل المرجعي بالظبط.
  // -----------------------------------------------------------------
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    for (final node in [
      _firstNameFocusNode,
      _lastNameFocusNode,
      _emailFocusNode,
      _phoneFocusNode,
    ]) {
      node.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  InputDecoration _fieldDecoration(String hintText, FocusNode focusNode) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: _valueStyle,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      filled: true,
      // لون الخلفية بيتغير حسب حالة الـ focus زي فيلد الإيميل المرجعي:
      // لون وقت الكتابة، ولون تاني وهو مش متفوكس.
      fillColor: focusNode.hasFocus ? AppColors.fieldFocus : Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: _borderColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: AppColors.tealGray, width: 1.2),
      ),
    );
  }

  Widget _buildLabeledField({
    required String label,
    required String initialValue,
    required FocusNode focusNode,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(label, style: _labelStyle),
        ),
        TextFormField(
          focusNode: focusNode,
          cursorColor: AppColors.tealGray,
          cursorWidth: 1.5,
          initialValue: initialValue,
          keyboardType: keyboardType,
          style: _valueStyle,
          decoration: _fieldDecoration(initialValue, focusNode),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Editing Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxContentWidth =
                constraints.maxWidth > 700 ? 700.0 : constraints.maxWidth;
            final avatarRadius = (constraints.maxWidth * 0.16).clamp(
              48.0,
              70.0,
            );

            return SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: maxContentWidth,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      CircleAvatar(
                        radius: avatarRadius,
                        backgroundColor: const Color(0xFFF1D9CC),
                        backgroundImage: const AssetImage('images/seif.jpg'),
                      ),
                      const SizedBox(height: 32),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// First & Last Name
                            Row(
                              children: [
                                Expanded(
                                  child: _buildLabeledField(
                                    label: 'First Name',
                                    initialValue: 'Ahmed',
                                    focusNode: _firstNameFocusNode,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _buildLabeledField(
                                    label: 'Last Name',
                                    initialValue: 'Mohamed',
                                    focusNode: _lastNameFocusNode,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            /// Email
                            _buildLabeledField(
                              label: 'Email',
                              initialValue: 'Ahmed.30J@gmail.com',
                              keyboardType: TextInputType.emailAddress,
                              focusNode: _emailFocusNode,
                            ),
                            const SizedBox(height: 20),

                            /// Phone Number
                            _buildLabeledField(
                              label: 'Phone Number',
                              initialValue: '+20 01024836984',
                              keyboardType: TextInputType.phone,
                              focusNode: _phoneFocusNode,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}