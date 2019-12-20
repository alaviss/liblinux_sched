import strutils, os, macros

const
  Project = "linux_sched"
  Version = [0, 1, 0]
  LibName = "lib$#.so" % [Project]
  SoName = "$#.$#" % [Libname, $Version[0]]

--app:lib
--gc:arc
--passC:"-fvisibility=hidden"
--define:noSignalHandler
--path:"nim-syscall/src"

if projectName() == Project:
  switch "passL", "-Wl,-soname," & SoName
  switch "out", SoName

mode = ScriptMode.Verbose
task build, "Build liblinux_sched":
  selfExec "c " & Project
  if not system.fileExists(LibName):
    exec quoteShellCommand ["ln", "-s", SoName, LibName]

const
  Prefix {.strdefine.} = "/usr"
  LibDir {.strdefine.} = "lib"

task install, "Install liblinux_sched":
  if not isAbsolute(Prefix):
    error "Prefix '$#' is not an absolute path" % Prefix
  let lib = if isAbsolute(LibDir): LibDir else: Prefix / LibDir
  exec quoteShellCommand ["install", "-Dm755", SoName, lib / SoName]
  exec quoteShellCommand ["install", "-Dm755", LibName, lib / LibName]
