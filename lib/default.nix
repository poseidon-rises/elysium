{
  lib,
  ...
}:

{
  relativeToRoot = lib.path.append ../.;

  scanPaths =
    path:
    builtins.readDir path
    |> lib.attrsets.filterAttrs (
      name: type:
      (type == "directory") || ((name != "default.nix") && (lib.strings.hasSuffix ".nix" name))
    )
    |> builtins.attrNames
    |> builtins.map (f: "${path}/${f}");

	anyUserEnables = 
		optionPath: config: 
			lib.forEach (builtins.attrValues config.home-manager.users) (user:
				lib.getAttrFromPath optionPath user
			) |> lib.any (x: x);

}
// lib.mergeAttrsList [
  (import ./options.nix { inherit lib; })
  (import ./modules.nix { inherit lib; })
]
