public class FinDockCommunityAction {
    /* Don't forget to give your Site Guest User access to this Apex class through a permission set!
    To execute the API call, the Site Guest User also needs the FinDock Site Guest User permission set
    and the permission set for your Processor of choice. Read more: https://docs.findock.com/permissions
    */

    //Define your DTO. This is just a bare minimum selection of fields for a one-time payment, 
    //find more in the API Reference: https://docs.findock.com/api
    public class PaymentIntent {
        @InvocableVariable
        public String Id;
        @InvocableVariable
        public String SuccessURL;
        @InvocableVariable
        public String FailureURL;
        @InvocableVariable
        public String RedirectURL;
        @InvocableVariable
        public Payer Payer;
        @InvocableVariable
        public OneTime OneTime;
        @InvocableVariable
        public PaymentMethod PaymentMethod;
    }

    // Who is doing the payment, either a Contact or Account
    public class Payer {
        @InvocableVariable
        public Contact Contact;
        public Account Account;
    }

    // Get all the details of your Contact and / or Account
    // you can set any Salesforce field - standard or custom - in the Salesforcefields object 
    public class Contact {
        @InvocableVariable
        public List<String> SalesforceFields;
    }

    public class Account {
        @InvocableVariable
        public List<String> SalesforceFields;
    }

    // Data on a one-time payment. Replace with Recurring object for recurring payments.
    public class OneTime {
        @InvocableVariable
        public double Amount;
    }
    
    // How do you want the user to pay, and through what Payment Processor?
    // Hardcode a list of supported payment methods, or query the /PaymentMethods API for a dynamic list.
    public class PaymentMethod {
        @InvocableVariable
        public string Name;
        @InvocableVariable
        public string Processor;
        @InvocableVariable
        public string Target;
    }

    // The API Error object, in case you want to handle it
    public class Error {
        @InvocableVariable
        public string error_message;
        @InvocableVariable
        public string error_code;
    }

    @InvocableMethod(label='FinDockCommunitySubmitPayment')
    public static List<PaymentIntent> FlowInputOutputHandler(List<PaymentIntent> flowInput) {
    
    List<PaymentIntent> flowOutput = new List<PaymentIntent>();

    return flowOutput;
    }
    


    // Submit the payment to the Payment API.
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

        // ...and send the Payment Intent to the FinDock Payment API, by calling the Apex method!
        cpm.API_PaymentIntent_V2.postPaymentIntent();

        // Get the response from the FinDock Payment API...
        Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(res.responseBody.toString());
        system.debug(responseMap);

        // Check for errors.
        if (res.statusCode != 200) {
          // Do something to throw or handle error. See Error object.
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