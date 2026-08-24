import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';

void main() {
  print('--- 1. Array Reverse ---');
  print(reverseArray([1, 2, 3, 4, 5]));

  print('\n--- 2. Array Sorting ---');
  print(sortArray([5, 2, 8, 1, 9]));

  print('\n--- 3. String Reverse ---');
  print(reverseString("hello"));

  print('\n--- 4. String Palindrome ---');
  print(isPalindrome("madam"));
  print(isPalindrome("hello"));

  print('\n--- 5. Swap 2 variables without 3rd variable ---');
  swapWithoutThirdVariable(5, 10);

  print('\n--- 6. Highest number in array ---');
  print(getHighest([3, 7, 2, 9, 4]));

  print('\n--- 7. Lowest number in array ---');
  print(getLowest([3, 7, 2, 9, 4]));

  print('\n--- 8. Odd and Even numbers from array ---');
  print(getOddEven([1, 2, 3, 4, 5, 6]));

  print('\n--- 9. Remove duplicate words from a string ---');
  print(removeDuplicateWords("this is is a test test string"));

  print('\n--- 10. Find duplicate elements in array ---');
  print(findDuplicates([1, 2, 2, 3, 4, 4, 5]));

  print('\n--- 11. Factorial of a number ---');
  print(factorial(5));

  print('\n--- 12. Fibonacci series ---');
  print(fibonacci(10));

  print('\n--- 13. Check Prime number ---');
  print(isPrime(7));
  print(isPrime(8));

  print('\n--- 14. Count vowels in a string ---');
  print(countVowels("Hello World"));

  print('\n--- 15. Sum of array elements ---');
  print(sumArray([1, 2, 3, 4, 5]));

  print('\n--- 16. Second highest number ---');
  print(secondHighest([3, 7, 2, 9, 4]));

  print('\n--- 17. Check Anagram ---');
  print(isAnagram("listen", "silent"));

  print('\n--- 18. Two Sum Problem ---');
  print(twoSum([2, 7, 11, 15], 9));

  print('\n--- 19. Matrix Rotation (90 degrees) ---');
  print(rotateMatrix([
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
  ]));

  print('\n--- 20. Count occurrence of each character ---');
  print(countCharacters("banana"));

  print('\n--- 21. Missing number in array (1 to n) ---');
  print(findMissingNumber([1, 2, 4, 5, 6], 6));

  print('\n--- 22. Armstrong Number check ---');
  print(isArmstrong(153));

  print('\n--- 23. Star Pattern - Square ---');
  printSquarePattern(4);

  print('\n--- 24. Star Pattern - Right Triangle ---');
  printTrianglePattern(5);

  print('\n--- 25. Star Pattern - Pyramid ---');
  printPyramidPattern(5);

  print('\n--- 26. Star Pattern - Inverted Triangle ---');
  printInvertedTrianglePattern(5);

  print('\n--- 27. Number Pattern ---');
  printNumberPattern(5);

  print('\n--- 28. Diamond Pattern ---');
  printDiamondPattern(4);
}

// ============================================================
// 1. ARRAY REVERSE
// Logic: swap first and last, move towards center
// ============================================================
List<int> reverseArray(List<int> arr) {
  List<int> data=[];

  for(int i = arr.length-1; i>=0; i-- ){
    print(arr[i].toString());
    data.add(arr[i]);
  }
  return data;
}

// ============================================================
// 2. ARRAY SORTING (Bubble Sort - easiest to explain in interview)
// Logic: compare each pair, swap if wrong order, repeat
// ============================================================
List<int> sortArray(List<int> arr) {
  // print(sortArray([5, 2, 8, 1, 9]));
  int n = arr.length;

 for(int i=0; i < n -1; i++){
   for(int j=0; j < n-1-i; j++){
     if(arr[j]>arr[j+1]){
       int temp=arr[j];
       arr[j]=arr[j+1];
       arr[j+1]=temp;
     }
   }
 }
  return arr;
  // NOTE: In real projects just use arr.sort() (built-in, fast)
  // Interviewers ask manual sort to test your logic building.
}

