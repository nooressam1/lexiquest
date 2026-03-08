class Profilepicassets {
  static final List<String> images = [
    'assets/images/CharacterAssets/bear.png',
    'assets/images/CharacterAssets/chicken.png',
    'assets/images/CharacterAssets/cow.png',
    'assets/images/CharacterAssets/gorilla.png',
    'assets/images/CharacterAssets/meerkat.png',
    'assets/images/CharacterAssets/penguin.png',
    'assets/images/CharacterAssets/rabbit.png',
    'assets/images/CharacterAssets/shark.png',
  ];

  static List<String> getAllImages() => images;

  static String getImage(int id) => images[id - 1]; // id starts at 1
}
