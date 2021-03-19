public class FinDockCommunityController {
    // Don't forget to give your Site Guest User access to this Apex class through a permission set!
    // To execute the API call, the Site Guest User also needs the FinDock Site Guest User permission set
    // and the permission set for your Processor of choice. Read more: https://docs.findock.com/permissions

    // Define your DTO. This is just a bare minimum selection of fields for a one-time payment, 
    // find more in the API Reference: https://docs.findock.com/api
    public class PaymentIntent {
        @AuraEnabled
        public String Id{get;set;}
        @AuraEnabled
        public String SuccessURL{get;set;}
        @AuraEnabled
        public String FailureURL{get;set;}
        @AuraEnabled
        public String RedirectURL{get;set;}
        @AuraEnabled
        public Payer Payer{get;set;}
        @AuraEnabled
        public OneTime OneTime{get;set;}
        @AuraEnabled
        public PaymentMethod PaymentMethod{get;set;}
    }

    public class Payer {
        @AuraEnabled
        public Contact Contact{get;set;}
    }

    public class Contact {
        @AuraEnabled
        public Map<String, String> SalesforceFields{get;set;}
    }

    public class OneTime {
        @AuraEnabled
        public double Amount{get;set;}
    }
    
    public class PaymentMethod {
        @AuraEnabled
        public string Name{get;set;}
        @AuraEnabled
        public string Processor{get;set;}
        @AuraEnabled
        public string Target{get;set;}
    }

    public class Error {
        @AuraEnabled
        public string error_message{get;set;}
        @AuraEnabled
        public string error_code{get;set;}
    }

    @AuraEnabled(cacheable=false)
    public static PaymentIntent submit(String jsonObject) {
        
        // Build your API request...
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        RestContext.request = req;
        RestContext.response = res; 
        req.requestURI = URL.getSalesforceBaseUrl().toExternalForm()+'/services/apexrest/v2/PaymentIntent';
        req.httpMethod = 'POST';

        // ...with the input from the user...
        PaymentIntent body = (PaymentIntent)JSON.deserializeStrict(jsonObject, PaymentIntent.class );
        req.requestBody = Blob.valueOf(JSON.serialize(body, true));

        // ...and send the Payment Intent to the FinDock Payment API.
        cpm.API_PaymentIntent_V2.postPaymentIntent();

        // Get the response from the FinDock Payment API...
        Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(res.responseBody.toString());
        system.debug(responseMap);

        // Check for errors.
        if (res.statusCode != 200) {
          // do something to throw or handle error
          system.debug(responseMap);
        }

        PaymentIntent result = new PaymentIntent();
        // If API call was successfull.
        if (res.statusCode == 200) {
            // ...parse valuable data like the Payment Intent Id of your call that's stable accross all FinDock communication like webhooks...  
            
            result.Id = (String)responseMap.get('Id');
        
            // ...and maybe some additional information like Payment method and Processor used
            Map<String, Object> paymentMethodMap = (Map<String, Object>)responseMap.get('PaymentMethod');
            if (paymentMethodMap != null) {
                result.PaymentMethod = new PaymentMethod();
                result.PaymentMethod.Name = (String)paymentMethodMap.get('Name');   
                result.PaymentMethod.Processor = (String)paymentMethodMap.get('Processor');
            }

            // ...but most important: the Redirect URL to the Hosted Payment Page of the Processor!
            result.RedirectUrl = (String)responseMap.get('RedirectURL'); 
        }
        
        // Return the result to your LWC
        return result;
    }
}