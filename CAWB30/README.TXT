Welcome to the CA-Realia II Workbench 3.0

This release of the Workbench provides many new features. For an overview of
the new features of this release, please see the "Getting Started" guide,
Chapter 1, in the section entitled "What's New in Release 3.0."

Before you install the Workbench, be aware of the following:

    1 - The product Id needed to install the Workbench is 106830 - 0.

    2 - IF YOU ARE UPGRADING FROM RELEASE 1.X OR 2.X DO NOT
    INSTALL THE WORKBENCH INTO AN EXISTING WORKBENCH DIRECTORY!!

    3 - The suggested directory name is CAWB30, choose another name if
    you have a 1.x or 2.x version of the Workbench already installed in that
    directory.

    4 - A special set of migration assistance tools including a
    complete online migration help guide are available to assist those
    who are migrating from older versions of the Workbench.  All
    existing 1.1 and 2.0 users should select "Migration Guide" in the
    online documentation install.

    5 - Use the Workbench CA-Realia COBOL, CA-Realia CICS, and CA-Realia
    LCM components instead of any versions of these products that
    you may have already installed.  Remove older CA-Realia COBOL,
    CICS, and LCM components from the PATH statement.

Running under Windows NT 3.51

    The Workbench requires RPC to be installed.  Most Windows NT machines
    that have a LAN card will already have RPC installed.  To verify RPC,
    go to the Control Panel and double click on the Network icon to
    open Network Settings.  Look in the Installed Network Software list
    box for RPC Configuration.  If you do not find it in the list box then
    you will need to install it as follows:

     1 - Click on the Add Software button and then choose RPC
         Configuration from the Network Software list.

     2 - Click on continue and then follow the on screen instructions to
         install RPC.

     3 - When you are back at the Network Settings dialog,  check the
         Installed Network Software list box to make sure that RPC
         Configuration was added and then click on OK.

     4 - If RPC was installed then you will be prompted to restart your
         computer.  Make sure you close all of your open applications and
         then click on the restart button.  Once your machine reboots the
         Workbench will be ready to run.

Setting up CA-Pan/LCM

    Use the following instructions to setup CA-Pan/LCM on your computer:

    1 - Set the LCMADMIN environmental to point to your ADMIN directory,
    usually C:\CAWB30\ADMIN.

    2 - From the command prompt type: C:\CAWB30\LCMINIT 1111
    to initialize your workstation.  If you have your own unique Id,
    use that instead of 1111.

    CA-Pan/LCM is now ready to run on your computer.

    NOTE: The LCMINIT command can be added to your startup group so
          you will not have to manually run it from the command prompt
          each time you start Windows.


CA-Realia II Workbench Beta Testers:

    If you have an earlier version of the 3.0 release of the Workbench,
    you can either install over the existing Workbench directory or
    delete that directory.  If you decide to delete the existing
    Workbench then first make a copy of your LCMUSERS.CFG files.
    Otherwise you would need to set up all of your LCM users again.
    Also, backup any other work files that contain information you
    might need, including source and options (*.OPT) files.

Setting Up Your PC to Run the Workbench from the LAN:

    If you have already installed the full version of the Workbench
    to a LAN server and wish to install Workstation versions of the
    Workbench, use the NETINST.EXE program to install each workstation.
    With the first installation diskette in a floppy drive, invoke the
    Program Manager 'Run' command.  In the dialog that appears, enter
    the drive and filename of the network install program, for example:

                   A:\NETINST.EXE

    When prompted for the installation directory, enter the
    Workbench's original installation directory on the LAN server.
    This will install only the files necessary for a Workstation
    (approximately 1 KB of data) and it will create the Realia II
    Workbench program manager group.


Obtaining Version Information:

    The version information for the CA-Realia II Workbench is located in the
    About box under the Help menuitem.


Known Problems:

    When closing the CA-Realia II Workbench in Microsoft Windows 95,
    sometimes you will receive an RPCSS error.  If this occurs, shutdown
    Windows 95 and reboot before running the CA-Realia II Workbench again.
    Microsoft has released a fix for this problem which is located at the
    following URL:

    http://www.microsoft.com/kb/softlib/mslfiles/RPCRTUPD.EXE

    This fix is only needed for Windows 95 and should only be applied if
    you have this problem.


Migrating LCM Projects from CA-Realia II Workbench 1.2 or 2.0 to
CA-Realia II Workbench 3.0.

