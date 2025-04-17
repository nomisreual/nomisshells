# Shell Templates

A local flake can be created like this:

```bash
nix flake init --template github:nomisreual/nomisshells#<name>
```

Note: `<name>` refers to the name of the template.


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
