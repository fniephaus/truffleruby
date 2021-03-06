# The list is from tool/generate-native-config.rb
errnos = %w[
  EPERM ENOENT ESRCH EINTR EIO ENXIO E2BIG ENOEXEC EBADF ECHILD EDEADLK ENOMEM
  EACCES EFAULT ENOTBLK EBUSY EEXIST EXDEV ENODEV ENOTDIR EISDIR EINVAL ENFILE
  EMFILE ENOTTY ETXTBSY EFBIG ENOSPC ESPIPE EROFS EMLINK EPIPE EDOM ERANGE
  EWOULDBLOCK EAGAIN EINPROGRESS EALREADY ENOTSOCK EDESTADDRREQ EMSGSIZE
  EPROTOTYPE ENOPROTOOPT EPROTONOSUPPORT ESOCKTNOSUPPORT EOPNOTSUPP
  EPFNOSUPPORT EAFNOSUPPORT EADDRINUSE EADDRNOTAVAIL ENETDOWN ENETUNREACH
  ENETRESET ECONNABORTED ECONNRESET ENOBUFS EISCONN ENOTCONN ESHUTDOWN
  ETOOMANYREFS ETIMEDOUT ECONNREFUSED ELOOP ENAMETOOLONG EHOSTDOWN
  EHOSTUNREACH ENOTEMPTY EUSERS EDQUOT ESTALE EREMOTE ENOLCK ENOSYS EOVERFLOW
  EIDRM ENOMSG EILSEQ EBADMSG EMULTIHOP ENODATA ENOLINK ENOSR ENOSTR EPROTO
  ETIME
]

c = <<-EOC
#include <errno.h>
#include <string.h>
#include <stdio.h>

int main() {
#{errnos.map do |errno|
%[  printf("#{errno} = %s\\n", strerror(#{errno}));]
  end.join("\n")}
  return 0;
}
EOC

file = 'strerror.c'
File.write file, c
system 'gcc', file
out = `./a.out`
out.lines.map do |line|
  errno, description = line.chomp.split(' = ')
  puts %[map.put(#{errno.inspect}, #{description.inspect});]
end
