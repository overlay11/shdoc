#!/usr/bin/env gawk -f

BEGIN { verbatim = 0 }

NR == 1 && /^#!/ {
    shebang_line = $0; next
}

/^\s*$/ { print; next }

!/^\s*#/ {
    if (shebang_line) {
        print "```{.numberLines startFrom='1'}\n" shebang_line "\n```"
        shebang_line = ""
    }
    if (!verbatim) {
        print "```{.numberLines startFrom='" NR "'}"
        verbatim = 1
    }
    print
}

/^\s*#/ {
    if (verbatim) {
        print "```\n"
        verbatim = 0
    }
    sub(/^\s*#\s?/, "")
    print
}

END {
    if (verbatim) { print "```" }
}
