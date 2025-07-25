# NixOS-WSL Configuration

A **_NixOS 24.11 configuration_** tailored for running within **_Windows Subsystem for Linux_** (**_WSL_**). This setup promotes **_seamless integration_** between **_Windows_** and **_NixOS_** while preserving NixOS's renowned **_declarative configuration_** approach.

## Features

-   Seamless **_Windows interoperability_**, minimizing the overhead of a traditional virtual machine.
-   **_Cross-filesystem_** access between Linux and Windows.
-   **_User-specific_** and **_system-wide_** configuration isolation.
-   Full **_declarative configuration_** using Nix **_flakes_** for reproductivity.

## Filesystem Hierarchy

```
└── etc
    └── nixos
        └── .dotfiles
            ├── secrets
            │   ├── password
            │   └── ssh
            ├── system
            │   ├── docker.nix
            │   ├── ssh.nix
            │   └── wsl.nix
            ├── user
            │   ├── bash.nix
            │   └── git.nix
            ├── flake.nix
            ├── flake.lock
            ├── configuration.nix
            └── home.nix
```

### flake.nix

`flake.nix` is used in the Nix package manager to define a **_[Nix flake](https://nixos.wiki/wiki/flakes)_**, providing a more **_standardized_** and **_reproducible_** way to manage Nix-based projects. This file specifies: 
-   **Inputs:** External dependencies (_e.g._ `nixpkgs`, `nixos-wsl`).
-   **Outputs:** Configurations, packages, and applications of the flake.

### flake.lock

`flake.lock` **_locks_** the dependencies of the Nix flake to **_specific versions_**, ensuring **_reproducibility_** and preventing **_unexpected updates_** of the configuration.
-   It is **_auto-generated_** when building or updating the system using flakes.
-   This can be stored in **_version control_** systems to ensure **_consistency_** across machines and collaborators.

### configuration.nix

`configuration.nix` is the primary NixOS configuration file, defining **_system-wide_** settings and **_global_** configurations, including:
-   System packages.
-   Networking.
-   External modules:

File        |Description
:----------:|:----------
`docker.nix`|**_Docker_** configuration
`ssh.nix`   |**_SSH_** server settings and **_keys_**
`wsl.nix`   |**_WSL-specific_** settings, configured in `/etc/wsl.conf`

### home.nix

`home.nix` utilizes [Home Manager](https://nix-community.github.io/home-manager/) to configure **_user-specific_** settings, such as:
-   User environment settings.
-   User-specific package installations.
-   External modules:

File        |Description
:----------:|:----------
`bash.nix`  |Bash shell **_aliases_**
`git.nix`   |**_Git credentials_** and configurations

### secrets

The `secrets` directory is used for **_secrets management_**, including:

File        |Description
:----------:|:----------
`password`  |**_Hashed password_** for the user
`ssh`       |**_OpenSSH public key_** authorization

These files should have **_restricted permission_** to prevent unauthorized access:

```bash
sudo chmod 600 /etc/nixos/.dotfiles/secrets/password
```

## Prerequisites

1.  **_Windows Subsystem for Linux_** feature enabled:

    ```powershell
    DISM.exe /Online /Enable-Feature /FeatureName:Microsoft-Windows-Subsystem-Linux /All /NoRestart
    ```

2.  Update **_WSL_** to the **_latest version_**:

    ```powershell
    wsl --update
    ```

## Applying Configuration

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/khangvum/nixos-wsl.git /etc/nixos/.dotfiles
    ```

2.  **Update the secret files:**

-   Update [`password`](secrets/password_template) to specify your actual hashed password.
-   Update [`ssh`](secrets/ssh_template) to capture the public SSH key.

3.  **Apply the settings:**

-   System-wide Build:

    ```bash
    sudo nixos-rebuild switch --flake /etc/nixos/.dotfiles
    ```

-   User-specific Build

    ```bash
    home-manager switch --flake /etc/nixos/.dotfiles
    ```

>   [!NOTE]
>   Home Manager must be configured in the environment using the [Standalone installation](https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone) prior to executing the command.