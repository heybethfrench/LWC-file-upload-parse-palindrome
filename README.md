This component is a standalone component that can be dropped into any Salesforce org.  The only thing it stores in Salesforce is the txt File.  It takes in a txt file that contains sentences separated by new lines, and then it checks then to see if they are palindromes.  Each palindrome is displayed with a character count analysis.

#TODOS
- 100% Code coverage for Apex Classes
- Handle null values
- Add try catch blocks
- Handle for and notify user when there are no palindromes
- Handle for multiple files uploaded at one time
- Handle for files of different doctypes
- Potentially store the data in Salesforce and create dashboards/reports on different metrics
- Clean up and refactor code for performance
- Display letter count totals
- Convert to datatable
- Conditionally render the file upload input
- Line 40 in FileUploadHelper, use only Regex


#DONE
- Removed nested for loops


# Salesforce DX Project: Next Steps

Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started.

## How Do You Plan to Deploy Your Changes?

Do you want to deploy a set of changes, or create a self-contained application? Choose a [development model](https://developer.salesforce.com/tools/vscode/en/user-guide/development-models).

## Configure Your Salesforce DX Project

The `sfdx-project.json` file contains useful configuration information for your project. See [Salesforce DX Project Configuration](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_config.htm) in the _Salesforce DX Developer Guide_ for details about this file.

## Read All About It

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)
