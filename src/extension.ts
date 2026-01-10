import * as vscode from 'vscode';
import { exec } from 'child_process';

export function activate(context: vscode.ExtensionContext) {
  const outputChannel = vscode.window.createOutputChannel("Dynare Output");

  const runCommand = vscode.commands.registerCommand('dynare.run', () => {
    const editor = vscode.window.activeTextEditor;
    if (!editor) {
      vscode.window.showErrorMessage("No file open.");
      return;
    }

    const filePath = editor.document.fileName;

    if (!filePath.endsWith('.mod')) {
      vscode.window.showErrorMessage("Not a Dynare file (.mod).");
      return;
    }

    exec(`dynare ${filePath}`, (err: Error | null, stdout: string, stderr: string) => {
      if (err) {
        vscode.window.showErrorMessage("Execution error. Check output.");
        outputChannel.show();
        outputChannel.appendLine(stderr);
        return;
      }
      vscode.window.showInformationMessage("Dynare executed successfully.");
      outputChannel.show();
      outputChannel.appendLine(stdout);
    });
  });

  context.subscriptions.push(runCommand);
}