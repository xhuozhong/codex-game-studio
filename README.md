# Codex Game Studio 🎮

**把一个游戏开发团队拆成 10 个专家 + 1 个总导演。**

面向浏览器游戏的 Codex Skill 集合：用一个入口安排游戏设计、引擎、玩法、UI/UX、手感、素材、多人联机与试玩回归，让每次开发都有明确的职责和验收路径。

```text
$game-studio-director

接管当前游戏项目，先检查现有架构与运行方式。
完成下一项最重要的玩家可见功能，实际试玩、检查截图与状态，
修复问题后重新回归，并报告真实结果。
```

> **当前版本：2.0.0-source.1（源码整理版）。** 已取得并核验原始 `codex-game-studio-2.0.0-offline.zip`；11 个 Skill 正文与原包逐字节一致。仓库改进了安装/备份/卸载脚本、UI 元数据与文档，因此整仓不等同于原 ZIP。来源与许可状态见 [NOTICE](NOTICE.md)。

## 团队：1 个总导演 + 10 个专家

| Skill | 岗位 | 负责什么 |
| --- | --- | --- |
| [game-studio-director](skills/game-studio-director/SKILL.md) | 总导演 / 技术负责人 | 读项目、拆任务、安排专家、控制范围、整合验收 |
| [higgsfield-game-generation](skills/higgsfield-game-generation/SKILL.md) | 游戏生成与素材 | 原型、Sprite、纹理、3D、音乐和音效；先检查可用生成工具 |
| [game-engine](skills/game-engine/SKILL.md) | 引擎工程 | 游戏循环、场景、实体、输入、物理、碰撞、渲染与性能 |
| [multiplayer-game](skills/multiplayer-game/SKILL.md) | 多人联机 | 匹配、房间、服务器权威状态、同步、Tick、连接与重连 |
| [game-developer](skills/game-developer/SKILL.md) | 玩法程序 | 玩法系统、状态机、AI、数据、存档、功能集成 |
| [game-ui-design](skills/game-ui-design/SKILL.md) | UI 视觉 | HUD、菜单、按钮、背包、图标、字体和视觉一致性 |
| [game-design-theory](skills/game-design-theory/SKILL.md) | 游戏策划 | 核心循环、关卡、成长、奖励、难度与玩家动机 |
| [game-feel](skills/game-feel/SKILL.md) | 手感 | 输入响应、动画节奏、粒子、停顿、镜头与音效反馈 |
| [game-ui-ux](skills/game-ui-ux/SKILL.md) | 交互与适配 | 响应式、安全区域、键鼠/手柄/触控导航、无障碍 |
| [threejs-game-ui-designer](skills/threejs-game-ui-designer/SKILL.md) | Three.js 界面 | 3D 游戏 HUD、Overlay、菜单、触控与场景同步 |
| [develop-web-game](skills/develop-web-game/SKILL.md) | 浏览器 QA | 实际运行、自动试玩、截图、状态与 Console 检查、修复和回归 |

每个功能指定 **1 个主负责人 + 最多 3 个辅助专家**。总导演按需采用专家指令，不要求用户逐个点名。这是工作职责组织方式，不是自动启动 11 个独立代理的程序，也不提供并行代理运行器。

## Windows 安装

1. 在仓库点击 **Code → Download ZIP**，下载后完整解压。
2. 首次安装双击 `INSTALL_WINDOWS.cmd`。
3. 如提示同名 Skill 已存在，确认需要更新后双击 `REPAIR_WINDOWS.cmd`。
4. Codex 未显示新 Skill 时，完全退出并重新打开。

默认安装位置：

```text
%USERPROFILE%\.agents\skills\
```

安装只复制本仓库内的 11 个 Skill：**安装阶段无需联网、Git、GitHub CLI 或 GitHub 授权**。这不意味着 Codex 推理、首次下载、游戏依赖安装或外部素材服务可以离线运行。

安装器兼容 Windows PowerShell 5.1 / PowerShell 7。启动器仅对本次脚本进程使用 `-ExecutionPolicy Bypass`，不会修改系统执行策略；受组织策略管理的设备应遵守管理员要求。

也可以在仓库目录使用 PowerShell：

```powershell
# 先检查包的完整性，不写入 Skill 目录
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\validate.ps1

# 用户级安装
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\install.ps1 -Scope User

# 仅安装到某个现有游戏项目
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\install.ps1 -Scope Project -ProjectRoot "D:\Games\MyGame"

# 更新：先备份旧目录，再复制新版
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\install.ps1 -Scope User -Force
```

### 备份与卸载

