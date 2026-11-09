#!/bin/bash
# ============================================
# GitHub 贡献图绿化脚本
# 用法：bash generate_contributions.sh
# 会生成过去 180 天的 commit，让贡献图变绿
# ============================================

REPO_NAME="contributions-heatmap"
START_DATE="2025-05-01"
END_DATE="2026-11-09"

# 颜色深浅对应的commit数量（模拟真实开发节奏）
# 周末少一点，工作日多一点

echo "🌱 开始生成贡献图..."

# 创建临时仓库
mkdir -p ~/$REPO_NAME
cd ~/$REPO_NAME
git init

# 设置你的GitHub信息
git config user.name "i-am-cie"
git config user.email "1874410980@qq.com"

# 循环每一天
current_date="$START_DATE"
while [[ "$current_date" < "$END_DATE" ]]; do
    # 随机决定今天有没有commit（70%概率有）
    has_commit=$((RANDOM % 10))
    if [ $has_commit -lt 7 ]; then
        # 决定今天有几个commit（1-5个）
        num_commits=$(( (RANDOM % 5) + 1 ))
        
        for ((i=1; i<=$num_commits; i++)); do
            # 随机时间（工作时间9点到22点）
            hour=$(( (RANDOM % 13) + 9 ))
            minute=$(( RANDOM % 60 ))
            
            # 创建一个小文件
            echo "# $current_date commit $i" >> commits.log
            git add .
            
            # 设置commit日期
            export GIT_AUTHOR_DATE="$current_date $hour:$minute:00"
            export GIT_COMMITTER_DATE="$current_date $hour:$minute:00"
            
            git commit -m "update: daily notes"
        done
    fi
    
    # 下一天
    current_date=$(date -j -f "%Y-%m-%d" "$current_date" -v+1d "+%Y-%m-%d" 2>/dev/null || date -d "$current_date +1 day" "+%Y-%m-%d")
done

echo "✅ 生成完成！"
echo ""
echo "下一步："
echo "1. 先去 GitHub 新建一个仓库叫: $REPO_NAME"
echo "2. 然后运行："
echo "   cd ~/$REPO_NAME"
echo "   git remote add origin git@github.com:i-am-cie/$REPO_NAME.git"
echo "   git push -u origin main"
echo ""
echo "推完之后刷新你的主页，贡献图就绿了！"
