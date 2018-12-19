# xg-azure
This customized template automates the conversion of a standalone Pay As You Go (PAYG) Sophos XG on Azure to a standalone Bring Your Own License (BYOL) Sophos XG on Azure

Deploying
=========

1) Press the appropriate deployment button and enter your Azure credentials when prompted.

[![Deploy to Azure](https://azuredeploy.net/deploybutton.png)](https://portal.azure.com/#create/Microsoft.Template/uri/https://raw.githubusercontent.com/davidokeyode/sophos-xg-azure-custom-templates/payg-to-byol-conversion/mainTemplate.json)

[![Deploy to Azure Gov](https://azuredeploy.net/AzureGov.png)](https://portal.azure.us/#create/Microsoft.Template/uri/https://raw.githubusercontent.com/davidokeyode/sophos-xg-azure-custom-templates/payg-to-byol-conversion/mainTemplate.json)

2) Take a look on the example values for template parameters in `mainTemplateParameters.json`.

**If invalid parameters are passed, the deployment will fail.**

Please note:
* The `adminPassword` has to be minimum 8 characters, **containing at least a lowercase letter, an uppercase letter, a number, and a special character.**

3) Deployment will start.

4) Wait until the deployment goes to state "Succeeded".

***

Connect to the VM instance
==========================

[https://full-dns-name:4444](https://full-dns-name:4444)

***
