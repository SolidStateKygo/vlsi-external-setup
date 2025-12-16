# Fix User Permissions

After importing a WSL distro, the default user often resets to `root`. It is unsafe to run tools as root. This guide restores your standard user.

## Steps

1. **Open your Ubuntu Terminal**. It will likely show `root@...`.
    
2. **Create a User** (if you haven't already, or use your existing one): _Replace `username` with your desired name (e.g., aditya)._
    
    ```
    adduser username
    ```
    
3. **Grant Permissions** Give the user `sudo` and `docker` access.
    
    ```
    usermod -aG sudo username
    usermod -aG docker username
    ```
    
4. **Set Default User** Edit the WSL configuration file:
    
    ```
    nano /etc/wsl.conf
    ```
    
    Add the following lines:
    
    ```
    [user]
    default = username
    ```
    
    Press `Ctrl+O` -> `Enter` to save, `Ctrl+X` to exit.
    
5. **Restart WSL** In Windows PowerShell (Admin):
    
    ```
    wsl --shutdown
    ```
    
6. **Verify** Open Ubuntu again. You should be logged in as your user (e.g., `aditya@...`), not root.
    

**Next Step:** You are ready to run the installation scripts in the `scripts/` folder.