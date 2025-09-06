class User {
  String username;
  String referralCode;
  String referralLink;
  String? referredBy;
  int referralCount;
  String email;
  String? firstName;
  String? lastName;
  String? phone;
  String? dob;
  String gender;
  String country;
  String? profilePicture;
  int xp;
  int dailyStreak;
  int level;
  int hearts;
  int gem;
  List<dynamic> discounts;

  User({
    required this.username,
    required this.referralCode,
    required this.referralLink,
    this.referredBy,
    required this.referralCount,
    required this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.dob,
    required this.gender,
    required this.country,
    this.profilePicture,
    required this.xp,
    required this.dailyStreak,
    required this.level,
    required this.hearts,
    required this.gem,
    required this.discounts,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      referralCode: json['referral_code'],
      referralLink: json['referral_link'],
      referredBy: json['referred_by'],
      referralCount: json['referral_count'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phone: json['phone'],
      dob: json['dob'],
      gender: json['gender'],
      country: json['country'],
      profilePicture: json['profile_picture'],
      xp: json['xp'],
      dailyStreak: json['daily_streak'],
      level: json['level'],
      hearts: json['hearts'],
      gem: json['gem'],
      discounts: List<dynamic>.from(json['discounts']),
    );
  }

  get dateOfBirth => null;

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'referral_code': referralCode,
      'referral_link': referralLink,
      'referred_by': referredBy,
      'referral_count': referralCount,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'dob': dob,
      'gender': gender,
      'country': country,
      'profile_picture': profilePicture,
      'xp': xp,
      'daily_streak': dailyStreak,
      'level': level,
      'hearts': hearts,
      'gem': gem,
      'discounts': discounts,
    };
  }
}
