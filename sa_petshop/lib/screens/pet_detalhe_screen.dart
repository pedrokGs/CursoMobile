// Tela de Detalhes do Pet

import '../controllers/consultas_controller.dart';
import '../controllers/pets_controller.dart';
import '../models/consulta_model.dart';
import '../models/pet_model.dart';
import 'add_consulta_screen.dart';

class PetDetalheScreen extends StatefulWidget{
  final int petId;

  const PetDetalheScreen({
    super.key, required this.petId
  });

  @override
  State<StatefulWidget> createState(){
    return _PetDetalheScreenState();
  }
}

class _PetDetalheScreenState extends State<PetDetalheScreen> {
  final PetsController _controllerPets = PetsController();
  final ConsultasController _controllerConsultas = ConsultasController();
  bool _isLoanding = true;

  Pet? _pet;

  List<Consulta> _consultas = [];

  @override
  void initState(){
    super.initState();
    _loadPetConsultas();
  }

  Future<void> _loadPetConsultas() async{

    setState((){
      _isLoanding = true;
    });

    try {
      _pet = await  _controllerPets.findPetById(widget.petId);
     _consultas = await _controllerConsultas.getConsultasByPet(widget.petId;)
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(context: Text("Exception: $e "))
      );
    } finally{
      setState((){
        _isLoanding = false;
      });
    }
    }

    @override
    Widget build(BuildBontext context){
      return Scaffold(
        appBar: AppBar(title: Text("Detalhes do Pet")),
        body: _isLoanding ? 
        
        Center(child: CircularProgressIndicator(),)
        : _consultas.isEmpty ?
        Center(child: 'Erro ao carregar o Pet')
        :
        Padding(padding: EdgeInsets.all(16), 
        child: Column(
          crossAxisAligment: CrossAxisAligment.start,
          children: [
            Text("Nome: ${_pet!.nome}", style: TextStyle(fontSize: 20)),
            Text("Raça: ${_pet!.raca}"),
            Text("Dono: ${_pet!.nomeDono}"),
            Text("Telefone:: ${_pet!.telefoneDono}"),
            Divider(),
            Text("Consultas:"),
            _consultas.length==0
              ? Center(child: Text("Não Existe consultas Cadastradas"),)
              : Expanded(child: ListView.builder(
                itemCount: _consultas.length,
                itemBuilder: (context,index){
                  final consulta = _consultas[index];
                  return ListTile(
                    title: Text(consulta.tipoServico),
                    subtitle: Text(consulta.dataHoraFormata),
                    trailing: IconButton(onPressed: () =>_deleteConsulta(consulta.id!), icon: Icon(Icons.delete),),
                    
                  )
                }))
          ]
        )),
    floatingActionButton: FloatingActionButton(
      onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => AddConsultaScreen(petId: widget.petId)))),
    );
    }

    void _deleteConsulta(int consultaId) async {
      await _controllerConsultas.deleteConsulta(consultaId);
      _loadPetConsultas();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Consulta deletada com sucesso"));
      )
  }
}