// ============================================================
// 3. STRING REVERSE
// Logic: convert to list of characters, reverse, join back
// ============================================================
String reverseString(String str) {
  return str.split('').reversed.join('');

  // Manual way (without built-in reversed) - good to know too:
  // String result = '';
  // for (int i = str.length - 1; i >= 0; i--) {
  //   result += str[i];
  // }
  // return result;
}

// ============================================================
// 4. STRING PALINDROME
// Logic: a palindrome reads the same forward and backward
// ============================================================
bool isPalindrome(String str) {
  String reversed = str.split('').reversed.join('');
  return str == reversed;
}

// ============================================================
// 5. SWAP 2 VARIABLES WITHOUT USING A 3RD VARIABLE
// Logic: use arithmetic (+/-) or XOR trick
// ============================================================
void swapWithoutThirdVariable(int a, int b) {
  // swapWithoutThirdVariable(5, 10);
  print('Before: a=$a, b=$b');

  a = a + b; // a now holds sum of both
  b = a - b; // b becomes original a
  a = a - b; // a becomes original b

  print('After: a=$a, b=$b');

  // Alternative trick using XOR (only works for integers):
  // a = a ^ b;
  // b = a ^ b;
  // a = a ^ b;
}

// ============================================================
// 6. GET HIGHEST NUMBER IN ARRAY
// Logic: assume first element is highest, compare with rest
// ============================================================
int getHighest(List<int> arr) {
  // print(getHighest([3, 7, 2, 9, 4]));

  int highest = arr[0];
  for (int i = 1; i < arr.length; i++) {
    if (arr[i] > highest) {
      highest = arr[i];
    }
  }
  return highest;

  // Shortcut: arr.reduce((a, b) => a > b ? a : b);
}

// ============================================================
// 7. GET LOWEST NUMBER IN ARRAY
// Logic: same as above, but check for smaller values
// ============================================================
int getLowest(List<int> arr) {
  // print(getLowest([3, 7, 2, 9, 4]));
  int lowest = arr[0];
  for (int i = 1; i < arr.length; i++) {
    if (arr[i] < lowest) {
      lowest = arr[i];
    }
  }
  return lowest;

  // Shortcut: arr.reduce((a, b) => a < b ? a : b);
}

// ============================================================
// 8. GET ODD AND EVEN NUMBERS FROM ARRAY
// Logic: use modulo (%) operator, if remainder is 0 -> even
// ============================================================
Map<String, List<int>> getOddEven(List<int> arr) {
  List<int> odd = [];
  List<int> even = [];

  for (int num in arr) {
    if (num % 2 == 0) {
      even.add(num);
    } else {
      odd.add(num);
    }
  }

  return {'even': even, 'odd': odd};
}

// ============================================================
// 9. REMOVE DUPLICATE WORDS FROM A STRING
// Logic: split into words, use a Set (Set auto-removes duplicates)
// ============================================================
String removeDuplicateWords(String sentence) {
  List<String> words = sentence.split(' ');
  Set<String> uniqueWords = {}; // Set doesn't allow duplicates
  List<String> result = [];

  for (String word in words) {
    if (!uniqueWords.contains(word)) {
      uniqueWords.add(word);
      result.add(word);
    }
  }

  return result.join(' ');
}

// ============================================================
// 10. FIND DUPLICATE ELEMENTS IN ARRAY
// Logic: use a Map to count how many times each number appears
// ============================================================
List<int> findDuplicates(List<int> arr) {
  // print(findDuplicates([1, 2, 2, 3, 4, 4, 5]));
  final Set<int> seen = {};
   final  Set<int> duplicates = {};

  for (final num in arr) {
    if (!seen.add(num)) {
      duplicates.add(num);
    }
  }

  return duplicates.toList();

  // return duplicates;
}

// ============================================================
// 11. FACTORIAL OF A NUMBER
// Logic: n! = n * (n-1) * (n-2) * ... * 1
// Using simple recursion
// ============================================================
int factorial(int n) {
  if (n == 0 || n == 1) {
    return 1; // base case
  }
  return n * factorial(n - 1); // recursive call
}

