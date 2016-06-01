# xg-azure
Deployment template to deploy Sophos XG to Azure

1) Press the button and enter your Azure credentials when prompted.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FSebastianPoehn%2Fxg-azure%2Fmaster%2Fazuredeploy.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
    
</a>
2) Take a look on the example values for template parameters in azuredeploy.parameters.json

**If invalid parametes are passed, the deployment will fail. Especially note that the adminPassword has to be minimum 8 characters, consisting out of at least one small, uppercase letter, number and special character.**

3) Deployment will start

***

UI Preview (will not start a deployment yet):

<a href="https://portal.azure.com/#blade/Microsoft_Azure_Compute/CreateMultiVmWizardBlade/internal_bladeCallId/anything/internal_bladeCallerParams/{&quot;initialData&quot;:{},&quot;providerConfig&quot;:{&quot;createUiDefinition&quot;:&quot;https%3A%2F%2Fraw.githubusercontent.com%2FSebastianPoehn%2Fxg-azure%2Fmaster%2FcreateUiDefinition.json
&quot;}}">[Preview createUiDefinition.json]</a>
