class Employee{
  String _name;
  String _phone;
  String _address;
  String _email;
  String _picture;
  String _company;

  Employee(this._name, this._phone,  this._address, this._email, this._picture, this._company);
  

  Employee.map(dynamic obj){
    this._name     = obj['name'];
    this._phone    = obj['phone'];
    this._address  = obj['address'];
    this._email    = obj['email'];
    this._company  = obj['company'];
    this._picture  = obj['picture'];

  }
  
  String get name => _name;
  String get email    => _email;
  String get address => _address;
  String get phone => _phone;
  String get picture  => _picture;
  String get company => _company;

  Map<String, dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map["name"] = _name;
    map["phone"]    = _phone;
    map["address"]  = _address; 
    map["email"]    = _email;
    map["picture"]  = _picture; 
    map["company"] = _company;
   
    return map;
  }
  
}