class OnboardingContent {
  String image;
  String title;
  String description;

  OnboardingContent(
      {required this.image, required this.title, required this.description});
}

List<OnboardingContent> content = [
  OnboardingContent(
    image:
        'https://www.womenentrepreneurindia.com/entrepreneur_images/news_images/kdkyv3.png',
    title: 'Go without hesitation',
    description:
        "Explore the untold world without any hesitation and fear. Make difference in culture with you power",
  ),
  OnboardingContent(
    image:
        'https://miro.medium.com/v2/resize:fit:640/1*fZfYEWmw8YNdDfu7jOHRNw.png',
    title: 'Go through obstracles',
    description:
        "Stay safe everywhere, anywhere. One call, One Locate, One Share",
  ),
  OnboardingContent(
    image:
        'https://img.freepik.com/premium-vector/hand-fist-your-rules-women-empowerment-female-power-feminist-concept-illustration_25030-48184.jpg',
    title: 'Stay strong, Stay brave',
    description:
        "Break the barrier and acheive the goal and make a difference in society",
  ),
];
