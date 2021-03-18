import { LightningElement } from 'lwc';
import submit from '@salesforce/apex/FinDockCommunityController.submit';

export default class Findockcommunitypayments extends LightningElement {
    
    handleClick( event ) {
        var input = {
            SuccessURL: 'https://example.com/success',
            FailureURL: 'https://example.com/failure',
            Payer: {
                Contact : {
                    SalesforceFields : {'FirstName':'Bob','LastName':'Smith'}
                }
            },
            OneTime: {
                Amount: '10'
            },
            PaymentMethod : {
                Name : 'CreditCard',
            },
        }
        submit({
            jsonObject: JSON.stringify(input)
        }).then( data => {
            console.log(data)
            // do something with the response
        }).catch ( error => {
            console.log('Something went horribly wrong!')
        });
    }
}