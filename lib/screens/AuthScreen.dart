import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plant_app/Models/Auth.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/User_Plant_Screen.dart';
import 'package:provider/provider.dart';

// enum AuthMode { Signup, Login }
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _rememberMe = false;
  bool _isSignUp = false;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'username':''
  };
 Future <void> _submit() async{
  
if(!_formKey.currentState.validate()){
  return;
}
_formKey.currentState.save();
if(_isSignUp){
  await Provider.of<Auth>(context,listen:false ).signUp(_authData['email'],_authData['password']);
   //UserPlantScreen(_authData['username']);
}
else{
  await Provider.of<Auth>(context,listen:false).Login(_authData['email'], _authData['password']);
}


 } 
  Widget _buildUserName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'User Name',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Enter The User Name',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            validator: (value) {
              if (value.isEmpty || !value.contains('@')) {
                return 'Invalid Email';
              }
              return null;
            },
            onSaved: (value) {
              _authData['email'] = value;
            },
            onFieldSubmitted:(value)
            {
                _authData['email']=value;
              print(_authData['email']);
            } ,

            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            // controller: _passwordController,
      
            validator: (value) {
              {
                if (value.isEmpty || value.length < 7) {
                  return ' PassWord is too short';
                }
               
                return null;
              }
            },
            onSaved: (value) {
              _authData['password'] = value;
            },
             onFieldSubmitted:(value)
            {
                _authData['password']=value;
              print(_authData['password']);
            } ,
        

            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText:'Enter Password',
              hintStyle: kHintTextStyle,
            ),
          ),
          
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: _submit,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color(0xFF0C9869),
        child: Text(
          _isSignUp ? 'Sign Up' : 'Login',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSignUp = !_isSignUp;
        });
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: _isSignUp
                  ? 'Already Have an account?'
                  : 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: _isSignUp ? 'Login' : 'SignUp',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                color:Colors.white ,
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height:200 ,
                        child: Image.network('https://media.istockphoto.com/vectors/abstract-green-leaf-logo-icon-vector-design-ecology-icon-set-eco-icon-vector-id1045368942?k=20&m=1045368942&s=612x612&w=0&h=yTrfMD72kUqNNMAZOdYAL5aEWw7AlGHGGqpIVgwDmSk=')),
                      Text(
                        'The Green Shop',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              SizedBox(height: 30.0),
                              _buildEmailTF(),
                              SizedBox(
                                height: 30.0,
                              ),
                              if (_isSignUp)
                                _buildUserName(),
                                SizedBox(height:30 ,),
                              _buildPasswordTF(),
                              SizedBox(
                                height: 30.0,
                              ),

                              _buildForgotPasswordBtn(),
                             // _buildRememberMeCheckbox(),
                              _buildLoginBtn(),
                              // _buildSignInWithText(),
                              // _buildSocialBtnRow(),
                              _buildSignupBtn(),
                            ],
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
