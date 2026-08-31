# NOTICE — 来源与许可状态

本仓库由 xhuozhong 发布，为 Codex Game Studio 的源码整理版。

## 本次使用的材料

- 11 个 `skills/*/SKILL.md` 来自原始离线包，并与发布者本机已安装集合交叉核验，正文逐字节保持不变；逐文件 SHA-256 见 `docs/source-manifest.json`。
- `agents/openai.yaml` 从已有的简化字段调整为 `interface.display_name` / `interface.short_description` 格式。
- README、示例、检查表、安装/卸载/验证脚本与推广文案在本次整理中编写。
- 没有上传私人聊天、个人路径、账号凭据、游戏存档或书籍附件。

## 原始 ZIP 的核验

已取得 `codex-game-studio-2.0.0-offline.zip`，ZIP CRC 检查通过，11 个 Skill 正文与本仓库一致。原包含 31 个文件，没有 LICENSE / NOTICE 文件。

SHA-256：`4c2fbd331da3eed73fb3f6d9c9f83bb9da59d87aaf6448805cca8ed6de17144b`，与原制作会话公布值一致。

本仓库改进了安装脚本、文档和 UI 元数据，不是原包的精确镜像。原版 `diagnose.ps1` 和 `validate_bundle.py` 作为辅助工具保留。

原制作说明称 2.0.0 是独立编写的自包含集合，而非第三方 Skill 的直接打包。本仓库保留这项来源说明，但它不是一次独立版权审计，也不据此推断第三方授权。

## 许可

目前没有为整个集合指定统一开源许可证。公开可见不等于获得 MIT、Apache 或其他开源许可。未被明确许可的权利保留给相应权利人；复制、修改或再分发前，应确认适用授权。本说明不是额外的使用许可。

维护者确认权利与授权范围后，应补齐适当 LICENSE 和必要的第三方声明，再标记正式开源发行版。不要为尚未核实的第三方内容重新授权。

## 名称与关联

Codex、OpenAI、Higgsfield、Three.js 及相关项目名称属于各自权利人。本项目不是这些组织的官方产品，也不暗示其赞助或背书。

同名不代表同源：这里的 `develop-web-game` 不是 OpenAI 官方完整 Skill；这里的 `higgsfield-game-generation` 不附带 Higgsfield 服务、CLI 或资产许可。
