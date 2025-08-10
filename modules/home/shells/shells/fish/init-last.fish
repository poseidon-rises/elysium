# Allows quick creation of nix shells. For example, 'ns hello cowsay' will
# create shell with the hello package and the cowsay package
function ns
    set -l transformed
    for pkg in $argv
        set transformed $transformed "nixpkgs#$pkg"
    end
    nix shell $transformed
end

