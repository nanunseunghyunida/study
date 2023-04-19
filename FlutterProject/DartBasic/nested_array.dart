void main() {
  var nestedArr = [
    1,
    [
      2,
      [
        3,
        [
          4,
          [5, 6],
          7
        ],
        8
      ],
      9
    ],
    10
  ];

  List<int> flatArr(List<dynamic> arr) {
    List<int> answer = [];

    for (int i = 0; i < arr.length; i++) {
      if (arr[i] is int) {
        answer.add(arr[i]);
      } else {
        answer += flatArr(arr[i]);
      }
    }
    return answer;
  }

  print(flatArr(nestedArr));
}
