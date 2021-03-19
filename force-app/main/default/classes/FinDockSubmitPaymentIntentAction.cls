public class FinDockSubmitPaymentIntentAction {

    public class FlowOutput {
        @invocableVariable public String paymentIntentId;    
        @invocableVariable public String redirectUrl;
        @invocableVariable public Integer statusCode;
        @invocableVariable public String requestBody;
        @invocableVariable public String responseBody; 
        @invocableVariable public String firstErrorMessage;
     
        @invocableVariable public String PaymentMethod_Name;         
        @invocableVariable public String PaymentMethod_Processor; 
        @invocableVariable public String PaymentMethod_Target; 
        
        @invocableVariable public String Settings_SourceConnector; 
        @invocableVariable public String Settings_ProcessingType;         
    }
    
    public class FlowInput {
        
        @invocableVariable public String PaymentIntent_SuccessUrl = 'https://notprovided.com';
		@invocableVariable public String PaymentIntent_FailureUrl = 'https://notprovided.com';
        @invocableVariable public String PaymentIntent_IdempotencyKey; 
        @invocableVariable public String PaymentIntent_Origin; 
        @invocableVariable public String PaymentIntent_CampaignId; 
        @invocableVariable public String PaymentIntent_Webhook_URL; 
        
		@invocableVariable public Id Payer_Contact_Id;
        @invocableVariable public String Payer_Contact_RecordTypeName;        
        
        @invocableVariable public Id Payer_Account_Id;
        @invocableVariable public String Payer_Account_RecordTypeName; 

        @invocableVariable public Double OneTime_Amount;
        @invocableVariable public String OneTime_CurrencyIsoCode; 
 		
        @invocableVariable public Double Recurring_Amount;
        @invocableVariable public String Recurring_Frequency;
        @invocableVariable public Date Recurring_StartDate;
		@invocableVariable public Date Recurring_EndDate; 
   		@invocableVariable public String Recurring_CurrencyIsoCode; 
        
        @invocableVariable public String PaymentMethod_Name;         
        @invocableVariable public String PaymentMethod_Processor; 
        @invocableVariable public String PaymentMethod_Target; 
        
		@invocableVariable public String PaymentMethod_Parameters_description;
		@invocableVariable public String PaymentMethod_Parameters_locale;        
		@invocableVariable public String PaymentMethod_Parameters_iban;                
		@invocableVariable public String PaymentMethod_Parameters_holderName;
		@invocableVariable public String PaymentMethod_Parameters_bic;
		@invocableVariable public String PaymentMethod_Parameters_clearingMemberId;          
		@invocableVariable public String PaymentMethod_Parameters_idealIssuer;      
		@invocableVariable public String PaymentMethod_Parameters_creditCardBrand;
		@invocableVariable public String PaymentMethod_Parameters_bankAccount;
		@invocableVariable public String PaymentMethod_Parameters_sortCode;           
       
        @invocableVariable public String Settings_SourceConnector; 
        @invocableVariable public String Settings_ProcessingType; 
        
        @invocableVariable public String SalesforceField_Account_01_Name;
		@invocableVariable public String SalesforceField_Account_01_Value;   
        @invocableVariable public String SalesforceField_Account_02_Name;
		@invocableVariable public String SalesforceField_Account_02_Value;
        @invocableVariable public String SalesforceField_Account_03_Name;
		@invocableVariable public String SalesforceField_Account_03_Value;
        @invocableVariable public String SalesforceField_Account_04_Name;
		@invocableVariable public String SalesforceField_Account_04_Value;
        @invocableVariable public String SalesforceField_Account_05_Name;
		@invocableVariable public String SalesforceField_Account_05_Value; 
        @invocableVariable public String SalesforceField_Account_06_Name;
		@invocableVariable public String SalesforceField_Account_06_Value;   
        @invocableVariable public String SalesforceField_Account_07_Name;
		@invocableVariable public String SalesforceField_Account_07_Value;  
        @invocableVariable public String SalesforceField_Account_08_Name;
		@invocableVariable public String SalesforceField_Account_08_Value;
        @invocableVariable public String SalesforceField_Account_09_Name;
		@invocableVariable public String SalesforceField_Account_09_Value;
        @invocableVariable public String SalesforceField_Account_10_Name;
		@invocableVariable public String SalesforceField_Account_10_Value; 
        
        @invocableVariable public String SalesforceField_Contact_01_Name;
		@invocableVariable public String SalesforceField_Contact_01_Value;   
        @invocableVariable public String SalesforceField_Contact_02_Name;
		@invocableVariable public String SalesforceField_Contact_02_Value;
        @invocableVariable public String SalesforceField_Contact_03_Name;
		@invocableVariable public String SalesforceField_Contact_03_Value;
        @invocableVariable public String SalesforceField_Contact_04_Name;
		@invocableVariable public String SalesforceField_Contact_04_Value;
        @invocableVariable public String SalesforceField_Contact_05_Name;
		@invocableVariable public String SalesforceField_Contact_05_Value; 
        @invocableVariable public String SalesforceField_Contact_06_Name;
		@invocableVariable public String SalesforceField_Contact_06_Value;   
        @invocableVariable public String SalesforceField_Contact_07_Name;
		@invocableVariable public String SalesforceField_Contact_07_Value;  
        @invocableVariable public String SalesforceField_Contact_08_Name;
		@invocableVariable public String SalesforceField_Contact_08_Value;
        @invocableVariable public String SalesforceField_Contact_09_Name;
		@invocableVariable public String SalesforceField_Contact_09_Value;
        @invocableVariable public String SalesforceField_Contact_10_Name;
		@invocableVariable public String SalesforceField_Contact_10_Value;  
        
        @invocableVariable public String SalesforceField_OneTime_01_Name;
		@invocableVariable public String SalesforceField_OneTime_01_Value;   
        @invocableVariable public String SalesforceField_OneTime_02_Name;
		@invocableVariable public String SalesforceField_OneTime_02_Value;
        @invocableVariable public String SalesforceField_OneTime_03_Name;
		@invocableVariable public String SalesforceField_OneTime_03_Value;          
     
        @invocableVariable public String SalesforceField_PaymentIntent_01_Name;
		@invocableVariable public String SalesforceField_PaymentIntent_01_Value;   
        @invocableVariable public String SalesforceField_PaymentIntent_02_Name;
		@invocableVariable public String SalesforceField_PaymentIntent_02_Value;
        @invocableVariable public String SalesforceField_PaymentIntent_03_Name;
		@invocableVariable public String SalesforceField_PaymentIntent_03_Value;        
        
        @invocableVariable public String SalesforceField_Recurring_01_Name;
		@invocableVariable public String SalesforceField_Recurring_01_Value;   
        @invocableVariable public String SalesforceField_Recurring_02_Name;
		@invocableVariable public String SalesforceField_Recurring_02_Value;
        @invocableVariable public String SalesforceField_Recurring_03_Name;
		@invocableVariable public String SalesforceField_Recurring_03_Value;
     
    }    
    
	@InvocableMethod(label='FinDock Submit Payment Intent')
   	public static List<FlowOutput> submitPamentIntent(List<FlowInput> flowInputs) {
        List<FlowOutput> outputs = new List<FlowOutput>();
        Map<String, Object> sfFieldNames = new Map<String, Object>();
        Map<String, Object> sfFieldValues = new Map<String, Object>();
        
        for (FlowInput flowInput: flowInputs) {
            PaymentIntent pi = newPaymentIntent();

			Map<String, Object> flowInputVariables = (Map<String, Object>)JSON.deserializeUntyped(JSON.serialize(flowInput, true));
            for (String name: flowInputVariables.keySet()) {
            	handleFlowInputVariable(pi, name, flowInputVariables.get(name), sfFieldNames, sfFieldValues);  
            }
            
            FlowOutput output = pi.submit();
            
            outputs.add(output);
        }
       	return outputs;
    }
    
    private static void handleFlowInputVariable(PaymentIntent pi, String name, Object value, Map<String, Object> sfFieldNames, Map<String, Object> sfFieldValues) {
        if (value != null) {
            Map<Object, Object> section = pi.body;
            List<String> parts = name.split('_');
            
            // Check if it's Salesforce Field related
            if (parts.size() == 4 && parts[0] == 'SalesforceField') {
                String key = parts[1] + '_' + parts[2];
                if (parts[3] == 'Name') {
                    sfFieldNames.put(key, value);
                } else if (parts[3] == 'Value') {
                    sfFieldValues.put(key, value);
                }
                
                if (sfFieldNames.containsKey(key) && sfFieldValues.containsKey(key)) {
                    if (parts[1] == 'Account' || parts[1] == 'Contact') {
                        section = getSubSection(section, 'Payer');
                    }
                    if (parts[1] != 'PaymentIntent') {
                    	section = getSubSection(section, parts[1]); 
                    }
                    section = getSubSection(section, 'SalesforceFields');    
                    section.put(sfFieldNames.get(key), sfFieldValues.get(key));
                }

            // Check if it's PaymentMethod parameters related
            } else if (parts.size() == 3 && parts[0] == 'PaymentMethod' && parts[1] == 'Parameters') {    
            	section = getSubSection(section, 'PaymentMethod');
                section = getSubSection(section, 'Parameters');
                section.put(parts[2], value);
                
            } else {
                for (Integer i = 0; i < parts.size(); i ++) {
                    
                    if (i == 0 && parts[0] == 'PaymentIntent') {       
                        // Do not create subsection for PaymentIntent. That should go into the root. 
                    } else {
                        if (i < parts.size() - 1) {
                            section = getSubSection(section, parts[i]);
                        } else {
                            section.put(parts[i], value);
                        }
                    }
                }
            }
        }
    }
    
    private static Map<Object, Object> getSubSection(Map<Object, Object> parentSection, String key) {
        if (!parentSection.containsKey(key)) {
            parentSection.put(key, new Map<Object, Object>());
        }
        return (Map<Object, Object>)parentSection.get(key);
    }     

    public static PaymentIntent newPaymentIntent() {
        return new PaymentIntent();
    }

    public class PaymentIntent {
        public Map<Object, Object> body {get; private set;}

        public PaymentIntent() {
            this.body = new Map<Object, Object>(); 
        }
        
        public FlowOutput submit() {
            RestRequest req = new RestRequest();
            RestResponse res = new RestResponse();
            RestContext.request = req;
            RestContext.response = res; 
            req.requestURI = URL.getSalesforceBaseUrl().toExternalForm()+'/services/apexrest/v2/PaymentIntent';
            req.httpMethod = 'POST';
            req.requestBody = Blob.valueOf(JSON.serializePretty(body));
            cpm.API_PaymentIntent_V2.postPaymentIntent();
            
            Map<String, Object> responseMap = (Map<String, Object>)JSON.deserializeUntyped(res.responseBody.toString());
            
            System.debug(JSON.serializePretty(responseMap));
            
      		FlowOutput result = new FlowOutput();
            result.statusCode = res.statusCode;
            result.paymentIntentId = (String)responseMap.get('Id');
            result.redirectUrl = (String)responseMap.get('RedirectURL');
            result.requestBody = req.requestBody.toString();
            result.responseBody = res.responseBody.toString();
            
     
            Map<String, Object> paymentMethodMap = (Map<String, Object>)responseMap.get('PaymentMethod');
            if (paymentMethodMap != null) {
            	result.PaymentMethod_Name = (String)paymentMethodMap.get('Name');   
                result.PaymentMethod_Processor = (String)paymentMethodMap.get('Processor');
                result.PaymentMethod_Target = (String)paymentMethodMap.get('Target'); 
            }
        	       
            Map<String, Object> settingsMap = (Map<String, Object>)responseMap.get('Settings');
            if (settingsMap != null) {
            	result.Settings_SourceConnector = (String)settingsMap.get('SourceConnector');   
                result.Settings_ProcessingType = (String)settingsMap.get('ProcessingType');
            }                    
            
            if (responseMap.containsKey('Errors')) {
                List<Object> errors = (List<Object>)responseMap.get('Errors');
                if (!errors.isEmpty()) {
                    result.firstErrorMessage = (String)((Map<String, Object>)errors[0]).get('error_message');
                }
            }
      		return result;
        }

    }
    
}