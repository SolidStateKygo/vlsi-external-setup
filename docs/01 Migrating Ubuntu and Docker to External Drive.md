This guide explains how to move your WSL distribution and Docker data to an external drive (assumed to be `E:`).

## Prerequisites

- External HDD/SSD connected as Drive `E:` (formatted as NTFS).
    
- PowerShell running as **Administrator**.
    

## Part A: Move Ubuntu to External Drive

1. **Create Folders on External Drive** Run in PowerShell (Admin):
    
    ```
    New-Item -Path "E:\wsl_export" -ItemType Directory
    New-Item -Path "E:\wsl_storage\Ubuntu" -ItemType Directory
    ```
    
2. **Export and Unregister** Save your current Ubuntu state and remove it from C:.
    
    ```
    wsl --shutdown
    wsl --export Ubuntu "E:\wsl_export\ubuntu.tar"
    wsl --unregister Ubuntu
    ```
    
3. **Import to External Drive** Restore Ubuntu, but point it to the new `E:` location.
    
    ```
    wsl --import Ubuntu "E:\wsl_storage\Ubuntu" "E:\wsl_export\ubuntu.tar" --version 2
    ```
    
4. **Verify** Launch Ubuntu:
    
    ```
    wsl -d Ubuntu
    ```
    
    You are now running from the external drive! You can delete `E:\wsl_export\ubuntu.tar` once confirmed.
    

## Part B: Move Docker Data

Docker Desktop stores large images on C: by default. We will move this using the built-in settings.

1. Open **Docker Desktop**.
    
2. Go to **Settings** (Gear Icon) -> **Resources** -> **Advanced**.
    
3. Locate **"Disk image location"**.
    
4. Click **Browse** and select a folder on your external drive (e.g., `E:\docker_storage`).
    
5. Click **Apply & Restart**.
    

Docker will automatically move its data (`.vhdx`) to the external drive.

**Next Step:** Proceed to [[Post Migration Setup]] to fix user permissions.
