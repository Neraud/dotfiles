# Make sure ~/.local/bin is in path
if [ $path[(Ie)$HOME/.local/bin] -eq 0 ]; then
  path=("$HOME/.local/bin" $path)
fi