// ============================================================
// 12. FIBONACCI SERIES
// Logic: each number is sum of previous two (0, 1, 1, 2, 3, 5...)
// ============================================================
List<int> fibonacci(int count) {
  List<int> series = [0, 1];

  for (int i = 2; i < count; i++) {
    series.add(series[i - 1] + series[i - 2]);
  }

  return series.sublist(0, count);
}

// ============================================================
// 13. CHECK PRIME NUMBER
// Logic: a prime number is only divisible by 1 and itself
// ============================================================
bool isPrime(int n) {
  if (n < 2) return false;

  for (int i = 2; i <= n ~/ 2; i++) {
    if (n % i == 0) {
      return false; // divisible by something else -> not prime
    }
  }
  return true;
}

// ============================================================
// 14. COUNT VOWELS IN A STRING
// Logic: loop through each character, check if it's a,e,i,o,u
// ============================================================
int countVowels(String str) {
  String vowels = 'aeiouAEIOU';
  int count = 0;

  for (int i = 0; i < str.length; i++) {
    if (vowels.contains(str[i])) {
      count++;
    }
  }

  return count;
}

// ============================================================
// 15. SUM OF ARRAY ELEMENTS
// Logic: simple loop, add each number to a total
// ============================================================
int sumArray(List<int> arr) {
  int sum = 0;
  for (int num in arr) {
    sum += num;
  }
  return sum;

  // Shortcut: arr.reduce((a, b) => a + b);
}

// ============================================================
// 16. SECOND HIGHEST NUMBER IN ARRAY
// Logic: track both highest and second highest while looping
// ============================================================
int secondHighest(List<int> arr) {
  int highest = -999999999;
  int secondHigh = -999999999;

  for (int num in arr) {
    if (num > highest) {
      secondHigh = highest; // old highest becomes 2nd highest
      highest = num;
    } else if (num > secondHigh && num != highest) {
      secondHigh = num;
    }
  }

  return secondHigh;
}

// ============================================================
// 17. CHECK ANAGRAM (two words with same letters, different order)
// Example: "listen" and "silent"
// Logic: sort both strings' letters and compare
// ============================================================
bool isAnagram(String str1, String str2) {
  List<String> str1Chars = str1.split('')..sort();
  List<String> str2Chars = str2.split('')..sort();

  return str1Chars.join('') == str2Chars.join('');
}

// ============================================================
// 18. TWO SUM PROBLEM (very famous - asked almost everywhere)
// Given an array and a target, find two numbers that add up to target
// Logic: use a Map to remember numbers we've already seen
// ============================================================
List<int> twoSum(List<int> nums, int target) {
  Map<int, int> seen = {}; // value -> index

  for (int i = 0; i < nums.length; i++) {
    int needed = target - nums[i]; // what number would complete the pair

    if (seen.containsKey(needed)) {
      return [seen[needed]!, i]; // found the pair, return indexes
    }

    seen[nums[i]] = i; // remember this number and its index
  }

  return []; // no pair found
}

// ============================================================
// 19. MATRIX ROTATION (90 degrees clockwise)
// Logic: transpose the matrix, then reverse each row
// ============================================================
List<List<int>> rotateMatrix(List<List<int>> matrix) {
  int n = matrix.length;

  // Step 1: Transpose (swap rows with columns)
  for (int i = 0; i < n; i++) {
    for (int j = i; j < n; j++) {
      int temp = matrix[i][j];
      matrix[i][j] = matrix[j][i];
      matrix[j][i] = temp;
    }
  }

  // Step 2: Reverse each row
  for (int i = 0; i < n; i++) {
    matrix[i] = matrix[i].reversed.toList();
  }

  return matrix;
}

// ============================================================
// 20. COUNT OCCURRENCE OF EACH CHARACTER IN A STRING
// Logic: loop through string, use Map to count each character
// ============================================================
Map<String, int> countCharacters(String str) {
  Map<String, int> countMap = {};

  for (int i = 0; i < str.length; i++) {
    String char = str[i];
    countMap[char] = (countMap[char] ?? 0) + 1;
  }

  return countMap;
}

