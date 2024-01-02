# {
#   description = "Flake to set up python environment with conda";

#   inputs = {
#       nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
#   };

#   outputs = { self, nixpkgs, ... }:
#   let
#     system = "x86_64-linux";
#     pkgs = import nixpkgs {
#       inherit system;
#     };
#   in {
#     devShells.x86_64-linux.default = pkgs.stdenv.mkDerivation {
#       name = "my-shell-environment";
#       buildInputs = [ pkgs.conda ];
#       shellHook = ''
#         set -e
#         if [ ! -f ~/.conda/etc/profile.d/conda.sh ]; then
#             mkdir -p ~/.conda/etc/profile.d/
#             touch ~/.conda/etc/profile.d/conda.sh
#             # "conda-shell" uses this on every shell. "conda-install" will overwrite this same file with the conda
#             # configuration. So "conda-install" will only be wrant if this file does not exist.
#             echo "conda-install -u" >> ~/.conda/etc/profile.d/conda.sh
#         fi
#         echo Entering conda shell...
#         conda-shell
#         echo Leaving conda shell...
#         set +e
#       '';
#     };
#   };
# }

# {
#   description = "Flake to set up python environment with conda";

#   inputs = {
#       nixpkgs.url = "github:mcmah309/nixpkgs/master";
#   };

#   outputs = { self, nixpkgs, ... }:
#   let
#     system = "x86_64-linux";
#     pkgs = import nixpkgs {
#       inherit system;
#     };
#   in {
#     devShells.x86_64-linux.default = pkgs.stdenv.mkDerivation {
#       name = "my-shell-environment";
#       buildInputs = [ pkgs.conda ];
#       shellHook = ''
#         set -e
#         echo Entering conda shell...
#         conda-shell
#         echo Leaving conda shell...
#         set +e
#       '';
#     };
#   };
# }

{
  description = "Flake to set up python environment with conda";

  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    devShells.x86_64-linux.default = pkgs.stdenv.mkDerivation {
      name = "my-shell-environment";
      buildInputs = [ pkgs.conda ];
      shellHook = ''
        set -e
        conda_config_file="$HOME/.conda/etc/profile.d/conda.sh"
        if [ ! -f "$conda_config_file" ]; then
            echo "HELLO"
            mkdir -p "$(dirname "$conda_config_file")"
            # `conda-shell` uses `conda.sh` ever run. `conda-install` will overwrite this same file with the conda
            # configuration. So `conda-install` will only be ran if this file does not exist.
            echo "conda-install -u" > "$conda_config_file"
        fi
        echo Entering conda shell...
        conda-shell
        echo Leaving conda shell...
        set +e
      '';
    };
  };
}

# conda create -n myenv python=3.x
# conda activate myenv
# conda install --file requirements.txt or conda env update --file environment.yml
# pip install -r requirements.txt