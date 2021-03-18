public class FinDockCommunityController {

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
        @AuraEnabled
        public Settings Settings{get;set;}

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

    public class Settings {
        @AuraEnabled
        public string SourceConnector{get;set;}
        @AuraEnabled
        public string ProcessingType{get;set;}
    }

    @AuraEnabled(cacheable=false)
    public static PaymentIntent submit(String jsonObject) {
        
        // Build your API request
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        RestContext.request = req;
        RestContext.response = res; 
        req.requestURI = URL.getSalesforceBaseUrl().toExternalForm()+'/services/apexrest/v2/PaymentIntent';
        req.httpMethod = 'POST';

        PaymentIntent body = (PaymentIntent)JSON.deserializeStrict(jsonObject, PaymentIntent.class );
        req.requestBody = Blob.valueOf(JSON.serialize(body, true));

        cpm.API_PaymentIntent_V2.postPaymentIntent();

        Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(res.responseBody.toString());
        system.debug(responseMap);

        PaymentIntent result = new PaymentIntent();
        result.Id = (String)responseMap.get('Id');
        result.RedirectUrl = (String)responseMap.get('RedirectURL');

        // Get the Payment Method from the response
        Map<String, Object> paymentMethodMap = (Map<String, Object>)responseMap.get('PaymentMethod');
        if (paymentMethodMap != null) {
            result.PaymentMethod = new PaymentMethod();
        	result.PaymentMethod.Name = (String)paymentMethodMap.get('Name');   
            result.PaymentMethod.Processor = (String)paymentMethodMap.get('Processor');
            result.PaymentMethod.Target = (String)paymentMethodMap.get('Target'); 
        }
        
        // // Check for errors in case something went wrong (base on res.statusCode?)
        // if (responseMap.containsKey('Errors')) {
        //     List<Object> errors = (List<Object>)responseMap.get('Errors');
        //     if (!errors.isEmpty()) {
        //         result.firstErrorMessage = (String)((Map<String, Object>)errors[0]).get('error_message');
        //     }
        // }

        // Return the result
        return result;

     }

}