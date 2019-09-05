// import 'package:flutter/material.dart';

// import './card.dart';

// class BandejaScreen extends StatefulWidget {

//   @override
//   _BandejaScreenState createState() => _BandejaScreenState();
// }

// class _BandejaScreenState extends State<BandejaScreen> {

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   // _goToPet({data}) async {
//   //   final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => PetScreen(pet: data)));

//   //   if (result != null && result == true) {
//   //     setState(() {
//   //       _pets = _getPetsList();
//   //     });
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: <Widget>[
//           Container(
//             child: _addPetBtn(),
//             padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
//           ),
//           Expanded(
//             child: StreamBuilder(
//               stream: _bloc.allpets,
//               builder: (context, snaptshot) {
//                 if(snaptshot.hasData) {
//                   return _createPetsGridView(snapshot: snaptshot);
//                 } else {
//                   return Center(
//                     child: CircularProgressIndicator(
//                       backgroundColor: Colors.grey[350],
//                       valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(90, 168, 158, 1.0)),
//                     )
//                   );
//                 }
//               }
//             )
//           )
//         ]
//       )
//     );
//   }

//   OutlineButton _addPetBtn() {
//     return OutlineButton(
//       borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
//       child: Row(
//         children: <Widget>[
//           Icon(Icons.add_circle_outline, color: Theme.of(context).primaryColor, size: 30),
//           SizedBox(width: 5),
//           Text(
//             'Agregar mascota',
//             style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18)
//           )
//         ],
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//       ),
//       onPressed: () {},
//       padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))
//     );
//   }

//   Widget _createPetsGridView({AsyncSnapshot snapshot}) {
//     return GridView.builder(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 10.0,
//         mainAxisSpacing: 10.0
//       ),
//       itemBuilder: (BuildContext context, int index) {
//         return GestureDetector(
//           child: CardPet(petData: snapshot.data[index]),
//           onTap: () {}
//         );
//       },
//       itemCount: snapshot.data.length,
//       padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
//     );
//   }
// }