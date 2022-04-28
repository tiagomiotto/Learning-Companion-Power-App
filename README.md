# Learning-Companion-Power-App
A Power App Solution to help you create and administer trainning activities inside of the organization

## Create the supporting SharePoint Lists
In order for the app to be able to store and managed courses, it relies in SharePoint Lists to store the data. For you to deploy the app in your tenant, you need them to create the necessary SharePoint Lists before importing the app.  
1.	Run the CreateSharepoint.ps1 script and follow the prompts to provide the necessary information.  
a.	The script uses the PnPPowershell module to create the necessary site and lists. If you have never used PnPPowershell to manage your tenant before, you will need to run the following command and login in order to consent to the necessary permissions:  
Register-PnPManagementShellAccess  
b.	If this is the first time running the script & you don’t have the modules installed, you’ll need to run the script with elevated privileges.   
2.	You will be required to login twice while the script runs with an account that has at least SharePoint Administrator permissions.  
After the script is done running, it will output the newly created Sharepoint site, and you can move on to the next step    
Administration PowerApp Setup  
This next section is for the PowerApp that manages the SharePoint lists.  
## Import the PowerApp  
1.	Download the Solution LearningApp.zip from the [releases](https://github.com/tiagomiotto/Learning-Companion-Power-App/releases/tag/latest)
2.	Go to the Power Apps Portal
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


### SharePoint Schema
Custom lists: 
1.	“Courses”
o	“Title” (default column) – Name of course.
o	“WelcomeMessage” – text to display to users to introduce the course.
o	“Start” – date of when course starts
o	“Course Image” – Base64 Image of the course
o	“Facilitator” – The course facilitator
o	“Days Before to Send Reminder” – Number of days before the course to alert attendees, default is 3
o	“TeamID” – ID of the Team in which the course takes place
o	“ChannelID” – ID of the channel where the course takes place
o	“Learner App Link” – Link to the Teams Tab with the Learner App
o	“CourseImgBase64” – a base 64 encoded image for the course to use in adaptive cards. If none specified, a default image is used. 
2.	“Course Attendance”
o	“Title” (default column) – course ID of the parent course.
o	“AssignedUserLookupId” – person lookup – person assigned to course.
o	“QARole” – The attendees role
o	“QAOrg” – The attendees oraganization
o	“QACountry” – The attendees country
o	“QASpareTimeActivity” – The attendees spare time activity
o	“QAMobilePhone” – The attendees mobile phone
o	“Bot contacted”- Has the user been contacted by the Bot
o	“IntroductionDone” – Has the user introduced himself/herself
3.	“Course Checklist”  
o	“Title” (default column) – requirement description for users to complete.
o	“CourseID” – course ID of parent course.
o	“Learning Programme”- Name of the parent course
o	“Associated Module” – The course module the activity is a part of
o	“Description” – The activity description
o	“Resource to use” – A resource to be used
o	“Minutes to Complete” – Approximated minutes to complete the activity
o	“Due date” – Due date for the activity

4.	“Checklist Confirmations”
o	“ChecklistID” – checklist ID of the parent requirement.
o	“DoneByLookupId” (“DoneBy”) – person lookup of user that’s completed the item.
o	“CourseID” – ID of the course the activity is related too
