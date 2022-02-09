# Learning-Companion-Power-App
A Power App Solution to help you create and administer trainning activities inside of the organization

Create the supporting SharePoint Lists
In order for the app to be able to store and managed courses, it relies in SharePoint Lists to store the data. For you to deploy the app in your tenant, you need them to create the necessary SharePoint Lists before importing the app.
1.	Run the CreateSharepoint.ps1 script and follow the prompts to provide the necessary information.
a.	The script uses the PnPPowershell module to create the necessary site and lists. If you have never used PnPPowershell to manage your tenant before, you will need to run the following command and login in order to consent to the necessary permissions:
Register-PnPManagementShellAccess
b.	If this is the first time running the script & you don’t have the modules installed, you’ll need to run the script with elevated privileges. 
2.	You will be required to login twice while the script runs with an account that has at least SharePoint Administrator permissions.
After the script is done running, it will output the newly created Sharepoint site, and you can move on to the next step
Administration PowerApp Setup
This next section is for the PowerApp that manages the SharePoint lists.
Import the PowerApp
1.	You will find one .zip in this email.
2.	Go to Power Apps,
3.	Click on Data, connections, and then new connections
4.	Look for SharePoint and click on the “+” and then click on Create
5.	Go to the Solutions Page and click on Import on the top
7.	Click on Browse and look for the .zip  file you have downloaded
10.	Click on Next
12.	Select the Connection you created previously for SharePoint Online and click next
14.	Fill out the Environment variables with the Sharepoint Site you have created previously. Where the LearningHQ will be the Site and the lists will be the ones with the same name.
16.	Afterwards click Import
18.	Wait for the solution to finish importing and the green banner to appear
21.	After the solution finished importing, you should see both the Learning Admin and the Learning User Portal in the Apps page
23.	Clicking on the ellipsis (…) allows you to play, edit, share the app and see its details
25.	In the details page, you can also get a direct link to the app, see analytics and more
27.	To allow other users to access the App, open the Share panel and share it with the selected users or groups. You can also use the Share pane to add other users as Co-Owners of your app
