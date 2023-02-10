void main() {
  // 1. List
  List<int> nums = [1, 2, 3, 4, 5];
  var nums2 = [2, 3, 4, 5, 6];
  // 1-1. Collection if
  var giveMeFive = true;
  var nums3 = [
    1,
    2,
    if (giveMeFive) 5,
  ];

  // 2. String Interpolation
  var name = "shjeong";
  var age = 10;
  var greeting = "Hello everyone, my name is $name and I'm ${age + 2}";
  print(greeting);

  // 3. Collection for
  var oldFriends = ['nico', 'lyn'];
  var newFriends = [
    'aaa',
    'bbb',
    'ccc',
    for (var friend in oldFriends) '@$friend'
  ];
  print(newFriends);

  // 4. Maps
  var player = {
    "name": "shjeong",
    "xp": 123,
    "power": false,
  };
  // Map<String, Object> : Object is Any in Typescript

  // 5. Set
  // List와 Set의 차이점은 Set에 있는 값들은 항상 Unique 하다. (중복 x)
  var numbers = {1, 2, 3, 4};
}
