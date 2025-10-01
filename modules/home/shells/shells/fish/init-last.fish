# Allows quick creation of nix shells. For example, 'nsp hello cowsay' will
# create shell with the hello package and the cowsay package
function nsp
    set -l transformed
    for pkg in $argv
        set transformed $transformed "nixpkgs#$pkg"
    end
    nix shell $transformed --command fish
end