- 默认遇到同名 Skill 会停止，且在复制前检查全部冲突。
- `REPAIR_WINDOWS.cmd` 等同于 `-Force` 更新；旧文件移至 `.agents/skill-backups/codex-game-studio/<时间与随机编号>/`。
- 备份放在 `skills/` 扫描目录之外，避免旧版也被识别成同名 Skill。
- `UNINSTALL_WINDOWS.cmd` 仅移走带本安装器标记的 11 个 Skill，不永久删除；其他 Skill 保持不变。
- 本版之前安装的、没有标记的目录不会被卸载器擅自移走。先检查内容，必要时用本版修复安装再卸载。
- 手动恢复时先将当前同名目录移出 `skills/`，再把指定备份内的 Skill 文件夹放回原位置。不要同时保留两个可扫描副本。
- 若安装中断，保留备份目录；安装器会尝试回滚，并输出未恢复内容的位置。

macOS / Linux 可手动将 `skills/` 下的 11 个目录复制到 `~/.agents/skills/`。本版未提供或验证这些平台的自动安装脚本。

## 在 Codex 中调用

在 **Codex CLI / IDE 扩展**中输入 `/skills` 查看，或用 `$game-studio-director` 显式调用。桌面产品也可通过 Skills 列表选择，具体入口随客户端而异。官方说明：[Build skills](https://learn.chatgpt.com/docs/build-skills)。

在实际游戏项目内开始任务，使用本 README 顶部的提示词即可。只处理某一领域时，也可直接调用 `$game-feel`、`$game-ui-ux` 或 `$develop-web-game`。

更多可复制提示词：[示例调用](examples/prompts.md)。

## 典型工作流

```text
检查项目与真实启动命令
  → 游戏设计：明确玩家目标、输入、奖励和失败情况
  → 引擎 / 玩法实现：完成一个可玩的最小切片
  → UI/UX + 手感 + 必要素材
  → 多人联机（仅在明确要求时启用）
  → 实际运行 → 自动试玩 → 截图 / 状态 / Console 检查
  → 修复 → 回归 → 更新项目进度
  → 部署准备 → 获得授权后部署 → 线上验收
```

部署检查表见 [examples/release-checklist.md](examples/release-checklist.md)。该表补充发布流程，不代表包内自带托管服务或一键部署器。

验收关注玩家旅程，例如：新游戏 → 移动 → NPC 互动 → 收获 → 背包变化 → 保存退出 → 刷新 → 继续游戏。测试必须报告真实执行结果；工具不可用时明确说明阻断，不能把静态阅读当成试玩通过。

## 适用场景

- 独立开发者、Game Jam、浏览器小游戏原型。
- 像素经营、剧情冒险、动作游戏等逐步迭代。
- 已有 Canvas、Three.js 或其他网页游戏的功能开发与修复。
- UI 统一、手机触控适配、手感改善和存档回归。
- 明确需要时，设计和实现合作模式、房间与实时同步。

## 能力边界

- Skill 是可复用指令，不附带游戏引擎、浏览器、自动化脚本、Playwright、Higgsfield 账号或 API 密钥。
- 本版 `develop-web-game` 是本集合的 QA 指令，**不是 OpenAI 官方同名 Skill 的完整副本**，不附带官方浏览器测试脚本。
- `higgsfield-game-generation` 保留角色名称，不代表官方集成或服务可用；没有生成工具时使用现有资产或占位素材。
- 多人服务器、云存档、账号、付费服务与公开部署都需要实际环境及相应授权。
- 不保证自动产出可商业发行的完整游戏；性能、可玩性、安全、内容权利仍需逐项验收。
- 安装器验证的是文件结构与格式，不是对 Skill 行为质量的证明。

## 仓库结构

```text
skills/                     # 11 个 Skill，各含 SKILL.md 和 UI 元数据
scripts/                    # 本地检查、安装、备份与卸载
examples/                   # 调用提示词、发布检查表
docs/                       # 来源清单、验证记录、推广文案
INSTALL_WINDOWS.cmd
REPAIR_WINDOWS.cmd
UNINSTALL_WINDOWS.cmd
NOTICE.md                   # 来源、商标与许可状态
VERSION
```

## 发布与许可状态

本仓库提供可阅读、可下载的源码整理版。原 ZIP 已通过完整性与 SHA-256 核验，原包没有 LICENSE / NOTICE 文件。推荐从 **Code → Download ZIP** 下载当前源码版，以使用改进后的安装器；若 Releases 提供原始 ZIP，它仅作为原版存档。原版卸载器会直接删除同名 Skill，原版备份留在扫描目录内；本仓库已分别改为带标记检查的备份卸载、扫描目录外备份。

当前未授予覆盖所有文件的统一开源许可证，不能将“公开仓库”等同于 MIT / Apache 授权。详见 [NOTICE](NOTICE.md)；待来源与权利确认后再补充适当 LICENSE。

欢迎通过 Issue 反馈复现步骤、预期结果、实际结果和环境信息；请勿提交密钥、个人存档、私人聊天或无权分发的素材。
