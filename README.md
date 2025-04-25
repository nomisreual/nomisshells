# Shell Templates

A local flake can be created like this:

```bash
nix flake init --template github:nomisreual/nomisshells#<name>
```

Note: `<name>` refers to the name of the template.

When put into a development shell with `nix develop`, `$SHELL` points to a non-interactive *bash* binary. As a workaround, set `$SHELL` to an interactive *bash* binary (on nixpkgs unstable, the default shell points to the interactive *bash* binary).

```nix
    shellHook = ''
      # set SHELL to current system shell, which points to
      # an interactive shell (on unstable)
      export SHELL=/run/current-system/sw/bin/bash
    '';
```


## A note on Python

Overriding python packages can be achieved like this:

Instead of

```nix
python = pkgs.python311;
```

you can do something like:

```nix
python = pkgs.python311.override {
  packageOverrides = final: prev: {
    django = prev.django_5;
    django-extensions = prev.django-extensions.overridePythonAttrs (old: rec {
      doCheck = false;
    });
  };
};
```

However, overriding packages can break other packages. Here, checks for `django-extensions` is disabled, as pointing `django` to `django_5` makes them fail.
