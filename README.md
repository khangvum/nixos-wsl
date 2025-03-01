# NixOS-WSL Configuration

A **_NixOS configuration_** tailored for running within **_Windows Subsystem for Linux_** (**_WSL_**). This setup promotes **_seamless integration_** between **_Windows_** and **_NixOS_** while preserving NixOS's renowned **_declarative configuration_** approach.

## Features

-   Seamless **_Windows interoperability_**, minimizing the overhead of a traditional virtual machine.
-   **_Cross-filesystem_** access between Linux and Windows.
-   **_User-specific_** and **_system-wide_** configuration isolation.
-   Full **_declarative configuration_** using Nix **_flakes_** for reproductivity.

## Filesystem Hierarchy

```
├── etc
│   └── nixos
│       └── secrets
│           └── password
└── home
    └── khangvum
        └── .dotfiles
            ├── flake.nix
            ├── flake.lock
            ├── configuration.nix
            └── home.nix
```

### password

`password` is used for secure secrets management, such as handling user password.

1.  Create secrets management directory:

    ```bash
    sudo mkdir -p /etc/nixos/secrets
    ```

2.  Generate and add the hashed password to the file:
-   For example, generate a SHA-512 hashed password using `mkpasswd`:

    ```bash
    mkpasswd -m sha-512
    ```

-   Add the hashed password to the file (Replace `<HASHED_PASSWORD>` with the generated hashed password above):

    ```bash
    echo <HASHED_PASSWORD> | sudo tee /etc/nixos/secrets/password > /dev/null
    ```

3.  Set restricted permission:

    ```bash
    sudo chmod 600 /etc/nixos/secrets/password
    ```

### flake.nix

`flake.nix` is used in the Nix package manager to define a Nix flake, providing a more standardized and reproducible way to manage Nix-based projects. 
-   This file specifies the inputs (dependencies) and outputs (packages and configurations) of the flake.

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

-   As this is currently an experimental feature, to use Nix flakes, add the following to the system configuration (`configuration.nix`):

    ```nix
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

### flake.lock

`flake.lock` locks the dependencies of the Nix flake to specific versions, ensuring reproducibility and preventing unexpected updates of the configuration.

### configuration.nix

`configuration.nix` is the primary NixOS configuration file, defining system-wide settings and global configurations.

### home.nix

`home.nix` contains user-specific configurations, such as user environment settings and personal package installations.