import { LightningElement, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import submit from '@salesforce/apex/FinDockCommunityController.submit';

export default class Findockcommunitypayments extends NavigationMixin(LightningElement) {
    amount = 0;
    firstName = '';
    lastName = '';
    email = '';
    paymentMethod = '';
    // installmentId = '';

    // Options for payment method combobox. 
    // Instead of hardcoding, you could get the values of the cpm__Payment_Method__c picklist on cpm__Installment__c.
    // TODO: implement with getPicklistValues
    get payment_options() {
        return [
            { label: 'Credit Card', value: 'CreditCard' },
            { label: 'iDEAL', value: 'ideal' },
            { label: 'Direct Debit', value: 'Direct Debit' },
        ];
    }

    // Capture field input
    handleChange(event) {
        this[event.target.name] = event.target.value;
    }

    // Handle the clicking of the 'To payment' button
    handleClick( event ) {
        // Create our API input from the user input
        var input = {
            SuccessURL: 'https://example.com/success',
            FailureURL: 'https://example.com/failure',
            Payer: {
                Contact: {
                    SalesforceFields : {'FirstName': this.firstName,'LastName': this.lastName, 'Email' : this.email}
                }
            },
            OneTime: {
                Amount: this.amount,
                // If you provide an existing InstallmentId, you can leave OneTime.Amount and Payer empty or out.
                // Id: this.installmentId
            },
            PaymentMethod: {
                Name: this.paymentMethod
                // Note that we are not passing a specific Payment Processor, 
                // so the API will use the default processor for this payment method set in FinDock
            },
        }
        // Bundle the form input with additional parameters that the API requires...
        // ...and trigger API Call to FinDock through the Apex Controller. 
        submit({
            jsonObject: JSON.stringify(input)
        // Handle the result of the API call returned by the Controller
        }).then( result => {
            console.log(result)
            // Get the RedirectURL from the result...
            this.RedirectURL = result.RedirectURL;
            // ...and redirect to the Hosted Payment Page of the Payment Processor if required.
            this[NavigationMixin.Navigate]({
                type: 'standard__webPage',
                attributes: {
                    url: this.RedirectURL
                }
            });
        // Catch errors
        }).catch ( error => {
           // Handle errors based on error message
            console.error('Something went horribly wrong! Specifically:')
            console.error(error.name );
            console.error(error.message );
            console.error(error.stack );
        });
    }
}