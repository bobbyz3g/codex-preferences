# Codex 全局指令同步

以本仓库的 `AGENTS.md` 为唯一维护版本。两台电脑分别拉取仓库，再运行安装脚本。项目专属规则仍放在项目自己的 `AGENTS.md` 中。

## 文件

- `AGENTS.md`：从现有全局指令直接复制的共享版本。
- `install.ps1`：兼容 Windows PowerShell 5.1 及 PowerShell 7。
- `.gitattributes`：统一版本库中的文本换行规则。

## 安装到当前电脑

在仓库目录打开 PowerShell：

```powershell
.\install.ps1 -WhatIf
.\install.ps1
```

脚本优先使用环境变量 `CODEX_HOME`，未设置时使用 `$env:USERPROFILE\.codex`。也可显式指定目录：

```powershell
.\install.ps1 -DestinationDirectory 'C:\path\to\codex-home'
```

目标文件相同时不做修改。覆盖不同内容前，脚本将旧文件保存到目标目录内的 `agents-backups` 文件夹，每次备份使用唯一文件名；复制后校验 SHA-256。脚本拒绝覆盖目录或符号链接，不会修改其他配置。

如果执行策略阻止脚本，请遵循电脑的脚本执行策略；在允许的个人电脑上，可审阅脚本后仅对这一次进程使用：

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\install.ps1
```

安装后启动新的 Codex 会话，要求其列出加载的指令来源。

注意：同一全局目录中的 `AGENTS.override.md` 会优先于 `AGENTS.md`，两者不会追加合并。脚本检测到它时会警告，但不会删除或修改它。官方说明：https://learn.chatgpt.com/docs/agent-configuration/agents-md

## 在另一台电脑上使用

使用有权访问私有仓库的 GitHub 账号克隆：

```powershell
git clone https://github.com/bobbyz3g/codex-preferences.git
Set-Location codex-preferences
.\install.ps1 -WhatIf
.\install.ps1
```

仓库地址：https://github.com/bobbyz3g/codex-preferences

## 日常更新

1. 修改前执行 `git pull --ff-only`。
2. 只编辑仓库里的 `AGENTS.md`，不要直接编辑已安装的副本。
3. 运行 `install.ps1`，然后提交并推送变更。
4. 在另一台电脑执行 `git pull --ff-only`，成功后运行 `install.ps1`。

出现分叉时先处理 Git 冲突，不要强制推送。不要同步整个 `.codex` 目录。备份留在本机目标目录，不进入本仓库。

如需恢复旧版本，将所需备份复制回目标 `AGENTS.md`；若要让回退在两台电脑持续生效，也应在仓库中恢复对应内容并提交。
