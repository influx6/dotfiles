# VSCode Recommendations

Different learnings and recommendations I have gathered around vscode.

## Install extensions from extension.json

It's annoying to have to use .vscode paths to install vscode extensions in new systems, we can actually use `jq` to extract the `recommendations` lists and with some xarg magic call the vscode CLI to install the extensions like below:

```bash
cat .vscode/extensions.json | jq .recommendations[] | xargs -n 1 code --install-extension
```
