// import 'dart:convert';

// import 'package:flutter/material.dart';

// import '../providers/models/pet-model.dart';
// import '../providers/services/pet-service.dart';
// import '../providers/services/shared-preferences-service.dart';
// import '../shared/widgets/vet-input.dart';
// import '../shared/widgets/vet-combo.dart';
// import '../shared/widgets/vet-date.dart';
// import '../shared/widgets/vet-header.dart';
// import '../shared/widgets/vet-button.dart';
// import '../shared/vet_app_icons.dart';

// import './foods-vaccines.dart';
// import './report.dart';

// class PetScreen extends StatefulWidget {
//   final Pet pet;

//   PetScreen({this.pet});

//   @override
//   _PetScreenState createState() => _PetScreenState();
// }

// class _PetScreenState extends State<PetScreen> {
//   bool _loading = false;

//   void _loadingService({bool loading}) {
//     setState(() {
//       _loading = loading;
//     });
//   }

//   void _getImagePath(value) {
//     widget.pet.petPathImage = value['petPathImage'];
//   }

//   void _getEvolutionPet() async {
//     final response = await PetService.getEvolutionPet(idPet: widget.pet.petId);
//     await Navigator.pushNamed(context, '/stadistics', arguments: response);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Pet'),
//         actions: <Widget>[
//           IconButton(icon: Icon(VetAppIcons.stadistic), onPressed: widget.pet != null ? _getEvolutionPet : null)
//         ],
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Stack(
//             children: <Widget>[
//               Column(
//                 children: <Widget>[
//                   VetHeader(pet: widget.pet, takePicture: true, callback: _getImagePath),
//                   PetForm(pet: widget.pet, callback: _loadingService)
//                 ]
//               ),
//             ]
//           ),
//           padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0)
//         )
//       )
//     );
//   }
// }

// class PetForm extends StatefulWidget {
//   final Pet pet;
//   final dynamic callback;

//   PetForm({this.pet, this.callback});

//   @override
//   _PetFormState createState() => _PetFormState();
// }

// class _PetFormState extends State<PetForm> {
//   final _formKey = GlobalKey<FormState>();
//   bool _autovalidate = false;
//   var _petName;
//   var _petBirthDay;
//   var _specieId;
//   var _raceId;
//   var _sexId;
//   var _sizeId;
//   var _petWeight;
//   var _habitatId;

//   void _showDialog({String typeAction, pet}) async {
//     final params = await showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
//           child: Container(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Text(
//                   'Los datos fueron guardados correctamente',
//                   style: TextStyle(fontSize: 20.0), textAlign: TextAlign.center
//                 ),
//                 SizedBox(height: 30.0),
//                 VetButton(
//                   color: Color.fromRGBO(90, 168, 158, 1.0),
//                   text: 'Aceptar',
//                   textSize: 18.0,
//                   onPress: () {
//                     Navigator.pop(context, {
//                       'action': typeAction,
//                       'data': pet
//                     });
//                   }
//                 )
//               ]
//             ),
//             padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
//           )
//         );
//       }
//     );

//     if (params['action'] == 'update') {
//       Navigator.pop(context, true);
//     } else if (params['action'] == 'create') {
//       await Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => FoodsVaccinesScreen(pet: params['data']))
//       );
//     }
//   }

//   _saveForm({String typeAction}) async {
//     if (_formKey.currentState.validate()) {
//       widget.callback(loading: true);
//       _formKey.currentState.save();
//       final clientId = await SharedPreferencesVet.getClientId();
//       final request = {
//         "petId": widget.pet != null ? widget.pet.petId : null,
//         "raceId": _raceId,
//         "specieId": _specieId,
//         "clientId": clientId,
//         "petBirthDay": _petBirthDay,
//         "petName": _petName,
//         // "petAge": 12,
//         // "petSize": _sizeId,
//         "petWeight": _petWeight,
//         "HabitadId" : _habitatId,
//         "PetSizeId" : _sizeId,
//         "SexId" : _sexId,
//       };

//       final response = widget.pet != null ?
//         await PetService.updatePet(data: request) :
//         await PetService.createPet(data: request);

//       widget.callback(loading: false);
//       if (response != null) {
//         _showDialog(typeAction: typeAction, pet: response);
//       }
//     } else {
//       setState(() => _autovalidate = true);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       autovalidate: _autovalidate,
//       key: _formKey,
//       child: Container(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text('General', style: TextStyle(fontSize: 22.0)),
//             SizedBox(height: 15.0),
//             VetInput(
//               icon: Icon(VetAppIcons.huella, size: 45.0),
//               initValue: widget.pet != null ? widget.pet.petName : '',
//               label: 'Nombre',
//               onSave: (val) => _petName = val,
//             ),
//             SizedBox(height: 20.0),
//             VetDate(
//               icon: Icon(VetAppIcons.calendar, size: 45.0),
//               label: 'Fecha de nacimiento',
//               initValue: widget.pet != null ? widget.pet.petBirthDay : null,
//               onChange: (val) => _petBirthDay = val
//             ),
//             SizedBox(height: 20.0),
//             VetCombo(
//               icon: Icon(VetAppIcons.specie, size: 45.0),
//               initValue: widget.pet != null ? widget.pet.specieId : null,
//               keyProperties: {
//                 'keyValue': 'specieId',
//                 'keyDescription': 'specieName'
//               },
//               label: 'Especie',
//               lookupType: 'species',
//               onChange: (val) => setState(() => _specieId = val),
//               onSave: (val) => _specieId = val,
//             ),
//             SizedBox(height: 20.0),
//             VetCombo(
//               dependingValue: _specieId ?? (widget.pet != null ? widget.pet.specieId : null),
//               icon: Icon(VetAppIcons.huella, size: 45.0),
//               initValue: _specieId != null ? null : (widget.pet != null ? widget.pet.raceId : null),
//               keyProperties: {
//                 'keyValue': 'raceId',
//                 'keyDescription': 'raceName'
//               },
//               label: 'Raza',
//               lookupType: 'races',
//               onChange: (val) => _raceId = val,
//               onSave: (val) => _raceId = val
//             ),
//             SizedBox(height: 20.0),
//             VetCombo(
//               icon: Icon(VetAppIcons.sexo, size: 45.0),
//               initValue: widget.pet != null ? widget.pet.sexId : null,
//               keyProperties: {
//                 'keyValue': 'id',
//                 'keyDescription': 'description'
//               },
//               label: 'Sexo',
//               lookupType: 'sex',
//               onChange: (val) => _sexId = val,
//               onSave: (val) => _sexId = val
//             ),
//             SizedBox(height: 20.0),
//             VetCombo(
//               icon: Icon(VetAppIcons.size, size: 45.0),
//               initValue: widget.pet != null ? widget.pet.petSizeId : null,
//               keyProperties: {
//                 'keyValue': 'id',
//                 'keyDescription': 'description'
//               },
//               label: 'Tamaño',
//               lookupType: 'size',
//               onChange: (val) => _sizeId = val,
//               onSave: (val) => _sizeId = val
//             ),
//             SizedBox(height: 20.0),
//             VetInput(
//               icon: Icon(VetAppIcons.peso, size: 45.0),
//               initValue: widget.pet != null ? widget.pet.petWeight.toStringAsFixed(2) : null,
//               label: 'Peso',
//               onSave: (val) => _petWeight = val
//             ),
//             SizedBox(height: 20.0),
//             VetCombo(
//               icon: Icon(VetAppIcons.habitad, size: 45.0),
//               initValue: widget.pet != null ? widget.pet.habitadId : null,
//               keyProperties: {
//                 'keyValue': 'id',
//                 'keyDescription': 'description'
//               },
//               label: 'Habitat',
//               lookupType: 'habitat',
//               onChange: (val) => _habitatId = val,
//               onSave: (val) => _habitatId = val
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 border: Border(bottom: BorderSide(color: Colors.grey[300], width: 1.0)),
//               ),
//               margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0)
//             ),
//             widget.pet != null ? OutlineButton(
//               borderSide: BorderSide(color: Color.fromRGBO(159, 189, 184, 1.0), width: 2.0),
//               child: Row(
//                 children: <Widget>[
//                   Icon(Icons.add_circle_outline, color: Color.fromRGBO(90, 168, 158, 1.0), size: 30),
//                   SizedBox(width: 5),
//                   Text(
//                     'Agregar datos extras',
//                     style: TextStyle(color: Color.fromRGBO(90, 168, 158, 1.0), fontSize: 18)
//                   )
//                 ],
//                 mainAxisAlignment: MainAxisAlignment.center,
//               ),
//               onPressed: () {
//                 widget.pet == null ?
//                   _saveForm(typeAction: 'create') :
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => FoodsVaccinesScreen(pet: widget.pet))
//                   );
//               },
//               padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))
//             ) : Container(),
//             SizedBox(height: widget.pet != null ? 60.0 : 0.0),
//             widget.pet != null ? VetButton(
//               color: Color.fromRGBO(202, 57, 48, 1.0),
//               text: 'Reportar enfermedad',
//               textSize: 22.0,
//               onPress: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => ReportScreen(pet: widget.pet))
//                 );
//               }
//             ) : Container(),
//             SizedBox(height: widget.pet != null ? 20.0 : 0.0),
//             VetButton(
//               color: Color.fromRGBO(90, 168, 158, 1.0),
//               text: 'Guardar',
//               textSize: 22.0,
//               onPress: () {
//                 _saveForm(typeAction: 'update');
//               }
//             )
//           ]
//         )
//       )
//     );
//   }
// }