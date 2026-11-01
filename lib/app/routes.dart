abstract final class Routes {
  static const welcome = '/welcome';
  static const emailSignIn = '/welcome/email';
  static const consent = '/consent';
  static const onboarding = '/onboarding';

  static const community = '/community';
  static const signs = '/signs';
  static const healthy = '/healthy';
  static const share = '/share';
  static String post(String id) => '/post/$id';

  static const fireflies = '/fireflies';
  static const lightGlow = '/fireflies/glow';
  static const glowCaution = '/fireflies/caution';
  static const quietGlow = '/fireflies/quiet';

  static const settings = '/settings';
  static const editTopics = '/settings/topics';
  static const blockedPeople = '/settings/blocked';
  static const notifications = '/notifications';
}
