class EventValidator {

  static String? validateDesc({required String? description}) {
    if (description == null) {
      return null;
    } else if (description.length > 60) {
      return 'Description is too long. (Max 60 chars)';
    } else if (description.isEmpty) {
      return 'Description can\'t be empty!';
    }
  }

  static String? validatePlace({required String? place}) {
    if (place == null) {
      return null;
    } else if (place.length > 18) {
      return 'Place name is too long. (Max 18 chars)';
    } else if (place.isEmpty) {
      return 'Place can\'t be empty!';
    }
  }
}