// ============================================================
// 21. FIND MISSING NUMBER IN ARRAY (1 to n)
// Logic: sum of 1 to n formula = n*(n+1)/2
// Missing number = expected sum - actual sum
// ============================================================
int findMissingNumber(List<int> arr, int n) {
  int expectedSum = (n * (n + 1)) ~/ 2; // ~/ means integer division
  int actualSum = arr.fold(0, (sum, num) => sum + num);

  return expectedSum - actualSum;
}

// ============================================================
// 22. ARMSTRONG NUMBER CHECK
// A number equal to sum of its own digits each raised to power
// of number of digits. Example: 153 = 1^3 + 5^3 + 3^3
// ============================================================
bool isArmstrong(int number) {
  int original = number;
  int numDigits = number.toString().length;
  int sum = 0;

  int temp = number;
  while (temp > 0) {
    int digit = temp % 10;
    sum += pow(digit, numDigits).toInt();
    temp ~/= 10; // remove last digit
  }

  return sum == original;
}

// pow function (manual, avoids importing dart:math just for this)
num pow(int base, int exponent) {
  num result = 1;
  for (int i = 0; i < exponent; i++) {
    result *= base;
  }
  return result;
}

// ============================================================
// 23. STAR PATTERN - SQUARE
// * * * *
// * * * *
// * * * *
// * * * *
// ============================================================
void printSquarePattern(int n) {
  for (int i = 0; i < n; i++) {
    String row = '';
    for (int j = 0; j < n; j++) {
      row += '* ';
    }
    print(row);
  }
}

// ============================================================
// 24. STAR PATTERN - RIGHT TRIANGLE
// *
// * *
// * * *
// * * * *
// * * * * *
// Logic: number of stars in row = row number
// ============================================================
void printTrianglePattern(int n) {
  for (int i = 1; i <= n; i++) {
    String row = '';
    for (int j = 1; j <= i; j++) {
      row += '* ';
    }
    print(row);
  }
}

// ============================================================
// 25. STAR PATTERN - PYRAMID
//     *
//    * *
//   * * *
//  * * * *
// * * * * *
// Logic: print spaces first, then stars
// ============================================================
void printPyramidPattern(int n) {
  for (int i = 1; i <= n; i++) {
    String row = '';

    // print spaces (decreasing)
    for (int s = 1; s <= n - i; s++) {
      row += '  ';
    }

    // print stars (increasing)
    for (int j = 1; j <= i; j++) {
      row += '* ';
    }

    print(row);
  }
}

// ============================================================
// 26. STAR PATTERN - INVERTED TRIANGLE
// * * * * *
// * * * *
// * * *
// * *
// *
// Logic: opposite of normal triangle, start high and go down
// ============================================================
void printInvertedTrianglePattern(int n) {
  for (int i = n; i >= 1; i--) {
    String row = '';
    for (int j = 1; j <= i; j++) {
      row += '* ';
    }
    print(row);
  }
}

// ============================================================
// 27. NUMBER PATTERN
// 1
// 1 2
// 1 2 3
// 1 2 3 4
// 1 2 3 4 5
// ============================================================
void printNumberPattern(int n) {
  for (int i = 1; i <= n; i++) {
    String row = '';
    for (int j = 1; j <= i; j++) {
      row += '$j ';
    }
    print(row);
  }
}

// ============================================================
// 28. DIAMOND PATTERN
//    *
//   * * *
//  * * * * *
//   * * *
//    *
// Logic: pyramid on top + inverted triangle on bottom
// ============================================================
void printDiamondPattern(int n) {
  // Top half (pyramid with odd stars: 1, 3, 5...)
  for (int i = 1; i <= n; i++) {
    String row = '';
    for (int s = 1; s <= n - i; s++) {
      row += '  ';
    }
    for (int j = 1; j <= (2 * i - 1); j++) {
      row += '* ';
    }
    print(row);
  }

  // Bottom half (inverted pyramid)
  for (int i = n - 1; i >= 1; i--) {
    String row = '';
    for (int s = 1; s <= n - i; s++) {
      row += '  ';
    }
    for (int j = 1; j <= (2 * i - 1); j++) {
      row += '* ';
    }
    print(row);
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: router,
    );
  }
}

