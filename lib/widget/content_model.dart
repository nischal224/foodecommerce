class UnboardingContent {
  String description;
  String image;
  String title;

  UnboardingContent({
    required this.description,
    required this.image,
    required this.title,
  });
}

List<UnboardingContent> contents = [
  UnboardingContent(
    description: "pick your food from our menu\n     more than 35 times",
    image: 'images/screen1.png',
    title: 'Select from our\n         Best menu',
  ),
  UnboardingContent(
    description: "you can pay cash on delivery and card payment is available",
    image: 'images/screen2.png',
    title: 'Easy and online Pyament',
  ),
  UnboardingContent(
    description: "Deliver your food at your door step with our fast delivery",
    image: 'images/screen3.png',
    title: 'Quick delivery at your door step',
  ),
];
