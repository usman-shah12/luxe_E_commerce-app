class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String avatar;
  final String address;
  final String city;
  final String country;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatar,
    required this.address,
    required this.city,
    required this.country,
  });

  static UserModel get dummy => UserModel(
        id: 'u001',
        name: 'Alex Morgan',
        email: 'alex.morgan@email.com',
        phone: '+1 (555) 012-3456',
        avatar: 'https://i.pravatar.cc/300?img=11',
        address: '123 Luxury Avenue, Suite 4B',
        city: 'New York',
        country: 'United States',
      );
}
