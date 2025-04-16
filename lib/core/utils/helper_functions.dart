class HelperFunctions {
  static String fixGoogleDriveUrl(String url) {
    if (url.contains('drive.google.com') && url.contains('open?id=')) {
      final fileId = url.split('id=').last;
      return 'https://drive.google.com/uc?export=view&id=$fileId';
    }
    return url;
  }
}