CA-Realia II Workbench 3.0 provides a new Source Code Control interface
which provides a common view to a variety of Source Code Control
providers (CA-Pan/LCM, CA-Endevor, Microsoft SourceSafe and Intersolv
PVCS).  See the CA-Realia II Workbench Getting Started Guide for more
information, capabilities, and setup.  To support this common interface, it
was necessary to change the technique used to identify and use CA-Pan/LCM
projects.  This document describes how to migrate CA-Pan/LCM project
information from older versions of the CA-Realia II Workbench to CA-Realia
Workbench 3.0.

CA-Realia II Workbench versions previous to version 3.0 maintained
detailed LCM project information in the application file (appname.APP).
This information must be migrated from the APP file to a standard
CA-Pan/LCM User Defined Project.  In the process you must also
create a standard CA-Pan/LCM project configuration file (LCMPROJ.CFG)
for each project.  Converting the project information from its APP-file
form to the required LCMPROJ.CFG form can be done in one of two ways.
Creating the LCM User Defined Projects must be done via the CA-Pan/LCM
Shell.


Converting the project information to LCMPROJ.CFG form --

If the pre-3.0 version of CA-Realia II Workbench is available, you can
easily create the necessary LCMPROJ.CFG file using the following
procedure.

1. Initiate the earlier version of CA-Realia II Workbench.
2. Open the application containing the LCM project information you wish
   to migrate to CA-Realia II Workbench 3.0.
3. Select Options and then Archive to display the CA-Realia LCM
   Options dialog.
4. Click on the Project... button to display the CA-Realia LCM Project
   Directories dialog.
5. Select the "CA-Realia LCM LCMPROJ.CFG Project File" option.
6. Click on OK.  This will save the project information into the
   LCMPROJ.CFG file in the "work" directory.
7. Repeat this process for all applications which you wish to migrate
   starting at item 2.
8. Close the CA-Realia II Workbench.

If the earlier version of the CA-Realia II Workbench is not available,
then you must create the project information manually.  You can either
use a text editor to extract the project information from the
application file (appname.APP) and save it as an LCMPROJ.CFG file in
the work directory or you create the project manually using the
CA-Pan/LCM Shell.


Creating the LCMPROJ.CFG file from the application file.

1. Open the appname.APP file using a text editor.  This file is a
   standard Windows INI file.
2. Locate the section [LCM:Project]. There should be 6 entries in the
   section - Work, Arch, Base, Back, Log, and Act.
3. Select those 6 lines with your text editor and save them with the
   file name - LCMPROJ.CFG in the directory identified in the Work
   entry.

Repeat this procedure for each application you wish to migrate.


Creating the CA-Pan/LCM User Defined Projects --

The CA-Pan/LCM Shell is used to create the User Defined Projects for
each of the LCMPROJ.CFG files you created in the earlier steps.  You
can also use the Shell to create the LCMPROJ.CFG file manually if
it was not created in a previous step.

1. Open the CA-Pan/LCM Shell and select File and then New... to display
   the Define a User Defined Project dialog.
2. Enter the name for the project.  The name must be unique within
   your installation.  It can be up to 79 characters long and it may
   contain blanks and special characters.  Make it descriptive but not
   excessively long.
3. Enter the work directory name for the project in the Project
   Directory field.
4. If you have not previously specified the LCMPROJ.CFG for this project,
   you can manually enter the directory names at this time.  If the
   LCMPROJ.CFG file is in the work directory, then it is automatically
   used.
4. Click on OK to define the project.
5. You can verify the correct specification of your project by selecting
   File and then Open and then User Defined Project... to display the Open
   a User Defined Project dialog.  The project you just defined should be
   visible in the list.  Select it and click OK.  Then select File and then
   Project and then Display... to display the Project Configuration dialog.
   This dialog displays each individual project directory value.  If any
   modifications are required select File and then Project and then Modify...

Repeat this procedure for each project you wish to migrate.

Using the CA-Pan/LCM User Defined Projects in the CA-Realia II Workbench --

All CA-Realia II Workbench Source Control functions are accessed by selecting
File and then Source Control.  You select a project via the Select Project
menu item which displays the Select Project dialog.  Select the desired
project in the User Defined Project field.  Selected project directories are
immediately displayed.  Click on OK to select the selected project.

The selected CA-Pan/LCM user defined project name is automatically associated
with any open application.  Therefore when you later start the CA-Realia
Workbench and open that application, the CA-Pan/LCM project associated with
that application is automatically re-selected.

