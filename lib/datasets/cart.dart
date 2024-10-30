class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

final List<MenuItem> dummyMenuItems = [
  MenuItem(
    id: '1',
    name: 'Burger',
    description: 'A delicious beef burger with lettuce and tomato',
    price: 5.99,
    imageUrl:
        'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg',
  ),
  MenuItem(
    id: '2',
    name: 'Pizza',
    description: 'Cheese pizza with extra toppings',
    price: 7.99,
    imageUrl:
        'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg',
  ),
  MenuItem(
    id: '3',
    name: 'Dhokla',
    description: 'Creamy Alfredo pasta with chicken',
    price: 6.49,
    imageUrl:
        'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg',
  ),
  MenuItem(
    id: '3',
    name: 'Thepla',
    description: 'Creamy Alfredo pasta with chicken',
    price: 6.49,
    imageUrl:
        'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg',
  ),
  MenuItem(
    id: '3',
    name: 'Puff',
    description: 'Creamy Alfredo pasta with chicken',
    price: 6.49,
    imageUrl:
        'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg',
  ),
  MenuItem(
    id: '3',
    name: 'maggie',
    description: 'Creamy Alfredo pasta with chicken',
    price: 6.49,
    imageUrl:
        'https://images.pexels.com/photos/376464/pexels-photo-376464.jpeg',
  ),
];
