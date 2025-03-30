class DValidator{

  static String? validateEmptyText(String? fieldName,String? value){
    if(value==null || value.isEmpty){
      return '$fieldName is required';
    }
    return null;
  }











  static String? validateEmail(String? value){
    if(value==null|| value.isEmpty){
      return 'Email is required';
    }
    final emailRegExp  = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'); // dinh dang 3 phan ko co dau cach vi du ledung.@gmail.com
    if(!emailRegExp.hasMatch(value)){
      return 'Invalid email address';
    }
    return null;
  }
  static String? validatePassword(String? value){
    if(value==null|| value.isEmpty){
      return 'Password is required';
    }
    if(value.length<6){
      return 'Password must be at least 6 characters long';
    }
    if(!value.contains(RegExp(r'[A-Z]'))){
      return 'Password must contain at least 1 uppercase letter';
    }
    if(!value.contains(RegExp(r'[0-9]'))){
      return 'Password must contain at least 1 number';
    }
    if(!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
      return 'Password must contain at least 1 special character';
    }
    return null;
  }
  static String? validatePhoneNumber(String? value){
    if(value==null|| value.isEmpty){
      return 'PhoneNumber is required';
    }
    final emailRegExp  = RegExp(r'^\d{10}$'); // dinh dang 3 phan ko co dau cach vi du ledung.@gmail.com
    if(!emailRegExp.hasMatch(value)){
      return 'Invalid PhoneNumber';
    }
    return null;
  }


}