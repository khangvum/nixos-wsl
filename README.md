# NixOS-WSL Configuration

A **_NixOS configuration_** tailored for running within **_Windows Subsystem for Linux_** (**_WSL_**). This setup promotes **_seamless integration_** between **_Windows_** and **_NixOS_** while preserving NixOS's renowned **_declarative configuration_** approach.

## Features

-   Seamless **_Windows interoperability_**, minimizing the overhead of a traditional virtual machine.
-   **_Cross-filesystem_** access between Linux and Windows.
-   **_User-specific_** and **_system-wide_** configuration isolation.
-   Full **_declarative configuration_** using Nix **_flakes_** for reproductivity.

## Filesystem Hierarchy

```
└── home
    └── khangvum
        └── .dotfiles
            ├── secrets
            │   ├── password
            │   └── ssh
            ├── flake.nix
            ├── flake.lock
            ├── configuration.nix
            └── home.nix
```

### flake.nix

`flake.nix` is used in the Nix package manager to define a Nix flake, providing a more **_standardized_** and **_reproducible_** way to manage Nix-based projects. This file specifies: 
-   **Inputs:** External dependencies (_e.g._ `nixpkgs`, `nixos-wsl`).
-   **Outputs:** Configurations, packages, and applications of the flake.

    ```nix
    {
      inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
        nixos-wsl.url = "github:nix-community/nixos-wsl";
      };

      outputs = inputs@{ self, nixpkgs, nixos-wsl, ... }: {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./configuration.nix ];
        };
      };
    }
    ```

As this is currently an experimental feature, to use Nix flakes, add the following to the system configuration (`configuration.nix`):

```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

### flake.lock

`flake.lock` **_locks_** the dependencies of the Nix flake to **_specific versions_**, ensuring **_reproducibility_** and preventing **_unexpected updates_** of the configuration.
-   It is **_auto-generated_** when building or updating the system using flakes.
-   This can be stored in **_version control_** systems to ensure **_consistency_** across machines and collaborators.

### configuration.nix

`configuration.nix` is the primary NixOS configuration file, defining **_system-wide_** settings and **_global_** configurations, such as:
-   System packages.
-   Networking.
-   WSL-specific settings.
-   System services (_e.g._ Docker).

### home.nix

`home.nix` contains **_user-specific_** configurations utilizing [Home Manager](https://nix-community.github.io/home-manager/). For example:
-   User environment settings.
-   User-specific package installations.
-   Personal aliases.

### secrets

The `secrets` directory is used for **_secrets management_**, including:

File        |Description
:----------:|:----------
`password`  |Contains the **_hashed password_** for the user
`ssh`       |Holds the **_OpenSSH public key_** authorization

These files should have **_restricted permission_** to prevent unauthorized access:

```bash
sudo chmod 600 ~/.dotfiles/secrets/password
```

## Applying Configuration

### System-wide Build

```bash
sudo nixos-rebuild switch --flake ~/.dotfiles
```

### User-specific Build

```bash
home-manager switch --flake ~/.dotfiles
```