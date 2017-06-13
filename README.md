# xg-azure
Deployment template to deploy Sophos XG firewall to Azure

Deploying
=========

Deployment via Marketplace
--------------------------

1) Go to Azure Marketplace and search for 'Sophos': https://azure.microsoft.com/marketplace/?term=Sophos

2) Select the "'Sophos XG Firewall' offer and follow the deployment wizard.

Deployment via template
-----------------------

1) Press the appropriate deployment button and enter your Azure credentials when prompted.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fsophos-iaas%2Fxg-azure%2Fmaster%2FmainTemplate.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

<a href="https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fsophos-iaas%2Fxg-azure%2Fmaster%2FmainTemplate.json" target="_blank">
    <img src="https://azuredeploy.net/AzureGov.png"/>
</a>

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

1) Get a demo license here: <a href="https://secure2.sophos.com/en-us/products/next-gen-firewall/free-trial.aspx">Sophos - Free Trial</a>.

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

We also provide an example template for High Availability, which deploys multiple XG firewalls and an Azure loadbalancer.

Configuration sync can be done by using CSFM. Please reach out for your sales or channel representative to learn more about this Sophos product.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fsophos-iaas%2Fxg-azure%2Fmaster%2FinboundHa.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

***

Useful Links
============

* [Authoring Azure Resource Manager templates](https://azure.microsoft.com/en-us/documentation/articles/resource-group-authoring-templates/)
