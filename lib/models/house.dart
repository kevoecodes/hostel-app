class House {
  String name;
  String address;
  String imageUrl;
  String descriptions, bed_description, bathroom_description;
  double price;
  int sq_feet;

  House(this.name, this.address, this.imageUrl, this.descriptions, this.price,
      this.sq_feet, this.bed_description, this.bathroom_description);

  static List<House> generateRecommended() {
    return [
      House(
          'Durban Hostel',
          'Kariakoo, Daresalaam',
          'assets/images/image_2.jpeg',
          'Descriptions',
          35000.00,
          100,
          '2 Beds (Doubledeckers)',
          '1 Bathroom'),
      House(
          'Al Uruba Hostel',
          'Kariakoo, Daresalaam',
          'assets/images/image_1.jpeg',
          'Descriptions',
          35000.00,
          500,
          '2 Beds (Doubledeckers)',
          '1 Bathroom'),
    ];
  }

  static List<House> generateBestOffer() {
    return [
      House(
          'Durban hostel',
          'Kariakoo, Daresalaam',
          'assets/images/image_2.jpeg',
          'Descriptions',
          35000.00,
          300,
          '2 Beds (Doubledeckers)',
          '1 Bathroom'),
      House(
          'Al Uruba Hostel',
          'Kariakoo, Daresalaam',
          'assets/images/image_3.jpeg',
          'Descriptions',
          35000.00,
          230,
          '2 Beds (Doubledeckers)',
          '1 Bathroom'),
    ];
  }
}
