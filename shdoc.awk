#!/usr/bin/env gawk -f

BEGIN { verbatim = 0 }

/^#!/ { next }

/^\s*$/ { print; next }

!/^\s*#/ {
    if (!verbatim) {
        print "```{ .numberLines startFrom='" NR "'}"
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
