import 'package:flutter/material.dart';
import 'package:project/colors.dart';

/// =====================================================
/// MODEL — Firebase ready
/// =====================================================
/// Represents a single review. Later this can be built directly
/// from a Firestore document snapshot without touching the UI:
///
/// ReviewModel.fromMap(doc.data())
class ReviewModel {
  final String image;
  final String name;
  final String date;
  final double rating;
  final String review;

  const ReviewModel({
    required this.image,
    required this.name,
    required this.date,
    required this.rating,
    required this.review,
  });

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      image: map['image'] as String? ?? '',
      name: map['name'] as String? ?? '',
      date: map['date'] as String? ?? '',
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      review: map['review'] as String? ?? '',
    );
  }
}

/// =====================================================
/// REVIEWS SCREEN
/// =====================================================
/// Fully responsive "Reviews" screen. Card height grows naturally
/// with review text length (1 to N lines) — no fixed dimensions,
/// no overflow, no clipping. Ready to be wired to a Firestore
/// stream by simply swapping out [_reviews].
class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  // ---------------------------------------------------
  // Static review data (swap for a Firestore stream later)
  // ---------------------------------------------------
  final List<ReviewModel> _reviews = const [
    ReviewModel(
      image: 'images/seif.jpg',
      name: 'Ronald Richard',
      date: '13 Sep, 2020',
      rating: 4.0,
      review: 'Lorem ipsum dolor sit amet, consectetur',
    ),
    ReviewModel(
      image: 'images/seif.jpg',
      name: 'Alex mack',
      date: '13 Sep, 2020',
      rating: 4.0,
      review: 'Lorem ipsum dolor sit amet, consectetur',
    ),
    ReviewModel(
      image: 'images/seif.jpg',
      name: 'Mr.smile',
      date: '13 Sep, 2020',
      rating: 4.0,
      review: 'Lorem ipsum dolor sit amet, consectetur',
    ),
    ReviewModel(
      image: 'images/seif.jpg',
      name: 'the Boss',
      date: '13 Sep, 2020',
      rating: 4.0,
      review: 'Lorem ipsum dolor sit amet, consectetur',
    ),
  ];

  // ---------------------------------------------------
  // Shared spacing / color tokens
  // ---------------------------------------------------
  static const double _horizontalPadding = 20;
  static const double _avatarToContentGap = 14;
  static const double _cardGap = 22;
  static const double _titleToSummaryGap = 10;
  static const double _summaryToListGap = 24;
  static const double _nameToDateGap = 4;
  static const double _rowToTextGap = 10;
  static const double _avatarRadius = 26;

  static const Color _darkGrey = Color(0xFF666666);
  static const Color _dateGrey = Color(0xFF9E9E9E);
  static const Color _ratingLabelGrey = Color(0xFFA0A0A0);
  static const Color _nameColor = Color(0xFF222222);
  static const Color _ratingColor = Color(0xFF222222);
  static const Color _reviewTextColor = Color(0xFF8F959E);
  static const Color _starYellow = Colors.amberAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // LayoutBuilder + centered constrained width keeps the design
        // identical on phones while preventing over-stretching on tablets.
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double maxContentWidth =
                constraints.maxWidth > 700 ? 700 : constraints.maxWidth;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxContentWidth),
                child: Column(
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: _summaryToListGap),
                    Expanded(child: _buildReviewList()),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // =====================================================
  // HEADER SECTION
  // =====================================================
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        _horizontalPadding,
        8,
        _horizontalPadding,
        0,
      ),
      child: Column(
        children: [
          // Back arrow (left) + centered title.
          Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
              ),
              const Text(
                'Reviews',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: _titleToSummaryGap),
          // Total review count.
          const Text(
            '500 Reviews',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          const SizedBox(height: 6),
          // Average rating + single star.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                '4.0',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.star, color: Colors.amberAccent, size: 16),
            ],
          ),
        ],
      ),
    );
  }

  // =====================================================
  // REVIEW LIST — ListView.builder, dynamic card height
  // =====================================================
  Widget _buildReviewList() {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
      itemCount: _reviews.length,
      separatorBuilder: (_, __) => const SizedBox(height: _cardGap),
      itemBuilder: (context, index) => _buildReviewCard(_reviews[index]),
    );
  }

  // =====================================================
  // SINGLE REVIEW CARD
  // =====================================================
  /// Layout:
  ///  [avatar] [name / date]              [4.0 rating / stars]
  ///           [review text — aligned with name, NOT the avatar]
  Widget _buildReviewCard(ReviewModel review) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LEFT: avatar.
            CircleAvatar(
              radius: _avatarRadius,
              backgroundColor: const Color(0xFFF1F3F4),
              backgroundImage: AssetImage(review.image),
            ),
            const SizedBox(width: _avatarToContentGap),

            // CENTER: name, date, then review text underneath —
            // all sharing the same left edge as the name.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _nameColor,
                    ),
                  ),
                  const SizedBox(height: _nameToDateGap),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.access_time_rounded,
                        size: 13,
                        color: _dateGrey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        review.date,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: _dateGrey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: _rowToTextGap),
                  // Review text: no maxLines/ellipsis, wraps freely
                  // so the card grows to fit any length from Firebase.
                  Text(
                    review.review,
                    softWrap: true,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w400,
                      color: _reviewTextColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // RIGHT: rating value, label, and stars — pinned to the
            // top-right and unaffected by review text length.
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      review.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _ratingColor,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'rating',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: _ratingLabelGrey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                _buildRating(review.rating),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // =====================================================
  // 5-STAR RATING ROW (fills full/empty stars based on value)
  // =====================================================
  Widget _buildRating(double rating) {
    final int fullStars = rating.round().clamp(0, 5);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final bool isFilled = index < fullStars;
        return Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Icon(
            Icons.star,
            size: 13,
            color: isFilled ? _starYellow : const Color(0xFFE0E0E0),
          ),
        );
      }),
    );
  }
}