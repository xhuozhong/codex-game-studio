from pathlib import Path
import re
root=Path(__file__).resolve().parents[1]
expected={'game-studio-director','higgsfield-game-generation','game-engine','multiplayer-game','game-developer','game-ui-design','game-design-theory','game-feel','game-ui-ux','threejs-game-ui-designer','develop-web-game'}
found={p.name for p in (root/'skills').iterdir() if p.is_dir()}
assert found==expected, f'Expected {expected}, found {found}'
for name in sorted(expected):
    p=root/'skills'/name/'SKILL.md'
    t=p.read_text(encoding='utf-8')
    assert t.startswith('---\n'), name+' frontmatter'
    m=re.search(r'^name:\s*([a-z0-9-]+)\s*$',t,re.M)
    assert m and m.group(1)==name, name+' name'
    assert re.search(r'^description:\s*.+$',t,re.M), name+' description'
print(f'PASS: {len(expected)} skills validated')
