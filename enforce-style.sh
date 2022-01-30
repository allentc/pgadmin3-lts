#!/bin/sh

# Perform astyle cleanup per rules:
# * -p - insert space around parenthesis
# * --style=allman - bracket style
# * -S - indent switches
# * -t4 - intent with tabs, 4 of them
# * -k3 - align pointer or reference operators
# * -z2 - Unix style line endings
# Also add the -n to make it not save .orig files (we have git for that)

astyle -n -p --style=allman -S -t4 -k3 -z2 `find . -name "*.cpp" -o -name "*.h" | egrep -v "(wx-build|xrcDialogs)"`
