# because vscode doesnt src this by default
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

if [ "$TERM_PROGRAM" == "vscode" ]; then
    echo "not changing to git dir because vscode"
else
    gitcd
fi
