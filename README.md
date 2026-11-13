# 数据库论文双语阅读器

在本地浏览数据库论文。左侧同时显示论文列表和本文目录，右侧连续滚动，每段英文下方显示对应的中文。点击目录可跳转章节，展开「原页截图」可查看图表和公式。支持导入本地 PDF。

## 安装与启动

需要 macOS、Python 3、Swift 命令行开发工具和 Codex CLI。如果尚未安装 Swift 命令行开发工具，可以运行 `xcode-select --install`。

在终端进入项目目录，完成下方的 Codex 登录后运行：

```bash
python3 reader.py
```

也可以双击「启动阅读器.command」。阅读器会打开本地浏览器页面。关闭终端窗口即可停止。

## 配置 AI 翻译

阅读器通过本机的 Codex CLI 翻译。每位使用者用自己的账户登录，任选以下一种方式。

### 使用 ChatGPT 账户

在终端运行 `codex login`，按浏览器提示登录，然后运行 `codex login status` 检查状态。

### 使用 OpenAI API 密钥

用自己的 API 账户创建密钥。在 Bash 中运行以下命令，按提示输入。输入不会显示在屏幕上，也无需把实际密钥写进命令或项目文件。

```bash
read -r -s -p "OpenAI API key: " paper_reader_key
printf '\n'
printf '%s\n' "$paper_reader_key" | codex login --with-api-key
unset paper_reader_key
codex login status
```

API 登录使用该 API 账户的额度。登录凭据由 Codex CLI 在本机管理。启动阅读器前，请确保终端可以运行 `codex`。macOS 桌面版附带的 CLI 也可由阅读器自动查找。

## 数据与隐私

PDF、原页截图所用的原文和已完成的译文保存在本机项目的 `.cache/`。自动翻译处理进入阅读区的页面。「全文翻译」只处理缺失的译文。重启后可继续使用已保存的内容。

翻译时，当前页提取的文字会发送给 Codex 服务。请仅翻译允许提交给该服务的文档。

提交代码时，仅添加源码、启动脚本和项目文档。排除密钥、Token、登录文件、环境配置、私人资料、PDF 和译文缓存。使用 GitHub 提交时，若要隐藏个人邮箱，请在 GitHub 邮箱设置中启用邮箱隐私，并将本仓库的 `user.email` 设置为 GitHub 提供的 noreply 地址。

## 常见问题

- PDF 无法下载时，可手动下载并导入。扫描版需要先做 OCR。
- 复杂双栏排版的识别顺序可能与原版不同，可通过「打开 PDF」核对。
- 翻译失败时，先用 `codex login status` 检查登录，再检查网络和账户额度。
