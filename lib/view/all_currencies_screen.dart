import 'package:currency_converter/Models/currency_model.dart';
import 'package:currency_converter/services/currency_api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AllCurrencyScreen extends StatefulWidget {
  const AllCurrencyScreen({super.key});

  @override
  State<AllCurrencyScreen> createState() => _AllCurrencyScreenState();
}

class _AllCurrencyScreenState extends State<AllCurrencyScreen> {
  //
  CurrencyApiServices currencyApiServices = CurrencyApiServices();
  TextEditingController searchController = TextEditingController();
  
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
              controller: SearchController(),
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
           Container(
            // width: width*0.10,
            decoration:const  BoxDecoration(
              color: Color(0xff2F2F34),
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child:  Text("Date", style: Theme.of(context).textTheme.bodyMedium,),
           ),
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

                 return  Expanded(
                child: ListView.builder(
                itemCount: currencies.length,
                itemBuilder: (context, index){
                  //
                  //Search currency Name
                  // if(searchController.text.isEmpty){
                    

                  // }
                  // else if(currencies.toLowerCase().contains(searchController.text.toLowerCase())){

                  // }else{
                  //   return Container();
                  // }
                    String currencyKey = currencies[index];
        double rateValue = rates.toJson()[currencyKey];
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                   
                      child:Column(
                        children: [
                      //       ListTile(
                        
                      // leading: Image.asset('assets/coin.png'),
                      // title:  Text(snapshot.data!['currencies']['index'], style: Theme.of(context).textTheme.bodyMedium,),
                      // trailing:  Text(snapshot.data!['rates'], style: Theme.of(context).textTheme.bodyMedium,),
                      //               ),
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
                  
                  
                             
                }),
              );

              }
             

             })
            
          ],
        ),
      ),
    );
  }
}