class TestList {
  static List<Map<String, String>> notifications = [
    {
      'title': 'Special Offer',
      'message': 'Get 20% off on your next purchase!',
      'time': '2 hours ago',
    },
    {
      'title': 'Order Shipped',
      'message': 'Your order #123456 has been shipped.',
      'time': '5 hours ago',
    },
    {
      'title': 'Order Delivered',
      'message': 'Your order #123456 has been delivered.',
      'time': '2 days ago',
    },
    {
      'title': 'Flash Sale',
      'message': 'Hurry! Flash sale ends in 2 hours.',
      'time': '3 days ago',
    },
    {
      'title': 'New Arrivals',
      'message': 'Check out our new collection!',
      'time': '5 days ago',
    },
    {
      'title': 'Payment Received',
      'message': 'Your payment for order #123456 has been received.',
      'time': '1 week ago',
    },
    {
      'title': 'Exclusive Deal',
      'message': 'Exclusive deal for you: 30% off on selected items.',
      'time': '2 week ago',
    },
    
  ];
  ///// Cart

  static List<Map<String, dynamic>> cartItems = [
    

    {
      'name': 'Blue T-Shirt',
      'price': 25.99,
      'quantity': 2,
      'image': 'https://via.placeholder.com/150',
    },

 
    
   
    {
      'name': 'Black Jeans',
      'price': 45.99,
      'quantity': 1,
      'image': 'https://via.placeholder.com/150',
    },
    {
      'name': 'White Sneakers',
      'price': 60.00,
      'quantity': 1,
      'image': 'https://via.placeholder.com/150',
    },
   
  ];

  // Calculate the total price of the cart
  static double getTotalPrice() {
    double total = 0;
    for (var item in cartItems) {
      total += item['price'] * item['quantity'];
    }
    return total;
  }
   static Map<String, dynamic> order = {
    'id': '12345',
    'status': 'Delivered',
    'date': '2023-10-15',
    'items': [
      {
        'id': '1',
        'name': 'Product 1',
        'price': 29.99,
        'quantity': 2,
        'image': 'https://via.placeholder.com/150',
      },
      {
        'id': '2',
        'name': 'Product 2',
        'price': 49.99,
        'quantity': 1,
        'image': 'https://via.placeholder.com/150',
      },
    ],
    'total': 109.97,
  };


}
