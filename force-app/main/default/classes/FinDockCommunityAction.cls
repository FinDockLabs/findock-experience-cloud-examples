/* This class allows a Flow to execute a payment through the FinDock Payment API.
The goal is to allow all business logic (including updates) to be done in the Flow.
That means this class is absolutely barebones and just blindly executes an API call with a provided JSON, 
and returns the response to the Flow.
*/

public class FinDockCommunityAction {
    /* 
    Submit the the input from a Flow (in the shape of a JSON String) to the Payment API and returns InvocableVariables to Flow.
    Unfortunately we cannot easily build a PaymentIntent object in the Flow because:
    - @InvocableVariable does not work on Inner classes like PaymentMethod.
    - @InvocableVariable does not allow Maps
    - We can only pass one parameter - that must be a list! - to the @InvocableMethod.
    */

    // Wrapper class for input and output of Flow.
    public class flowInputOutput {
        @InvocableVariable
        public String requestBody;
        @InvocableVariable
        public String redirectURL;
        @InvocableVariable
        public Integer status;
    }

    //Unpacks Flow input, submits payment to API and returns API response to Flow
    @InvocableMethod(label='FinDockCommunitySubmitPayment' description='Create a payment with FinDock by passing me a String in the shape of a JSON as defined in https://docs.findock.com/api')
    public static List<FlowInputOutput> submitPamentIntent(List<FlowInputOutput> flowInputs) {

        List<FlowInputOutput> outputs = new List<FlowInputOutput>();
        
        for (FlowInputOutput flowInput: flowInputs) {
            FlowInputOutput output = PaymentIntent.submit(flowInput.requestBody);
            outputs.add(output);
        }
       	return outputs;
    }
    
    
   // Submit the payment to the Payment API.
   public static flowInputOutput submit(String jsonObject) {

    FlowInputOutput response = new FlowInputOutput();
       
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

       // Get the response from the FinDock Payment API if API call is successfull and parse relevant fields.
       // Remember, all the data is stored by FinDock in Salesforce already.
       if (res.statusCode == 200) {
            Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(res.responseBody.toString());
            // The RedirectURL needs to be handled to complete the payment.
            response.status = res.statusCode;
            response.redirectURL = (String)responseMap.get('RedirectURL');
            
       } 

       // Check for errors.
       if (res.statusCode != 200) {
         // Do something to throw or handle error. See Error object.
         // Or just return the responsebody to the Flow and let the Flow deal with it.
         response.status = res.statusCode;
         system.debug(res.responseBody.toString());
       }

       // Return the redirectURL or Error message to your Flow
       return response;
    }
}