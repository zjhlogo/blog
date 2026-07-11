# 快速开始

建议全局安装 `docsify-cli`，它可以帮助您在本地初始化和预览网站。

```bash
npm i docsify-cli -g
```

## 初始化

如果您想在 `./docs` 子目录中编写文档，可以使用 `init` 命令。

```bash
docsify init ./docs
```

## 编写内容

初始化完成后，您可以在 `./docs` 子目录中看到文件列表。

* `index.html` 作为入口文件
* `README.md` 作为首页
* `.nojekyll` 防止 GitHub Pages 忽略以 `_` 开头的文件

您可以轻松地在 `./docs/README.md` 中更新文档，当然也可以[添加更多页面](more-pages.md)。

## 预览您的站点

使用 `docsify serve` 启动本地服务器。您可以在浏览器中通过 `http://localhost:3000` 预览您的站点。

```bash
docsify serve docs
```