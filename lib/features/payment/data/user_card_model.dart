class UserCard {
  String cardNumber, expiryDate, cardHolderName, cvv;

  UserCard(this.cardNumber, this.expiryDate, this.cardHolderName, this.cvv);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data["cardNumber"] = cardNumber;
    data["expiryDate"] = expiryDate;
    data["cardHolderName"] = cardHolderName;
    data["cvv"] = cvv;
    return data;
  }

  factory UserCard.fromJson(Map<String, dynamic> data) {
    UserCard userCard = UserCard(data["cardNumber"], data["expiryDate"],
        data["cardHolderName"], data["cvv"]);
    return userCard;
  }
}
