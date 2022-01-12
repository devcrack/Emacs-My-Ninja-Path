# Using LSP mode for Python Development 
- Go to a function/method definition:
  ```lsp-find-definition```
  
Or  **C-c l g g**

- Find the reference to a function or method
```lsp-find-references```

Or  **C-c l r**

- Renaming Symbols(Variables)
  ```lsp-rename```
  
  **C-c l r r**
  
# Some solved problems

-  **lsp is not Working**
   - First install lsp for python server
   ```
	   pip install python-lsp-server
   ```
   In some times if we dont found the lsp executable we must to add to PATH our ~/.local/bin directory.
   
   For this we could do: ````export PATH=~/.local/bin:$PATH```
   Preferably add to this command to our .bashrc file 
   
   Maybe a restart is required.
	   
- **Smart completion**
  For smart completion we need to set yasnippet.
  
# Things we have to make work 
- [X] Documentation Hover

