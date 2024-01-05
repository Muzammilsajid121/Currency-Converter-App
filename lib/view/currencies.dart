import 'package:currency_converter/Models/currency_model.dart';
import 'package:currency_converter/services/currency_api_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class AllCurrencyScreen9 extends StatefulWidget {
  const AllCurrencyScreen9({super.key});

  @override
  State<AllCurrencyScreen9> createState() => _AllCurrencyScreenState();
}

class _AllCurrencyScreenState extends State<AllCurrencyScreen9> {
  //
  CurrencyApiServices currencyApiServices = CurrencyApiServices();
  TextEditingController searchController = TextEditingController();
    TextEditingController rateController = TextEditingController();

 double finalCalculatedrates =0.0;
 String selectedCurrency = ''; 
  double selectedratevalue = 0.0;
  // double finalCalculatedRates = 0;
  var reuslt= '';


  
String _formatApiDate(String apiDate) {
  try {
    final parsedDate = DateFormat('E, d MMM y H:m:s Z').parse(apiDate);
    return "Last Update: ${DateFormat.yMMMd().add_jm().format(parsedDate)}";
  } catch (e) {
    if (kDebugMode) {
      print("Error parsing date: $e");
    }
    return "Last Update: N/A";
  }
}


  @override
  Widget build(BuildContext context) {
    final height= MediaQuery.sizeOf(context).height*1;
    final width = MediaQuery.sizeOf(context).width*1;
    return  Scaffold(

      appBar: AppBar(
         title:  Text('Currency Converter', style:Theme.of(context).textTheme.bodyMedium ,),
         centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
           
            TextFormField(
              controller: searchController,
              style: Theme.of(context).textTheme.bodyMedium, //input text decor
               //For search
              onChanged: (value) {
                setState(() {
                });
              },
              //
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)
                ),
                
                fillColor: const Color(0xff212436),
                hintText: "Type Your Currency",
                hintStyle: Theme.of(context).textTheme.bodyMedium
                
              ),
            ),
            
            SizedBox(height: height*0.02,),
             Text("Current Currency", style: Theme.of(context).textTheme.bodyMedium,),
             SizedBox(height: height*0.01,),
             Text("USD", style: Theme.of(context).textTheme.titleLarge,),
             SizedBox(height: height*0.01,),
           //
       
