String timeAgo(String dateString) {
  final date = DateTime.parse(dateString);
  final difference = DateTime.now().difference(date);

  if (difference.inSeconds < 60) {
    return '${difference.inSeconds} sec ago';
  }

  if (difference.inMinutes < 60) {
    return '${difference.inMinutes} min ago';
  }

  if (difference.inHours < 24) {
    return '${difference.inHours} h ago';
  }

  if (difference.inDays < 30) {
    return '${difference.inDays} d ago';
  }

  if (difference.inDays < 365) {
    final months = difference.inDays ~/ 30;
    return '$months ${months == 1 ? 'month' : 'months'} ago';
  }

  final years = difference.inDays ~/ 365;
  return '$years ${years == 1 ? 'year' : 'years'} ago';
}