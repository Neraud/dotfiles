#!/usr/bin/env zsh

echo "Generating ZSH completion caches."
mkdir -p ${ZSH_USER_FUNCTIONS_DIR}

echo ""
echo "Common completions:"
for f (${ZSH_CONFIG_DIR}/scripts/completion-cache-generator.d/*.zsh(N)) ; do
    echo "- $(basename $f)"
    zsh $f
done

echo ""
echo "Local completions:"
for f (${ZSH_LOCAL_CONFIG_DIR}/scripts/completion-cache-generator.d/*.zsh(N)) ; do
    echo "- $(basename $f)"
    zsh $f
done
