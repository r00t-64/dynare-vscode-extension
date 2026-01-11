import * as vscode from 'vscode';
import * as path from 'path';
import { exec } from 'child_process';
import { spawn } from 'child_process';


export function activate(context: vscode.ExtensionContext) {
  const output = vscode.window.createOutputChannel("Dynare");

  const runCommand = vscode.commands.registerCommand('dynare.run', () => {
    const editor = vscode.window.activeTextEditor;
    if (!editor) {
      vscode.window.showErrorMessage("No active file");
      return;
    }

    const filePath = editor.document.fileName;

    if (!filePath.endsWith('.mod')) {
      vscode.window.showErrorMessage("Not a .mod Dynare file");
      return;
    }

    const fileDir = path.dirname(filePath);
    const fileBase = path.basename(filePath);

    // Clean panel
    output.clear();
    output.appendLine(`▶ Running: dynare ${fileBase}`);
    output.show(true);

    const proc = spawn('dynare', [fileBase], {
      cwd: fileDir,
      shell: true
    });

    proc.stdout.on('data', (data) => {
      output.append(data.toString());
    });

    proc.stderr.on('data', (data) => {
      output.append(data.toString());
    });

    proc.on('close', (code) => {
      if (code === 0) {
        output.appendLine("\n✓ Completed");
        vscode.window.showInformationMessage("Dynare completed successfully.");
      } else {
        output.appendLine(`\n❌ Exit code: ${code}`);
        vscode.window.showErrorMessage("Dynare failed — see output panel.");
      }
    });
  });


  context.subscriptions.push(runCommand);
}
