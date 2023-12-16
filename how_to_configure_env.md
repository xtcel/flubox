[Read this in English.](https://github.com/xtcel/flubox/blob/master/how_to_configure_env_en.md)

为加快中国或者其他访问 Flutter pub 默认仓库和 Github 的速度，建议使用镜像站点和镜像。

需要配置的环境变量，如下：

- PUB_HOSTED_URL（Pub包管理器的主机地址镜像站点）

- FLUTTER_STORAGE_BASE_URL （下载Flutter二进制分发包的镜像站点）

- FLUTTER_RELEASES_URL （Flutter 版本信息JSON 镜像站点）

- FVM_GIT_CACHE（FVM工具使用的Git缓存）

## 设置环境变量

将以上四个环境变量设置为如下值：

| 环境变量                     | 值                                                                                              |
| ------------------------ | ---------------------------------------------------------------------------------------------- |
| PUB_HOSTED_URL           | https://pub.flutter-io.cn                                                                      |
| FLUTTER_STORAGE_BASE_URL | https://storage.flutter-io.cn                                                                  |
| FLUTTER_RELEASES_URL     | https://storage.flutter-io.cn/flutter_infra_release/releases/releases_macos/windows/linux.json |
| FVM_GIT_CACHE            | https://gitee.com/mirrors/Flutter.git                                                          |

### 在 macOS 中配置

为了确保每次打开终端都能自动加载这些配置，你可以将上述命令添加到你的shell配置文件中（例如，`~/.bashrc` 或 `~/.zshrc`）。

```shell
echo 'export PUB_HOSTED_URL=https://pub.flutter-io.cn' >> ~/.bashrc
echo 'export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn' >> ~/.bashrc
echo 'export FLUTTER_RELEASES_URL=https://storage.flutter-io.cn/flutter_infra_release/releases/releases_macos.json' >> ~/.bashrc
echo 'export FVM_GIT_CACHE=https://gitee.com/mirrors/Flutter.git' >> ~/.bashrc
source ~/.bashrc # 使配置立即生效
```

### 在 Windows 中配置

```powershell
newPath = $pwd.PATH + "/flutter/bin",$env:PATH -join ";"
[System.Environment]::SetEnvironmentVariable('Path',$newPath,User)
[System.Environment]::SetEnvironmentVariable('PUB_HOSTED_URL','https://pub.flutter-io.cn',User)
[System.Environment]::SetEnvironmentVariable('FLUTTER_STORAGE_BASE_URL','https://storage.flutter-io.cn',User)
[System.Environment]::SetEnvironmentVariable('FLUTTER_RELEASES_URL','https://storage.flutter-io.cn/flutter_infra_release/releases/releases_windows.json',User)
[System.Environment]::SetEnvironmentVariable('FVM_GIT_CACHE','https://gitee.com/mirrors/Flutter.git',User)
```

### 在 Linux 中配置

```shell
cat <<EOT >> ~/.zprofile
export PUB_HOSTED_URL="https://pub.flutter-io.cn"
export FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn"
export FLUTTER_STORAGE_BASE_URL="https://storage.flutter-io.cn/flutter_infra_release/releases/releases_linux.json"
export FLUTTER_STORAGE_BASE_URL="https://gitee.com/mirrors/Flutter.git"
export PATH="$PWD/flutter/bin:$PATH"
EOT
```
