import 'package:currency_converter/Models/currency_model.dart';
import 'package:currency_converter/services/currency_api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class AllCurrencyScreen extends StatefulWidget {
  const AllCurrencyScreen({super.key});

  @override
  State<AllCurrencyScreen> createState() => _AllCurrencyScreenState();
}

class _AllCurrencyScreenState extends State<AllCurrencyScreen> {
  //
  CurrencyApiServices currencyApiServices = CurrencyApiServices();
  TextEditingController searchController = TextEditingController();
  
String _formatApiDate(String apiDate) {
  try {
    final parsedDate = DateFormat('E, d MMM y H:m:s Z').parse(apiDate);
    return "Last Update: ${DateFormat.yMMMd().add_jm().format(parsedDate)}";
  } catch (e) {
    print("Error parsing date: $e");
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
               Rates rates = snapshot.data!.rates!; // Use the null assertion operator (!)
               List<String> currencies = rates.toJson().keys.toList(); // Assuming you want keys from the toJson representation
               //
                // Move the Container with "Last Update" text inside the builder function
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
        
        
                 //
        
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
                  openModelBottomSheet(context);
                },

                   child: ListTile(
                  leading: Image.asset('assets/coin.png'),
                  title: Text(currencyKey, style: Theme.of(context).textTheme.bodyMedium,),
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


void openModelBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.red,
              ),
             
              child: Column(
                children: [

               //1st Field 
                TextFormField(
              // controller: searchController,
              style: Theme.of(context).textTheme.bodyMedium, //input text decor
             
              // onChanged: (value) {
              //   setState(() {
              //   });
              // },
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
                ],
              )
            );
    },
  );
}
