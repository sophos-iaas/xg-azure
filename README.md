# xg-azure
Deployment template to deploy Sophos XG to Azure

Deploying
=========

Deployment via Marketplace
--------------------------

1) Got to Azure Marketplace and search for 'Sophos'

2) Select the "'Sophos XG Firewall (Public Preview)' offer and follow the deployment wizard

Deployment via template
-----------------------

1) Press the button and enter your Azure credentials when prompted.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fsophos-iaas%2Fxg-azure%2Fmaster%2FmainTemplate.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>

</a>
2) Take a look on the example values for template parameters in mainTemplateParameters.json

**If invalid parameters are passed, the deployment will fail. Especially note that the adminPassword has to be minimum 8 characters, consisting out of at least one small, uppercase letter, number and special character.**

3) Deployment will start

4) Wait until the deployment goes to state "Succeeded"

***

Connect to the VM instance
==========================

[https://full-dns-name:4444](https://full-dns-name:4444)

***

Registration
============

1) Get a demo license
<a href="https://secure2.sophos.com/en-us/products/next-gen-firewall/free-trial.aspx">Sophos - Free Trial</a>

2) Enter the serial number you received via email on your XG Firewall and activate the device

3) Register the device and follow the instructions

4) Make sure the license is synchronized

***

Device Setup
============

Either choose to run the Basic Setup wizard, or skip it and start to configure the device instantly.

***

UI Preview
==========
This will not start a deployment yet.

<a href="https://portal.azure.com/#blade/Microsoft_Azure_Compute/CreateMultiVmWizardBlade/internal_bladeCallId/anything/internal_bladeCallerParams/{&quot;initialData&quot;:{},&quot;providerConfig&quot;:{&quot;createUiDefinition&quot;:&quot;https%3A%2F%2Fraw.githubusercontent.com%2Fsophos-iaas%2Fxg-azure%2Fmaster%2FcreateUiDefinition.json
&quot;}}">[Preview createUiDefinition.json]</a>

***

Links
=====

[Authoring Azure Resource Manager templates](https://azure.microsoft.com/en-us/documentation/articles/resource-group-authoring-templates/)
