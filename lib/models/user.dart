class User {

   String uid;
   String name;
   String email;

  User(this.name, this.email, { this.uid });

  User.fromMap(Map<String, dynamic> data) {
    uid = data['uid'];
    name = data['name'];
    email = data['email'];

  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }

}