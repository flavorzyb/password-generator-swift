# password-generator-swift

用于生成随机的密码，防止暴力破解-mac OS版

## 开发环境

- **Xcode** >= 10.1
- **macOS** >= 10.14.2
- **swift** >= 4.2.0
- **carthage** >= 0.31.2

### 开发工具

项目以xcode为开发IDE。请下载最新版本的xcode。
当前的最新版本为10.1 (10B61)

xcode苹果官方下载地址: [https://developer.apple.com/xcode/](https://developer.apple.com/xcode/)

### 库管理

项目的库采用的是Carthage为第三方库管理工具

- 安装及使用
```bash
$ brew update
$ brew install carthage
```

- 更新carthage
```bash
$ brew upgrade carthage
```

- 编译第三方库

  进入工程项目目录之后，运行下列命令即可:
```bash
$ carthage update --platform macOS
```
