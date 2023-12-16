[阅读中文版](https://github.com/THUDM/ChatGLM3/blob/main/README.md)

To speed up the access to the default Flutter pub repository and Github in China or other regions, it is recommended to use mirror sites and mirrors.

The environment variables that need to be configured are as follows:

- PUB_HOSTED_URL (Mirror site for the host address of the Pub package manager)

- FLUTTER_STORAGE_BASE_URL (Mirror site for downloading Flutter binary distribution packages)

- FLUTTER_RELEASES_URL (Mirror site for Flutter version information JSON)

- FVM_GIT_CACHE (Git cache used by the FVM tool)

## Setting Environment Variables

Set the above four environment variables to the following values:

| PUB_HOSTED_URL           | https://pub.flutter-io.cn                                                                      |
| ------------------------ | ---------------------------------------------------------------------------------------------- |
| FLUTTER_STORAGE_BASE_URL | https://storage.flutter-io.cn                                                                  |
| FLUTTER_RELEASES_URL     | https://storage.flutter-io.cn/flutter_infra_release/releases/releases_macos/windows/linux.json |
| FVM_GIT_CACHE            | https://gitee.com/mirrors/Flutter.git                                                          |

### Configuration on macOS

To ensure that these configurations are automatically loaded every time you open the terminal, you can add the above commands to your shell configuration file (for example, `~/.bashrc` or `~/.zshrc`).

```shell
echo 'export PUB_HOSTED_URL=https://pub.flutter-io.cn' >> ~/.bashrc
echo 'export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn' >> ~/.bashrc
echo 'export FLUTTER_RELEASES_URL=https://storage.flutter-io.cn/flutter_infra_release/releases/releases_macos.json' >> ~/.bashrc
echo 'export FVM_GIT_CACHE=https://gitee.com/mirrors/Flutter.git' >> ~/.bashrc
source ~/.bashrc # Make the configuration take effect immediately
```

### Configuring on Windows

```powershell
newPath = $pwd.PATH + "/flutter/bin",$env:PATH -join ";"
[System.Environment]::SetEnvironmentVariable('Path',$newPath,User)
[System.Environment]::SetEnvironmentVariable('PUB_HOSTED_URL','https://pub.flutter-io.cn',User)
[System.Environment]::SetEnvironmentVariable('FLUTTER_STORAGE_BASE_URL','https://storage.flutter-io.cn',User)
[System.Environment]::SetEnvironmentVariable('FLUTTER_RELEASES_URL','https://storage.flutter-io.cn/flutter_infra_release/releases/releases_windows.json',User)
[System.Environment]::SetEnvironmentVariable('FVM_GIT_CACHE','https://gitee.com/mirrors/Flutter.git',User)
```

### Configuring on Linux

```shell
cat <<EOT >> ~/.zprofile
export PUB_HOSTED_URL="https://pub.flutter-io.cn"
export FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
export FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn/flutter_infra_release/releases/releases_linux.json"
export FLUTTER_STORAGE_BASE_URL="https://gitee.com/mirrors/Flutter.git"
export PATH="$PWD/flutter/bin:$PATH"
EOT
```