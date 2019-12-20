### Functional wrappers for `sched_*` syscalls on musl libc

musl libc intentionally implements several `sched_*` functions as no-op that
returns `ENOTSUPP` due to the fact that Linux versions of those syscalls [don't
comply with their POSIX counterparts][0].

This library brings back those functions as many "broken" software written for
Linux requires them to function (such as `schedtool`, `rtkit`), and you don't
feel like patching in these syscall wrappers yourself.

#### Dependencies

- Nim >= 1.0.0

#### How to use

```
$ nim build
$ clang -llinux_sched -L. program.c
# Alternatively, the library can also be LD_PRELOAD-ed
$ env LD_PRELOAD=$PWD/liblinux_sched.so.0 your-program-here
```

#### Installation

```
$ nim build
$ nim install
```

##### For packagers

The installation folder can be customized via these flags:
- `-d:prefix:/path/to/prefix`: Set the installation prefix (default: `/usr`).
- `-d:libdir:/path/to/lib`: Set the installation folder (default: `/usr/lib`).
  If `libdir` is not an absolute path, it will be assumed to be relative
  to prefix.

[0]: https://git.musl-libc.org/cgit/musl/commit/?id=1e21e78bf7a5c24c217446d8760be7b7188711c2
