# This is free and unencumbered software released into the public domain.
#
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.
#
# Refer to "unlicense.txt", included in this distribution, for more
# information.

import syscall, posix

{.pragma: lib, exportc, codegenDecl: """extern __attribute__((visibility("default"))) $# $#$#""".}

type
  SchedParam = object

proc sched_getparam(pid: Pid; param: ptr SchedParam): cint {.lib.} =
  result = cint syscall(SchedGetParam, pid, param)
  if result < 0:
    errno = -result
    result = -1

proc sched_getscheduler(pid: Pid): cint {.lib.} =
  result = cint syscall(SchedGetScheduler, pid)
  if result < 0:
    errno = -result
    result = -1

proc sched_setparam(pid: Pid, param: ptr SchedParam): cint {.lib.} =
  result = cint syscall(SchedSetParam, pid, param)
  if result < 0:
    errno = -result
    result = -1

proc sched_setscheduler(pid: Pid, policy: cint, param: ptr SchedParam): cint {.lib.} =
  result = cint syscall(SchedSetScheduler, pid, policy, param)
  if result < 0:
    errno = -result
    result = -1
