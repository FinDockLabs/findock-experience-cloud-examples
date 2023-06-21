# FinDock Community Payments examples

This repository contains example code to integrate the [FinDock](www.findock.com) payment API with Salesforce Communities, in support of 2 blogs on the FinDock website. They are free to use and extend as-is. FinDock does not provide support on LWC, Apex or Flow development, but can help you with questions on the FinDock API.

The example code was intentionally left very basic (e.g. little proper error handling, no test code) to keep it easy to understand.
Please make sure to implement proper coding standards yourself!

For more information on the API, please visit:

- [Getting started with the Payment API](https://docs.findock.com/getting-started-with-the-payment-api-v2)
- [API Reference](https://docs.findock.com/api)

## Content

This repository contains code for 3 examples:

1. A LWC component `communitypayments` with Apex Controller `FinDockCommunityController.cls` that can be added to a Salesforce Community page.
2. A Flow action Apex class `FinDockCommunityAction.cls` you can integrate in a Flow, by passing a JSON object as String from the Flow to an `InvocableMethod` in the Apex class. You can then embed this Flow in a Lightning Component (Aura) `aura/FinDockCommunityPaymentActionFlow`  and add that to a Salesforce Community page. Example Flow that you can deploy to your org: `flows/FinDock_Community_Payment.flow-meta.xml`
3. A Flow action Apex class `FinDockCommunityActionInvocables.cls` that can be integrated in a Flow by just setting the `@InvocableVariables` to pass to the API. You can then embed this Flow in a Lightning Component (Aura) `aura/FinDockCommunityPaymentActionInvocablesFlow` and add that to a Salesforce Community page. Example Flow that you can deploy to your org: `flows/FinDock_Community_Payment_Invocables.flow-meta.xml`

These examples are described in two blogs:

- [Collect Payments in Salesforce Experience Cloud (Part 1)](https://findock.com/development/collect-payments-in-salesforce-experience-cloud-part-1/) describes example 1.
- [Collect Payments in Salesforce Experience Cloud (Part 2)](https://findock.com/development/collect-payments-in-salesforce-experience-cloud-part-2/) describes examples 2 and 3.

## Salesforce DX Project

Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started.

### How Do You Plan to Deploy Your Changes?

Do you want to deploy a set of changes, or create a self-contained application? Choose a [development model](https://developer.salesforce.com/tools/vscode/en/user-guide/development-models).

### Configure Your Salesforce DX Project

The `sfdx-project.json` file contains useful configuration information for your project. See [Salesforce DX Project Configuration](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_config.htm) in the _Salesforce DX Developer Guide_ for details about this file.

### Read All About It

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)

## Contributing

When contributing to this repository, please first discuss the change you wish to make via an issue or any other method with FinDock before making a change.

## Support

FinDock Labs is a non-supported group in FinDock that releases applications. Despite the name, assistance for any of these applications is not provided by FinDock Support because they are not officially supported features. For a list of these apps, visit the FinDock Labs account on Github. 

## License

This project is licensed under the MIT License - see the [LICENSE](/LICENSE) file for details