import { LightningElement, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import submit from '@salesforce/apex/FinDockCommunityController.submit';

export default class Findockcommunitypayments extends NavigationMixin(LightningElement) {

    @track RedirectURL = '';
    @track ErrorMessage = '';
    handleClick( event ) {
        var input = {
            SuccessURL: 'https://example.com/success',
            FailureURL: 'https://example.com/failure',
            Payer: {
                Contact: {
                    SalesforceFields : {'FirstName':'Bob','LastName':'Smith'}
                }
            },
            OneTime: {
                Amount: '10'
            },
            PaymentMethod: {
                Name: 'CreditCard'
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
            console.log('Something went horribly wrong! ' + error)
        });
    }
}