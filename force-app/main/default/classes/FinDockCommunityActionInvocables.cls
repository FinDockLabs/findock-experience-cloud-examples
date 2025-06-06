/* INSERT DESCRIPTION
    */

    public class FinDockCommunityActionInvocables {
        /* Don't forget to give your Site Guest User access to this Apex class through a permission set!
        To execute the API call, the Site Guest User also needs the FinDock Experience Cloud permission set
        and the permission set(s) for your Processor(s) of choice. Read more: https://docs.findock.com/setup/permission-set-groups#findock-permission-sets-1
        */
    
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
            public Map<String, String> SalesforceFields;
        }
    
        public class Account {
            public Map<String, String> SalesforceFields;
        }
    
        // Data on a one-time payment. Replace with Recurring object for recurring payments.
        public class OneTime {
            public double Amount;
            public String Id;
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

        // PaymentIntent response object to account for the fact that the API can respond with a PaymentIntent or Error object
        public class PaymentIntentResponse {
            public PaymentIntent paymentIntent;
            public Error error;
            public Integer status;
        }

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
            public String successURL;
            @InvocableVariable
            public String failureURL;
            @InvocableVariable
            public Double amount;
            @InvocableVariable
            public String installmentId;
            @InvocableVariable
            public String contactFirstName;
            @InvocableVariable
            public String contactLastName;
            @InvocableVariable
            public String contactEmail;
            @InvocableVariable
            public String paymentMethod;
            @InvocableVariable
            public String paymentProcessor;
            @InvocableVariable
            public String redirectURL;
            @InvocableVariable
            public String errorMessage;
            @InvocableVariable
            public Integer status;
        }

        //Unpacks Flow input, submits payment to API and returns API response to Flow
        @InvocableMethod(label='FinDockCommunitySubmitPayment' description='Create a payment with FinDock by passing me a String in the shape of a JSON as defined in https://docs.findock.com/api')
        public static List<FlowInputOutput> submitPamentIntent(List<FlowInputOutput> flowInputs) {

            List<FlowInputOutput> outputs = new List<FlowInputOutput>();
            
            for (FlowInputOutput flowInput: flowInputs) {

                PaymentIntent requestBody = new PaymentIntent();
                requestBody.SuccessURL = flowInput.successURL;
                requestBody.FailureURL = flowInput.failureURL;

                // Create a OneTime object with an Amount. Replace with Recurring object for Recurring payments.
                requestBody.OneTime = new OneTime();
                requestBody.OneTime.Amount = flowInput.amount;
                // If you provide an existing InstallmentId, you can leave OneTime.Amount and Payer empty or out.
                // requestBody.OneTime.Id = flowInput.installmentId;

                // Contact and Account fields can be passed in a SalesforceFields object that accepts ALL standard and custom fields on these objects.
                Map<String, String> contactFields = new Map<String, String>();
                contactFields.put('FirstName', flowInput.contactFirstName);
                contactFields.put('LastName', flowInput.contactLastName);
                contactFields.put('Email', flowInput.contactEmail);
                requestBody.Payer = new Payer();
                requestBody.Payer.Contact = new Contact();
                requestBody.Payer.Contact.SalesforceFields = contactFields;

                // Assign a payment method. 
                // We're not explicitly passing a processor, so the API will use the default processor for the chosen payment method.
                requestBody.PaymentMethod = new PaymentMethod();
                requestBody.PaymentMethod.Name = flowInput.paymentMethod;

                // Submit the request body to the API and get the response
                PaymentIntentResponse response = PaymentIntent.submit(requestBody);

                // Build output to Flow based on what whether PaymentIntent or Errors were returned
                FlowInputOutput output = new FlowInputOutput();

                output.status = response.status;

                // Get RedirectURL if things went well
                if (response.status == 200) {
                    PaymentIntent pi = response.PaymentIntent;
                    output.redirectURL = pi.RedirectURL;
                }

                // Get error message if things didn't go so well
                if (response.status != 200) {
                    Error err = response.Error;
                    output.errorMessage = err.error_message;
                }
                     
                outputs.add(output);
            }
            return outputs;
        }
    
        // Submit the payment to the Payment API.
        public static PaymentIntentResponse submit(PaymentIntent body) {
            
            // Build your API request...
            RestRequest req = new RestRequest();
            RestResponse res = new RestResponse();
            RestContext.request = req;
            RestContext.response = res; 
            req.requestURI = URL.getSalesforceBaseUrl().toExternalForm()+'/services/apexrest/v2/PaymentIntent';
            req.httpMethod = 'POST';
    
            // ...with the input from the user...
            // PaymentIntent body = (PaymentIntent)JSON.deserializeStrict(jsonObject, PaymentIntent.class );
            req.requestBody = Blob.valueOf(JSON.serialize(body, true));
    
            // ...and send the Payment Intent to the FinDock Payment API, by calling the Apex method!
            cpm.API_PaymentIntent_V2.postPaymentIntent();
    
            // Get the response from the FinDock Payment API...
            Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(res.responseBody.toString());
            system.debug(responseMap);

            PaymentIntentResponse result = new PaymentIntentResponse();
            result.status = res.statusCode;
    
            // Check for errors.
            if (res.statusCode != 200) {
                // Do something to throw or handle error. See Error object.
              
                Error error = new Error();
                //get first error
                List<Object> errors = (List<Object>)responseMap.get('Errors');
                if (!errors.isEmpty()) {
                    error.error_message = (String)((Map<String, Object>)errors[0]).get('error_message');
                    error.error_code = (String)((Map<String, Object>)errors[0]).get('error_code');
                }
                system.debug(error);
                result.Error = error;
            }

            // If API call was successfull.
            if (res.statusCode == 200) {
                PaymentIntent pi = new PaymentIntent();
                
                // ...parse valuable data like the Payment Intent Id of your call that's stable accross all FinDock communication like webhooks...  
                pi.Id = (String)responseMap.get('Id');
            
                // ...and maybe some additional information like Payment method and Processor used
                Map<String, Object> paymentMethodMap = (Map<String, Object>)responseMap.get('PaymentMethod');
                if (paymentMethodMap != null) {
                    pi.PaymentMethod = new PaymentMethod();
                    pi.PaymentMethod.Name = (String)paymentMethodMap.get('Name');   
                    pi.PaymentMethod.Processor = (String)paymentMethodMap.get('Processor');
                }
                // ...but most important: the Redirect URL to the Hosted Payment Page of the Processor!
                pi.RedirectUrl = (String)responseMap.get('RedirectURL'); 
                result.paymentIntent = pi;
            }
            
            // Return the result to your LWC
            return result;
        }
    }
