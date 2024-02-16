import 'package:flutter/material.dart';
import 'package:ongolf_tech/RegistrationScreens/MemberLogin.dart';

class RegistrationOptions extends StatefulWidget {
  const RegistrationOptions({super.key});

  @override
  State<RegistrationOptions> createState() => _RegistrationOptionsState();
}

class _RegistrationOptionsState extends State<RegistrationOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/RO.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 30),
            
            // Header Text
            const Text(
              'Membership sign up.',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
      
            const SizedBox(height: 60 * 6),
            const Spacer(),
            const SizedBox(height: 20),
      
            // Next Button
            OutlinedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  
                ),
              ),
              onPressed: () => (context),
      
                child: Text(
                  'GOLF PLAYER',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Colors.grey[400],
                  ),
                ),
            ),
             
             //others button
            OutlinedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed:() {},
                child: Text(
                  'OTHERS',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Colors.grey[400],
                  ),
                ),
              ),
              
      
              //already a member
               OutlinedButton(
              style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Colors.transparent), backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () => navigateToMemberLogin(context),
                child: Text(
                  'Already a golf member?',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    color: Colors.grey[400],
                  ),
                ),
              ),
               
      
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

//Navigate to Memeber login
void navigateToMemberLogin(BuildContext context){
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => const MemberLogin() ),
);
}

//Navigate to Memeber login

}