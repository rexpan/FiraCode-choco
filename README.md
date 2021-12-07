# FiraCode

[Chocolatey](chocolatey.org) [package](https://chocolatey.org/packages/FiraCode) for [FiraCode](https://github.com/tonsky/FiraCode).

# Install

```cmd
choco install firacode
```

# Build

```cmd
choco pack
```

# Debug

```cmd
choco install FiraCode -fdvy -s .\FiraCode.6.2.nupkg
choco uninstall FiraCode -fdvy -s .\FiraCode.6.2.nupkg
```

# Publish

```
choco push --source https://push.chocolatey.org/
```
