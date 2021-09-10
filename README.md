# WVD QuickStart

Welcome to the WVD QuickStart GitHub repository! The WVD QuickStart is a solution intended to simplify and automate WVD deployments, empowering IT professionals to get started with WVD in a matter of clicks. New to WVD? Check out https://aka.ms/wvddocs for more information. 

By clicking the "Deploy to Azure" button, you will be taken to the Azure Portal for a custom deployment. There, you can fill out the required user input and click "deploy". This will set up some resources needed for the QuickStart, including an Azure DevOps project.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https:%2F%2Fraw.githubusercontent.com%2Fhemanth8010%2Fwvdquickstart%2Fmaster%2Fdeploy.json" target="_blank">
    <img src="https://aka.ms/deploytoazurebutton"/>
</a><br>


Once the initial deployment is complete, the admins should login to the devops agent VM deployed and setup the agent to run pipelines. This is a required step since Microsoft has recently added an additional step to get free devops grants. Follow the instructions here https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/v2-windows?view=azure-devops to setup your agent.

Once the setup is complete, open PowerShell as administrator and install AZ module.

Install-Module Az -Force -AllowClobber

At this point, you are ready to create and run a pipeline. Navigate back to the DevOps project and create a pipeline.


(Disclaimer: No warranties. Use as-is at your own risk)



