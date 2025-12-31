# Neovim Configuration

## Manual LSP Installation

### Strudel LSP Server

The Strudel LSP server is not available in the Mason registry and must be installed manually.

**Installation Steps:**

1. Clone the repository:
```bash
git clone https://github.com/PedroZappa/strudel-lsp-server ~/.local/share/strudel-lsp-server
```

2. Fix the duplicate imports in `server/src/server.ts` (lines 28-36). Remove the duplicate import blocks and ensure you have:
```typescript
import {
  createConnection,
  ProposedFeatures,
  TextDocuments,
  InitializeParams,
  InitializeResult,
  TextDocumentSyncKind,
  DidChangeConfigurationNotification,
  DocumentDiagnosticReportKind,
  type DocumentDiagnosticReport,
  Diagnostic,
  DiagnosticSeverity,
  TextDocumentPositionParams,
  CompletionItem,
  CompletionItemKind,
} from 'vscode-languageserver/node'

import {
  TextDocument
} from 'vscode-languageserver-textdocument'
```

3. Install dependencies and compile:
```bash
cd ~/.local/share/strudel-lsp-server
npm install
cd server && npx tsc
```

4. Create a symlink to make it executable:
```bash
mkdir -p ~/.local/bin
ln -sf ~/.local/share/strudel-lsp-server/server/out/server.js ~/.local/bin/strudel-lsp-server
chmod +x ~/.local/bin/strudel-lsp-server
```

5. Ensure `~/.local/bin` is in your PATH (add to your shell config if needed):
```bash
export PATH="$HOME/.local/bin:$PATH"
```

6. Restart Neovim. The LSP will automatically activate for `.str` files.

**Note:** The configuration in `lua/plugins/lsp.lua` and `lua/plugins/strudel.lua` already handles the LSP setup and filetype detection.
