class ReviewModel {
  final String name;
  final String designation;
  final String image;
  final String review;
  final double rating;

  const ReviewModel({
    required this.name,
    required this.designation,
    required this.image,
    required this.review,
    required this.rating,
  });
}

const List<ReviewModel> reviews = [

  ReviewModel(
    name: 'Rahul Kumar',
    designation: 'Verified Buyer',
    image: 'assets/images/reviews/user1.png',
    rating: 5,
    review:
        'I purchased the Real Madrid home jersey and honestly the quality exceeded every expectation. The fabric feels breathable, the stitching is excellent, and the fit is exactly as described. Delivery arrived before the expected date and the packaging looked premium. I will definitely purchase more jerseys from LAG Clothing in the future.',
  ),

  ReviewModel(
    name: 'Arjun Sharma',
    designation: 'Verified Buyer',
    image: 'assets/images/reviews/user2.png',
    rating: 5,
    review:
        'The jersey looks exactly like the original club edition. The print quality, collar finish, and material feel amazing. Even after washing multiple times, the colours remained vibrant without fading. Customer support responded quickly to my questions. Overall, I am extremely satisfied with my purchase and highly recommend this store.',
  ),

  ReviewModel(
    name: 'Mohammed Ameen',
    designation: 'Verified Buyer',
    image: 'assets/images/reviews/user3.png',
    rating: 5,
    review:
        'I have ordered football jerseys from several online stores, but LAG Clothing has delivered the best quality so far. The jersey feels lightweight, comfortable, and perfect for both matches and casual wear. Fast delivery, secure packaging, and premium finishing make this brand stand out from others.',
  ),

  ReviewModel(
    name: 'Kiran Prasad',
    designation: 'Verified Buyer',
    image: 'assets/images/reviews/user4.png',
    rating: 5,
    review:
        'The jersey perfectly matched the product images shown on the website. The fabric quality, sleeve stitching, and printed logo all feel premium. Shipping was smooth, and the order tracking kept me updated throughout. I am genuinely impressed and will be recommending LAG Clothing to my friends.',
  ),

];