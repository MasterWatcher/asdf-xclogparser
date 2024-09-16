<div align="center">

# asdf-xclogparser [![Build](https://github.com/MasterWatcher/asdf-xclogparser/actions/workflows/build.yml/badge.svg)](https://github.com/MasterWatcher/asdf-xclogparser/actions/workflows/build.yml) [![Lint](https://github.com/MasterWatcher/asdf-xclogparser/actions/workflows/lint.yml/badge.svg)](https://github.com/MasterWatcher/asdf-xclogparser/actions/workflows/lint.yml)

[xclogparser](https://github.com/MasterWatcher/xclogparser) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add xclogparser
# or
asdf plugin add xclogparser https://github.com/MasterWatcher/asdf-xclogparser.git
```

xclogparser:

```shell
# Show all installable versions
asdf list-all xclogparser

# Install specific version
asdf install xclogparser latest

# Set a version globally (on your ~/.tool-versions file)
asdf global xclogparser latest

# Now xclogparser commands are available
--help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/MasterWatcher/asdf-xclogparser/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Anton Goncharov](https://github.com/MasterWatcher/)
