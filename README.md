# xg-azure
Deployment template to deploy Sophos XG firewall to Azure

Deploying
=========

Deployment via Marketplace
--------------------------

1) Go to Azure Marketplace: https://azuremarketplace.microsoft.com/marketplace/apps?search=Sophos%20XG

2) Select the "'Sophos XG Firewall' offer and follow the deployment wizard.

Deployment via template
-----------------------

1) Press the appropriate deployment button and enter your Azure credentials when prompted.

[![Deploy to Azure](https://azuredeploy.net/deploybutton.png)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fsophos-iaas%2Fxg-azure%2Fmaster%2FmainTemplate.json)

[![Deploy to Azure Gov](https://azuredeploy.net/AzureGov.png)](https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fsophos-iaas%2Fxg-azure%2Fmaster%2FmainTemplate.json)

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

Registration
============

1) Get a demo license here: [Sophos - Free Trial](https://secure2.sophos.com/en-us/products/next-gen-firewall/free-trial.aspx).

2) Enter the serial number you received via e-mail on the admin UI of your XG Firewall and activate the device.

3) Register the device and follow the instructions.

4) Make sure the license is synchronized.

***

Device Setup
============

Either choose to run the Basic Setup wizard, or skip it and start to configure the device instantly.

***

High Availability
=================

We also provide an example template for High Availability deployments which will create multiple XG firewalls and an Azure load balancer.

Configuration sync between the XG nodes can be done by using SCFM. Please reach out to your sales or channel representative to learn more about this Sophos product.

[![Deploy to Azure](https://azuredeploy.net/deploybutton.png)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fsophos-iaas%2Fxg-azure%2Fmaster%2FinboundHa.json)

***

Useful Links
============

* [Authoring Azure Resource Manager templates](https://azure.microsoft.com/en-us/documentation/articles/resource-group-authoring-templates/)
