/* This class allows a Flow to execute a payment through the FinDock Payment API.
The goal is to allow all business logic (including updates) to be done in the Flow.
That means this class is absolutely barebones and just blindly executes an API call with a provided JSON, 
and returns the response to the Flow.
*/

public class FinDockCommunityAction {
    //Define your DTO. This is just a bare minimum selection of fields for a one-time payment, 
    //find more in the API Reference: https://docs.findock.com/api
    public class PaymentIntent {
        public String Id;
        public String SuccessURL;
        public String FailureURL;
        public String RedirectURL;
        public Payer Payer;
        public OneTime OneTime;
        public PaymentMethod PaymentMethod;
    }

    // Who is doing the payment, either a Contact or Account
    public class Payer {
        public Contact Contact;
        public Account Account;
    }

    // Get all the details of your Contact and / or Account
    // you can set any Salesforce field - standard or custom - in the Salesforcefields object 
    public class Contact {
        public List<String> SalesforceFields;
    }

    public class Account {
        public List<String> SalesforceFields;
    }

    // Data on a one-time payment. Replace with Recurring object for recurring payments.
    public class OneTime {
        public double Amount;
    }
    
    // How do you want the user to pay, and through what Payment Processor?
    // Hardcode a list of supported payment methods, or query the /PaymentMethods API for a dynamic list.
    public class PaymentMethod {
        public string Name;
        public string Processor;
        public string Target;
    }

    // The API Error object, in case you want to handle it
    public class Error {
        public string error_message;
        public string error_code;
    }

    /* 
    Build a PaymentIntent object from the input passed by the Flow and submit it to the Payment API.
    Unfortunately we cannot easily build a PaymentIntent object in the Flow because:
    - @InvocableVariable does not work on Inner classes like PaymentMethod.
    - @InvocableVariable does not allow Maps
    - We can only pass one parameter - that must be a list! - to the @InvocableMethod.
    */

    // Wrapper class for input and output of Flow
    public class flowInputOutput {
        @InvocableVariable
        public String requestBody;
        @InvocableVariable
        public String responseBody;
    }

    // Unpacks Flow input, submits payment to API and returns API response to FLow
    @InvocableMethod(label='FinDockCommunitySubmitPayment' description='Create a payment with FinDock by passing me a String in the shape of a JSON as defined in https://docs.findock.com/api')
    public static List<FlowInputOutput> submitPamentIntent(List<FlowInputOutput> flowInputs) {

        List<FlowInputOutput> outputs = new List<FlowInputOutput>();
        
        for (FlowInputOutput flowInput: flowInputs) {
            FlowInputOutput output = new FlowInputOutput();
            output.responseBody = PaymentIntent.submit(flowInput.requestBody);
            outputs.add(output);
        }
       	return outputs;
    }
    
    
   // Submit the payment to the Payment API.
   public static String submit(String jsonObject) {
       
       // Build your API request...
       RestRequest req = new RestRequest();
       RestResponse res = new RestResponse();
       RestContext.request = req;
       RestContext.response = res; 
       req.requestURI = URL.getSalesforceBaseUrl().toExternalForm()+'/services/apexrest/v2/PaymentIntent';
       req.httpMethod = 'POST';

       // ...with the input from the Flow...
       req.requestBody = Blob.valueof(jsonObject);

       // ...and send the Payment Intent to the FinDock Payment API, by calling the Apex method!
       cpm.API_PaymentIntent_V2.postPaymentIntent();

       String response;

       // Get the response from the FinDock Payment API if API call is successfull
       if (res.statusCode == 200) {
            response = res.responseBody.toString();
       }

       // Check for errors.
       if (res.statusCode != 200) {
         // Do something to throw or handle error. See Error object.
         // Or just return the responsebody to the Flow and let the Flow deal with it.
         system.debug(res.responseBody.toString());
       }

       // Return the result to your LWC
       return response;
    }
}