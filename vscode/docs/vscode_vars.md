# VSCode Predefined Variables

See [VSCode Variables](https://code.visualstudio.com/docs/editor/variables-reference#_variables-scoped-per-workspace-folder)

Predefined variables
The following predefined variables are supported:

${userHome} - the path of the user's home folder
${workspaceFolder} - the path of the folder opened in VS Code
${workspaceFolderBasename} - the name of the folder opened in VS Code without any slashes (/)
${file} - the current opened file
${fileWorkspaceFolder} - the current opened file's workspace folder
${relativeFile} - the current opened file relative to workspaceFolder
${relativeFileDirname} - the current opened file's dirname relative to workspaceFolder
${fileBasename} - the current opened file's basename
${fileBasenameNoExtension} - the current opened file's basename with no file extension
${fileExtname} - the current opened file's extension
${fileDirname} - the current opened file's folder path
${fileDirnameBasename} - the current opened file's folder name
${cwd} - the task runner's current working directory upon the startup of VS Code
${lineNumber} - the current selected line number in the active file
${selectedText} - the current selected text in the active file
${execPath} - the path to the running VS Code executable
${defaultBuildTask} - the name of the default build task
${pathSeparator} - the character used by the operating system to separate components in file paths
Predefined variables examples
Supposing that you have the following requirements:

A file located at /home/your-username/your-project/folder/file.ext opened in your editor;
The directory /home/your-username/your-project opened as your root workspace.
So you will have the following values for each variable:

${userHome} - /home/your-username
${workspaceFolder} - /home/your-username/your-project
${workspaceFolderBasename} - your-project
${file} - /home/your-username/your-project/folder/file.ext
${fileWorkspaceFolder} - /home/your-username/your-project
${relativeFile} - folder/file.ext
${relativeFileDirname} - folder
${fileBasename} - file.ext
${fileBasenameNoExtension} - file
${fileDirname} - /home/your-username/your-project/folder
${fileExtname} - .ext
${lineNumber} - line number of the cursor
${selectedText} - text selected in your code editor
${execPath} - location of Code.exe
${pathSeparator} - / on macOS or linux, \ on Windows

Tip: Use IntelliSense inside string values for tasks.json and launch.json to get a full list of predefined variables.

Variables scoped per workspace folder
By appending the root folder's name to a variable (separated by a colon), it is possible to reach into sibling root folders of a workspace. Without the root folder name, the variable is scoped to the same folder where it is used.

For example, in a multi root workspace with folders Server and Client, a ${workspaceFolder:Client} refers to the path of the Client root.

Environment variables
You can also reference environment variables through the ${env:Name} syntax (for example, ${env:USERNAME}).

{
  "type": "node",
  "request": "launch",
  "name": "Launch Program",
  "program": "${workspaceFolder}/app.js",
  "cwd": "${workspaceFolder}",
  "args": ["${env:USERNAME}"]
}
Configuration variables
You can reference VS Code settings ("configurations") through ${config:Name} syntax (for example, ${config:editor.fontSize}).

Command variables
If the predefined variables from above are not sufficient, you can use any VS Code command as a variable through the ${command:commandID} syntax.

A command variable is replaced with the (string) result from the command evaluation. The implementation of a command can range from a simple calculation with no UI, to some sophisticated functionality based on the UI features available via VS Code's extension API. If the command returns anything other than a string, then the variable replacement will not complete. Command variables must return a string.

An example of this functionality is in VS Code's Node.js debugger extension, which provides an interactive command extension.pickNodeProcess for selecting a single process from the list of all running Node.js processes. The command returns the process ID of the selected process. This makes it possible to use the extension.pickNodeProcess command in an Attach by Process ID launch configuration in the following way:

{
  "configurations": [
    {
      "type": "node",
      "request": "attach",
      "name": "Attach by Process ID",
      "processId": "${command:extension.pickNodeProcess}"
    }
  ]
}
When using a command variable in a launch.json configuration, the enclosing launch.json configuration is passed as an object to the command via an argument. This allows commands to know the context and parameters of the specific launch.json configuration when they are called.

Input variables
Command variables are already powerful but they lack a mechanism to configure the command being run for a specific use case. For example, it is not possible to pass a prompt message or a default value to a generic "user input prompt".

This limitation is solved with input variables which have the syntax: ${input:variableID}. The variableID refers to entries in the inputs section of launch.json and tasks.json, where additional configuration attributes are specified. Nesting of input variables is not supported.

The following example shows the overall structure of a tasks.json that makes use of input variables:

{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "task name",
      "command": "${input:variableID}"
      // ...
    }
  ],
  "inputs": [
    {
      "id": "variableID",
      "type": "type of input variable"
      // type specific configuration attributes
    }
  ]
}
Currently VS Code supports three types of input variables:

promptString: Shows an input box to get a string from the user.
pickString: Shows a Quick Pick dropdown to let the user select from several options.
command: Runs an arbitrary command.
Each type requires additional configuration attributes:

promptString:

description: Shown in the quick input, provides context for the input.
default: Default value that will be used if the user doesn't enter something else.
password: Set to true to input with a password prompt that will not show the typed value.
pickString:

description: Shown in the quick pick, provides context for the input.
options: An array of options for the user to pick from.
default: Default value that will be used if the user doesn't enter something else. It must be one of the option values.
An option can be a string value or an object with both a label and value. The dropdown will display label: value.

command:

command: Command being run on variable interpolation.
args: Optional option bag passed to the command's implementation.
Below is an example of a tasks.json that illustrates the use of inputs using Angular CLI:

{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "ng g",
      "type": "shell",
      "command": "ng",
      "args": ["g", "${input:componentType}", "${input:componentName}"]
    }
  ],
  "inputs": [
    {
      "type": "pickString",
      "id": "componentType",
      "description": "What type of component do you want to create?",
      "options": [
        "component",
        "directive",
        "pipe",
        "service",
        "class",
        "guard",
        "interface",
        "enum"
      ],
      "default": "component"
    },
    {
      "type": "promptString",
      "id": "componentName",
      "description": "Name your component.",
      "default": "my-new-component"
    }
  ]
}