           //
           //API
           FutureBuilder<CurrencyModel>(
            future: currencyApiServices.fetchWorldCurrencyApi(),
             builder: (context,AsyncSnapshot<CurrencyModel> snapshot){
               if (!snapshot.hasData || snapshot.data == null) {
             return const SpinKitChasingDots(color: Colors.red);
    }
              else{
               Rates rates = snapshot.data!.rates!; 
               List<String> currencies = rates.toJson().keys.toList(); 
               //
               
      return Expanded(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xff2F2F34),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Text(
                " ${_formatApiDate(snapshot.data!.timeLastUpdateUtc?? 'N/A')}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
        
        
                     Expanded(
                  child: ListView.builder(
                  itemCount: currencies.length,
                  itemBuilder: (context, index){
        
                    //Search currency Name
                    if(searchController.text.isEmpty){
                        String currencyKey = currencies[index];
          double rateValue = rates.toJson()[currencyKey];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                     
                        child:Column(
                          children: [
                      
               InkWell(
                onTap: () {
                  String currencyKey = currencies[index];
                  double rateValue = rates.toJson()[currencyKey];

  
    selectedCurrency = currencyKey;
    selectedratevalue = rateValue;
  
                  //ModalBottomSheet
                  showModalBottomSheet(
                    
                    context: context,
                   builder:(BuildContext context){
                   
                    //
                    ////
                     return Container(
              width: double.infinity,
              height: height*0.500,
              decoration: BoxDecoration(
                color: Color(0xff1A1B27),
                borderRadius: BorderRadius.circular(15)
              ),
             
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
            Image.asset('assets/coincon.png'),
             //
             Padding(
               padding: const EdgeInsets.all(20.0),
               child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xff212436),
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                                 //!ST FIELD
                       SizedBox(
                        width: 120,
                         child: TextFormField(
                                       controller: rateController,
                                       keyboardType: TextInputType.number,
                                       style: Theme.of(context).textTheme.bodyMedium, //input text decor
                                
                          
                                       decoration: InputDecoration(
                                         border: OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(30)
                                         ),
                                         
                                         fillColor: const Color(0xff212436),
                                         hintText: "Converter",
                                         hintStyle: Theme.of(context).textTheme.bodyMedium
                                         
                                       ),
                                     ),
                       ),
                             //
                                 Text('USD', style: Theme.of(context).textTheme.bodyMedium,),
                                 
                    ],
                   ),
                ),
               ),
             ),

               //2nd ROW 
               ////
                Padding(
               padding: const EdgeInsets.all(20.0),
               child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xff212436),
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                                 //1ST FIELD
                     Text(selectedCurrency.toString(), style: Theme.of(context).textTheme.bodyMedium,),
                       //show the selected currency rate
                             //
                           
                    Text(selectedratevalue.toString(), style: Theme.of(context).textTheme.bodyMedium,),
                       //show the selected currency name

                            
                    ],
                   ),
                ),
               ),
             ),
              //
              //Button
               SizedBox(
                  height: height*0.04, width: height*0.3,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: Color.fromARGB(0, 255, 169, 244),
                      foregroundColor: Colors.white,
                      backgroundColor:const Color(0xff212436),                      
                    ),
                    onPressed: (){
                        //Calculations
  var lastrate = rateController.text;
  //parsing last rate to double becuz selectedratevalue is also double
  if(lastrate!= ''){
     double doublesuperrate = double.parse(lastrate);

     finalCalculatedrates = doublesuperrate*selectedratevalue;
  if (kDebugMode) {
    print(finalCalculatedrates);
  }  
  
    setState(() {
                 finalCalculatedrates;
                  });  }
  } ,
                    child: 
                   const   Text('Calculate')
                    ),
                ),

  // Text(rateController.text +' USD to '+selectedCurrency.toString()+' is '+finalCalculatedrates.toString()),
  //OR
Text(finalCalculatedrates != 0.0 ? '${rateController.text} USD to $selectedCurrency is $finalCalculatedrates' : ''),
    ],
              ),
              
            );
                   }
                   //bottom sheet bracket
                  ).whenComplete(() {
                    // Reset variables when the modal sheet is closed
      setState(() {
        rateController.text = ''; // Clear the text field
        finalCalculatedrates = 0.0; // Reset the calculation
        
        // selectedCurrency = ''; // Reset selected currency
        // selectedratevalue = 0.0; // Reset selected rate value
                  });
                   });
      
                },

                   child: ListTile(
                  leading: Image.asset('assets/coin.png'),
                  title: Text( currencyKey.toString(), style: Theme.of(context).textTheme.bodyMedium,),
                  trailing: Text(rateValue.toString(), style: Theme.of(context).textTheme.bodyMedium,),
                                                       ),
                            ),
        
                          SizedBox(height: width*0.01,),
                        const   Divider(
                            color: Colors.white,
                            height: 0.5,
                          )
                          ],
                        )
                    );
                    }
                    //currencies[index] becuz currencies is List
                    else if(currencies[index].toLowerCase().contains(searchController.text.toLowerCase())){
                          String currencyKey = currencies[index];
                          double rateValue = rates.toJson()[currencyKey];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                     
                        child:Column(
                          children: [
                      
                            ListTile(
                    leading: Image.asset('assets/coin.png'),
                    title: Text(currencyKey, style: Theme.of(context).textTheme.bodyMedium,),
                  trailing: Text(rateValue.toString(), style: Theme.of(context).textTheme.bodyMedium,),
                         ),
        
                          SizedBox(height: width*0.01,),
                        const   Divider(
                            color: Colors.white,
                            height: 0.5,
                          )
                  
                          ],
                        )
                       
                         
                                      
                      // ),
                    );
                    }
                    else{
                      return Container();
                    }
        
        
                    
                    
                               
                  }),
          )
          ]  
          ),
      );

              }
             

             })
            
          ],
        ),
      ),
    );
  }
}
